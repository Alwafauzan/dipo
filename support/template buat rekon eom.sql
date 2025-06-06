BEGIN TRANSACTION 
	declare @code			   nvarchar(50)
			,@year			   nvarchar(4)
			,@month			   nvarchar(2)
			,@msg			   nvarchar(max)
			--,@p_cre_date			datetime =  '2023-12-31'
			,@p_cre_date	   datetime		= '2025-03-31 00:00:00.000'
			,@p_cre_ip_address nvarchar(15) = N'JOB'
			,@periode		   nvarchar(6) 
			--,@p_cre_date			datetime =  '2023-12-31'
			,@p_cre_by		   nvarchar(15) = N'JOB'
			,@system_date	   datetime = dbo.xfn_get_system_date()

begin try
		delete	IFINOPL.dbo.rpt_ext_overdue ;

		declare @tabel_agreement table
		(
			agreement_no nvarchar(50)
			,asset_no	 nvarchar(50)
			,amount		 decimal(18, 2)
		) ;

		begin
			insert into @tabel_agreement
			(
				agreement_no
				,asset_no
				,amount
			)
			select		agr.agreement_no
						,ai.asset_no
						,SUM(ai.AR_AMOUNT) - SUM(ISNULL(aip.payment_amount, 0)) AS ar_due
			FROM		[IFINOPL].dbo.AGREEMENT_INVOICE ai WITH (NOLOCK)
						OUTER APPLY
			(
				SELECT	crr.INVOICE_NO
						,ct.CASHIER_TRX_DATE
				FROM	ifinfin.dbo.CASHIER_TRANSACTION					  ct
						INNER JOIN ifinfin.dbo.CASHIER_TRANSACTION_DETAIL ctd WITH (NOLOCK)  ON (ctd.CASHIER_TRANSACTION_CODE = ct.CODE)
						INNER JOIN ifinfin.dbo.CASHIER_RECEIVED_REQUEST	  crr WITH (NOLOCK) ON (crr.CODE					   = ctd.RECEIVED_REQUEST_CODE)
				WHERE	crr.INVOICE_NO		  = ai.INVOICE_NO
						AND ct.CASHIER_STATUS = 'PAID'
			)											csh
						OUTER APPLY
			(
				SELECT	crr.invoice_no
						,depa.allocation_trx_date
				FROM	[ifinfin].dbo.DEPOSIT_ALLOCATION				   depa WITH (NOLOCK)
						INNER JOIN [ifinfin].dbo.DEPOSIT_ALLOCATION_DETAIL depad WITH (NOLOCK) ON depad.DEPOSIT_ALLOCATION_CODE = depa.CODE
						INNER JOIN [ifinfin].dbo.CASHIER_RECEIVED_REQUEST  crr WITH (NOLOCK) ON (crr.CODE						  = depad.RECEIVED_REQUEST_CODE)
				WHERE	crr.INVOICE_NO			   = ai.INVOICE_NO
						AND depa.allocation_status = 'APPROVE'
			) dep
						OUTER APPLY
			(
				SELECT		ap.INVOICE_NO
							,SUM(ap.PAYMENT_AMOUNT)																		 AS payment_amount
							,ISNULL(ISNULL(MAX(ct.CASHIER_TRX_DATE), MAX(DA.ALLOCATION_TRX_DATE)), MAX(ap.PAYMENT_DATE)) AS trx_date
				FROM		[IFINOPL].dbo.agreement_invoice_payment	  ap WITH (NOLOCK)
							LEFT JOIN ifinfin.dbo.CASHIER_TRANSACTION ct WITH (NOLOCK) ON ct.CODE = ap.TRANSACTION_NO
							LEFT JOIN IFINFIN.dbo.DEPOSIT_ALLOCATION  DA WITH (NOLOCK) ON DA.CODE = ap.TRANSACTION_NO
				WHERE		ai.CODE																										= ap.AGREEMENT_INVOICE_CODE
							AND ap.PAYMENT_AMOUNT																						<> 0
							AND CONVERT(NVARCHAR(8), ISNULL(ISNULL(ct.CASHIER_TRX_DATE, DA.ALLOCATION_TRX_DATE), ap.PAYMENT_DATE), 112) <= CONVERT(NVARCHAR(8), @p_cre_date, 112)
				GROUP BY	ap.INVOICE_NO
			) aip
						INNER JOIN [IFINOPL].dbo.Invoice		inv WITH (NOLOCK) ON inv.Invoice_No	= ai.invoice_no
						INNER JOIN [IFINOPL].dbo.Agreement_Main agr WITH (NOLOCK) ON agr.agreement_no = ai.agreement_no
			WHERE		((
							 CONVERT(NVARCHAR(8), ISNULL(csh.CASHIER_TRX_DATE, ISNULL(dep.allocation_trx_date, aip.trx_date)), 112) > CONVERT(NVARCHAR(8), @p_cre_date, 112)
							 OR aip.trx_date IS NULL
							 OR ((ai.AR_AMOUNT - ISNULL(aip.payment_amount, 0))														> 0)
						 )
						)
						--and ai.AGREEMENT_NO																								= '0001095.4.01.07.2022'
						AND inv.INVOICE_TYPE																						<> 'PENALTY' -- (+) 20240104 - Anas - invoice penalty tidak ikut dihitung
						AND CONVERT(NVARCHAR(8), inv.is_journal_date, 112)															<= CONVERT(NVARCHAR(8), @p_cre_date, 112)
			--from		[IFINOPL].dbo.AGREEMENT_INVOICE ai
			--			outer apply
			--(
			--	select	crr.INVOICE_NO
			--			,ct.CASHIER_TRX_DATE
			--	from	ifinfin.dbo.CASHIER_TRANSACTION ct
			--			inner join ifinfin.dbo.CASHIER_TRANSACTION_DETAIL ctd on (ctd.CASHIER_TRANSACTION_CODE = ct.CODE)
			--			inner join ifinfin.dbo.CASHIER_RECEIVED_REQUEST crr on (crr.CODE					   = ctd.RECEIVED_REQUEST_CODE)
			--	where	crr.INVOICE_NO		  = ai.INVOICE_NO
			--			and ct.CASHIER_STATUS = 'PAID'
			--) csh
			--			outer apply
			--(
			--	select	crr.invoice_no
			--			,depa.allocation_trx_date
			--	from	[ifinfin].dbo.DEPOSIT_ALLOCATION depa
			--			inner join [ifinfin].dbo.DEPOSIT_ALLOCATION_DETAIL depad on depad.DEPOSIT_ALLOCATION_CODE = depa.CODE
			--			inner join [ifinfin].dbo.CASHIER_RECEIVED_REQUEST crr on (crr.CODE						  = depad.RECEIVED_REQUEST_CODE)
			--	where	crr.INVOICE_NO			   = ai.INVOICE_NO
			--			and depa.allocation_status = 'APPROVE'
			--) dep
			--			outer apply
			--(
			--	select	ap.*
			--			,isnull(isnull(ct.CASHIER_TRX_DATE, DA.ALLOCATION_TRX_DATE), ap.PAYMENT_DATE) as trx_date
			--	from	[IFINOPL].dbo.agreement_invoice_payment ap
			--			left join ifinfin.dbo.CASHIER_TRANSACTION ct on ct.CODE = ap.TRANSACTION_NO
			--			left join IFINFIN.dbo.DEPOSIT_ALLOCATION DA on DA.CODE	= ap.TRANSACTION_NO
			--	where	ai.CODE																										= ap.AGREEMENT_INVOICE_CODE
			--			and ap.PAYMENT_AMOUNT																						> 0
			--			and convert(nvarchar(8), isnull(isnull(ct.CASHIER_TRX_DATE, DA.ALLOCATION_TRX_DATE), ap.PAYMENT_DATE), 112) <= convert(nvarchar(8), @asof_date, 112)
			--) aip
			--			inner join [IFINOPL].dbo.Invoice inv on inv.Invoice_No			= ai.invoice_no
			--			inner join [IFINOPL].dbo.Agreement_Main agr on agr.agreement_no = ai.agreement_no
			--where		((
			--				 convert(nvarchar(8), isnull(csh.CASHIER_TRX_DATE, isnull(dep.allocation_trx_date, aip.payment_date)), 112) > convert(nvarchar(8), @asof_date, 112)
			--				 or aip.payment_date is null
			--				 or ((ai.AR_AMOUNT - isnull(aip.payment_amount, 0))															> 0)
			--			 )
			--			)
			--			--and ai.AGREEMENT_NO = '0001184.4.08.10.2023'
			--			and inv.INVOICE_TYPE																							<> 'PENALTY' -- (+) 20240104 - Anas - invoice penalty tidak ikut dihitung
			--			and convert(nvarchar(8), inv.is_journal_date, 112)																<= convert(nvarchar(8), @asof_date, 112)
			GROUP BY	agr.agreement_no
						,ai.asset_no
			--ORDER BY	ai.asset_no
			--			,agr.agreement_no ;

			insert into @tabel_agreement
			(
				agreement_no
				,asset_no
				,amount
			)
			select		am.AGREEMENT_NO
						,ai.ASSET_NO
						,case -- menampilkan ar wapu yang terbentuk pada saat invoice tergenerate sampai dengan akhir bulan
							 when max(adh.BILLING_TO_FAKTUR_TYPE) = '01' then isnull(sum((aid.AR_AMOUNT) - isnull(aippp.AR_PAYMENT_AMOUNT, 0)) + 0, 0)
							 else isnull(sum((aid.AR_AMOUNT) - isnull(aippp.AR_PAYMENT_AMOUNT, 0)), 0) + isnull(sum(ppnwapu.ppn_amount_wapu), 0)
						 end 'Not Due'
			from		[IFINOPL].dbo.AGREEMENT_INVOICE			ai WITH (NOLOCK)
						inner join [IFINOPL].dbo.AGREEMENT_MAIN am WITH (NOLOCK) on am.AGREEMENT_NO = ai.AGREEMENT_NO
						inner join [IFINOPL].dbo.INVOICE		inv WITH (NOLOCK) on (inv.INVOICE_NO = ai.INVOICE_NO)
						outer apply
			(
				--ISNULL(sum(det.ppn_amount), 0) ppn_amount_wapu
				select	isnull(sum(ISNULL(det.ppn_amount - case
														when isnull(cnd.adjustment_amount, 0) > 0 then (isnull(det.ppn_amount, 0) - isnull(cnd.new_ppn_amount, 0))
														else 0
													end, 0)), 0) ppn_amount_wapu
				from	[IFINOPL].dbo.INVOICE					hd WITH (NOLOCK)
						inner join [IFINOPL].dbo.INVOICE_DETAIL det WITH (NOLOCK) on det.INVOICE_NO = hd.INVOICE_NO
						left join IFINOPL.dbo.credit_note cn WITH (NOLOCK) on (
															cn.invoice_no					  = hd.invoice_no
															and cn.status					  = 'post'
														)
						left join IFINOPL.dbo.credit_note_detail cnd WITH (NOLOCK) on (
																	cnd.credit_note_code	  = cn.code
																	and cnd.invoice_detail_id = det.id
																)
				where	hd.INVOICE_DATE			   <= @p_cre_date
						and det.AGREEMENT_NO	   = ai.AGREEMENT_NO
						and det.ASSET_NO		   = ai.ASSET_NO
						and hd.INVOICE_NO		   = ai.INVOICE_NO
						and hd.CRE_BY			   <> 'MIGRASI'
						and hd.IS_JOURNAL_PPN_WAPU = '0'
						and hd.INVOICE_STATUS not in
			(
				'NEW', 'CANCEL'
			)
			)													ppnwapu
						outer apply
			(
				select	sum(aid.ar_amount) ar_amount
				from	IFINOPL.dbo.AGREEMENT_INVOICE  aid WITH (NOLOCK)
						inner join IFINOPL.dbo.INVOICE inv WITH (NOLOCK) on (inv.INVOICE_NO = aid.INVOICE_NO)
				where	aid.CODE					= ai.CODE
						and
						(
							inv.is_journal_date is null
							or	inv.is_journal_date > @p_cre_date
						)
			) aid
						outer apply
			(
				select		isnull(sum(aip.PAYMENT_AMOUNT), 0)												 'AR_PAYMENT_AMOUNT'
							--,(isnull(isnull(ct.CASHIER_TRX_DATE, DA.ALLOCATION_TRX_DAte), aip.payment_date)) payment_date
				from		[IFINOPL].dbo.AGREEMENT_INVOICE_PAYMENT	  aip WITH (NOLOCK)
							inner join [IFINOPL].dbo.INVOICE		  IVP WITH (NOLOCK) on IVP.INVOICE_NO = aip.INVOICE_NO
							left join ifinfin.dbo.CASHIER_TRANSACTION ct WITH (NOLOCK) on ct.CODE			= aip.TRANSACTION_NO
							left join IFINFIN.dbo.DEPOSIT_ALLOCATION  DA WITH (NOLOCK) on DA.CODE			= aip.TRANSACTION_NO
				where		aip.AGREEMENT_INVOICE_CODE																		= ai.CODE
							and cast(isnull(isnull(ct.CASHIER_TRX_DATE, DA.ALLOCATION_TRX_DATE), aip.PAYMENT_DATE) as date) <= @p_cre_date
							--and aip.PAYMENT_AMOUNT																			> 0
							and aip.PAYMENT_AMOUNT																			<> 0 -- (+) Ari 2024-03-04 ket : mengikuti script daily balancing
							and
							(
								IVP.IS_JOURNAL_DATE is null
								or	IVP.IS_JOURNAL_DATE																		> @p_cre_date
							)
				--group by	(isnull(isnull(ct.CASHIER_TRX_DATE, DA.ALLOCATION_TRX_DATE), aip.PAYMENT_DATE))
				--			,isnull(ivp.total_ppn_amount, 0)
			) aippp
						outer apply
			(
				select	xiv.is_journal_date
						,xiv.IS_JOURNAL
						,xiv.BILLING_TO_FAKTUR_TYPE
				from	[IFINOPL].dbo.INVOICE xiv WITH (NOLOCK)
				where	xiv.INVOICE_NO = inv.INVOICE_NO
			) adh
			where		ai.INVOICE_DATE		 <= @p_cre_date
						and inv.INVOICE_TYPE <> 'PENALTY'
			group by	am.AGREEMENT_NO
						,ai.ASSET_NO
						,adh.BILLING_TO_FAKTUR_TYPE
						--,ppnwapu.ppn_amount_wapu ;

		--			,case -- menampilkan ar wapu yang terbentuk pada saat invoice tergenerate sampai dengan akhir bulan
		--				 when max(adh.BILLING_TO_FAKTUR_TYPE) = '01' then sum((ai.AR_AMOUNT) - isnull(aippp.AR_PAYMENT_AMOUNT, 0)) + 0
		--				 else sum((ai.AR_AMOUNT) - isnull(aippp.AR_PAYMENT_AMOUNT, 0)) + isnull(sum(adh3.ppn_amount_wapu), 0)
		--			 end 'Not Due'
		--from		[IFINOPL].dbo.AGREEMENT_INVOICE ai
		--			inner join [IFINOPL].dbo.AGREEMENT_MAIN am on am.AGREEMENT_NO = ai.AGREEMENT_NO
		--			inner join [IFINOPL].dbo.INVOICE inv on (inv.INVOICE_NO = ai.INVOICE_NO)
		--			outer apply
		--(
		--	select		isnull(sum(aip.PAYMENT_AMOUNT), 0) 'AR_PAYMENT_AMOUNT'
		--				,(isnull(isnull(ct.CASHIER_TRX_DATE, DA.ALLOCATION_TRX_DAte), aip.payment_date)) payment_date
		--	from		[IFINOPL].dbo.AGREEMENT_INVOICE_PAYMENT aip
		--				inner join [IFINOPL].dbo.INVOICE IVP on IVP.INVOICE_NO	= aip.INVOICE_NO
		--				left join ifinfin.dbo.CASHIER_TRANSACTION ct on ct.CODE = aip.TRANSACTION_NO
		--				left join IFINFIN.dbo.DEPOSIT_ALLOCATION DA on DA.CODE	= aip.TRANSACTION_NO
		--	where		aip.AGREEMENT_INVOICE_CODE																		= ai.CODE
		--				and cast(isnull(isnull(ct.CASHIER_TRX_DATE, DA.ALLOCATION_TRX_DATE), aip.PAYMENT_DATE) as date) <= @asof_date
		--				and aip.PAYMENT_AMOUNT																			> 0
		--	group by	(isnull(isnull(ct.CASHIER_TRX_DATE, DA.ALLOCATION_TRX_DATE), aip.PAYMENT_DATE))
		--				,isnull(ivp.total_ppn_amount, 0)
		--) aippp
		--			outer apply
		--(
		--	select		isnull(sum(det.PPN_AMOUNT), 0) ppn_amount
		--				,det.INVOICE_NO
		--	from		[IFINOPL].dbo.INVOICE_DETAIL det
		--	where		ai.INVOICE_NO											= det.INVOICE_NO
		--				and det.AGREEMENT_NO									= ai.AGREEMENT_NO
		--				and det.ASSET_NO										= ai.ASSET_NO
		--				and det.BILLING_NO										= ai.BILLING_NO
		--				and (ai.AR_AMOUNT) - isnull(aippp.AR_PAYMENT_AMOUNT, 0) > 0
		--	group by	det.INVOICE_NO
		--) adh2
		--			outer apply
		--(
		--	select	isnull(sum(det.PPN_AMOUNT), 0) ppn_amount_wapu
		--	from	[IFINOPL].dbo.INVOICE_DETAIL det
		--			inner join [IFINOPL].dbo.INVOICE hd on hd.INVOICE_NO					 = det.INVOICE_NO
		--			inner join [IFINOPL].dbo.AGREEMENT_INVOICE aginv on aginv.INVOICE_NO	 = hd.INVOICE_NO
		--																and aginv.ASSET_NO	 = det.ASSET_NO
		--																and aginv.BILLING_NO = det.BILLING_NO
		--	where	aginv.AGREEMENT_NO								  = ai.AGREEMENT_NO
		--			and aginv.INVOICE_NO							  = ai.INVOICE_NO
		--			and aginv.ASSET_NO								  = ai.ASSET_NO
		--			and aginv.BILLING_NO							  = ai.BILLING_NO
		--			and convert(nvarchar(6), aginv.INVOICE_DATE, 112) >= convert(nvarchar(6), @asof_date, 112)
		--) adh3
		--			outer apply
		--(
		--	select	xiv.is_journal_date
		--			,xiv.IS_JOURNAL
		--			,xiv.BILLING_TO_FAKTUR_TYPE
		--	from	[IFINOPL].dbo.INVOICE xiv
		--	where	xiv.INVOICE_NO = inv.INVOICE_NO
		--) adh
		--where		ai.INVOICE_DATE				<= @asof_date
		--			and inv.INVOICE_TYPE		<> 'PENALTY'
		--			and
		--			(
		--				adh.IS_JOURNAL_DATE is null
		--				or	adh.IS_JOURNAL_DATE > @asof_date
		--			)
		--group by	am.AGREEMENT_NO
		--			,ai.ASSET_NO ;
		end ;



		insert into IFINOPL.dbo.rpt_ext_overdue
		(
			eom
			,agrmntno
			,currency
			,paymentbalance
			,assetconditionid
			,assettypeid
			,assetbrandid
			,assetbrandtypeid
			,assetbrandtypename
			,assetmodelid
			--
			,cre_date
			,cre_by
			,cre_ip_address
			,mod_date
			,mod_by
			,mod_ip_address
		)
		select		eomonth(@p_cre_date)
					,am.agreement_external_no
					,am.currency_code
					,ISNULL(sum(xar.amount),0)
																												--,sum(ai.AR_AMOUNT - isnull(aippp.AR_PAYMENT_AMOUNT,0)) 'OUTSTANDING AR'
					,aa.asset_condition
					,case aa.asset_type_code
						 when 'VHCL' then '1'
						 when 'HE' then '2'
						 else 'NA'
					 end
					,aav.vehicle_merk_code
					--,aav.vehicle_type_code
					,aa.ASSET_NO
					,aa.asset_name
					,right(aav.VEHICLE_type_CODE, len(aav.VEHICLE_type_CODE) - 1 - len(aav.VEHICLE_MODEL_CODE)) --aav.vehicle_model_code
																												----
					--,@p_cre_date
					,dbo.xfn_get_system_date()
					,@p_cre_by
					,@p_cre_ip_address
					--,@p_cre_date
					,dbo.xfn_get_system_date()
					,@p_cre_by
					,@p_cre_ip_address
		FROM	IFINOPL.dbo.agreement_main					   am WITH (NOLOCK) --	on am.agreement_no = ai.agreement_no
		inner join IFINOPL.dbo.agreement_asset		   aa WITH (NOLOCK) on aa.agreement_no = am.agreement_no -- and ai.ASSET_NO = aa.ASSET_NO 
		inner join IFINOPL.dbo.agreement_asset_vehicle aav WITH (NOLOCK) on (aav.asset_no = aa.asset_no)
		outer apply
		(
			select		--top 1
						isnull(sum(taa.amount), 0) amount
			from		@tabel_agreement taa
			where		taa.asset_no = aa.ASSET_NO
			--group by	taa.asset_no
		)												   xar
		--left join	dbo.invoice				inv on (inv.invoice_no = ai.invoice_no)
		--outer apply (
		--				select isnull(sum(aip.payment_amount), 0) 'ar_payment_amount' 
		--				from   dbo.agreement_invoice_payment aip
		--				inner join dbo.invoice ivp on ivp.invoice_no = aip.invoice_no
		--				left join ifinfin.dbo.cashier_transaction ct on ct.code = aip.transaction_no
		--				left join ifinfin.dbo.deposit_allocation da on da.code = aip.transaction_no
		--				where  aip.agreement_invoice_code = ai.code --AND aip.CRE_BY IN ( 'MIGRASI', 'PAID_RECON')	
		--					   --and  (isnull(isnull(ct.CASHIER_TRX_DATE, DA.ALLOCATION_TRX_DATE), aip.PAYMENT_DATE))		  <= '2023-10-31'
		--					   and  (isnull(isnull(ct.CASHIER_TRX_DATE, DA.ALLOCATION_TRX_DATE), aip.PAYMENT_DAte))		  <= @p_cre_date
		--					   and aip.payment_amount > 0
		--					   and aip.asset_no = ai.asset_no
		--					   group by (isnull(isnull(ct.cashier_trx_date, da.allocation_trx_date), aip.payment_date))
		--			)					  aippp

		--where		ai.INVOICE_DATE		 <= @p_cre_date
		--			and inv.INVOICE_TYPE <> 'PENALTY'
		--WHERE aa.FA_CODE NOT IN(
		--'2008.AST.2404.00004'
		--,'2008.AST.2404.00005'
		--,'2008.AST.2404.00006'
		--,'2008.AST.2405.00010'
		--,'2008.AST.2405.00011'
		--,'4120032521'
		--,'4120032522'
		--,'4120042026'
		--,'4120042027'
		--,'4120042028'
		--,'4120042029'
		--,'4120042037'
		--,'4120042038'
		--,'4120042094'
		--,'4120042097'
		--,'4120042098'
		--,'4120042120'
		--,'4120042122'
		--,'4120042123'
		--,'4120042124'
		--,'4120042125'
		--,'4120042126'
		--,'4120042127'
		--,'4120042128'
		--,'4120042129'
		--,'4120042130'
		--,'4120042131'
		--,'4120042314'
		--,'4120042315'
		--,'4120042316'
		--,'4120042318'
		--,'4120042320'
		--,'4120042321'
		--,'4120042869')
		group by	am.agreement_external_no
					,am.currency_code
					,aa.asset_condition
					,case aa.asset_type_code
						 when 'VHCL' then '1'
						 when 'HE' then '2'
						 else 'NA'
					 end
					,aav.vehicle_merk_code
					,aav.vehicle_type_code
					,aa.asset_name
					,aa.asset_no
					,right(aav.VEHICLE_type_CODE, len(aav.VEHICLE_type_CODE) - 1 - len(aav.VEHICLE_MODEL_CODE)) --aav.vehicle_model_code
		--having		sum(xar.amount) > 0 ;

	--select	EOMONTH(@p_cre_date)
	--		,am.agreement_external_no
	--		,am.currency_code
	--		,jd.orig_amount_db - jd.orig_amount_cr
	--		,am.asset_condition
	--		,case am.ASSET_TYPE_CODE WHEN 'VHCL' THEN '1'
	--			WHEN 'HE' THEN '2'
	--			ELSE 'NA'
	--		end -- 1 vehicle, 2 he , else NA
	--		,am.merk_code
	--		,am.vehicle_type_code
	--		,am.ASSET_NAME
	--		,am.model_code
	--		----
	--		,@p_cre_date
	--		,@p_cre_by
	--		,@p_cre_ip_address
	--		,@p_cre_date
	--		,@p_cre_by
	--		,@p_cre_ip_address
	--from	ifinacc.dbo.journal_detail jd
	--		inner join ifinacc.dbo.journal jo on (jo.code = jd.journal_code)
	--		outer apply
	--(
	--	select	top 1
	--			am.agreement_external_no
	--			,aa.asset_condition
	--			,aav.vehicle_type_code 
	--			,aav.vehicle_merk_code 'merk_code'
	--			,aa.asset_type_code
	--			,aa.asset_name
	--			,am.currency_code
	--			,right(aav.vehicle_type_code, len(aav.vehicle_type_code)-1-len(aav.vehicle_model_code)) model_code
	--	from	dbo.agreement_main am
	--			inner join dbo.agreement_asset aa on (aa.agreement_no		  = am.agreement_no)
	--			inner join dbo.sys_general_subcode sgs on (sgs.code			  = aa.asset_type_code)
	--			left join dbo.agreement_asset_vehicle aav on (aav.asset_no	  = aa.asset_no)
	--			--left join dbo.agreement_asset_machine aam on (aam.asset_no	  = aa.asset_no)
	--			--left join dbo.agreement_asset_he aah on (aah.asset_no		  = aa.asset_no)
	--			--left join dbo.agreement_asset_electronic aae on (aae.asset_no = aa.asset_no)
	--	where	am.agreement_no = jd.agreement_no
	--) am
	--where	jd.account_no in
	--(
	--	'20401100', '20401101'
	--)
	--AND convert(varchar(6), jo.journal_trx_date, 112)  =  convert(varchar(6), @p_cre_date, 112) 
	

	-- (+) Ari 2024-02-12 ket : add log
	begin
	delete IFINOPL.dbo.rpt_ext_overdue_log where eom = @p_cre_date

		insert into IFINOPL.dbo.rpt_ext_overdue_log
		(
			eom
			,agrmntno
			,currency
			,paymentbalance
			,assetconditionid
			,assettypeid
			,assetbrandid
			,assetbrandtypeid
			,assetbrandtypename
			,assetmodelid
			,cre_date
			,cre_by
			,cre_ip_address
			,mod_date
			,mod_by
			,mod_ip_address
		)
		select	eom
			   ,agrmntno
			   ,currency
			   ,paymentbalance
			   ,assetconditionid
			   ,assettypeid
			   ,assetbrandid
			   ,assetbrandtypeid
			   ,assetbrandtypename
			   ,assetmodelid
			   ,cre_date
			   ,cre_by
			   ,cre_ip_address
			   ,mod_date
			   ,mod_by
			   ,mod_ip_address 
		from	IFINOPL.dbo.rpt_ext_overdue
	end
	
	end try
	begin catch
		if (len(@msg) <> 0)
		begin
			set @msg = N'v' + N';' + @msg ;
		end ;
		else
		begin
			set @msg = N'e;there is an error.' + N';' + error_message() ;
		end ;

		raiserror(@msg, 16, -1) ;

		return ;
	end catch ;

---------------------------------------------------------------------------------------------------------------------------------------------------------------------------

begin
--xsp_rpt_ext_net_asset_depre_insert

	if (@p_cre_date < eomonth(@p_cre_date)) -- (+) Ari 2024-02-05 ket : get last eom
	begin
		set @p_cre_date = dateadd(month, -1, @p_cre_date) ;
		set @p_cre_date = eomonth(@p_cre_date) ;
	end ;

	begin try
		set @year = year(@p_cre_date) ;
		set @month = month(@p_cre_date) ;
		set @periode = cast(@year as nvarchar(4)) + cast(@month as nvarchar(2)) ;

		delete	dbo.rpt_ext_net_asset_depre ;

		insert into rpt_ext_net_asset_depre
		(
			eom
			,assetno
			,amt
			,assetconditionid
			,assettypeid
			,assetbrandid
			,assetbrandtypeid
			,assetbrandtypename
			,assetmodelid
			--						
			,cre_date
			,cre_by
			,cre_ip_address
			,mod_date
			,mod_by
			,mod_ip_address
		)
		select	eomonth(@p_cre_date)
				,ast.code
				,xschedule.total_depre
				,ast.condition
				,case ast.TYPE_CODE
					 when 'VHCL' then '1'
					 when 'HE' then '2'
					 else 'NA'
				 end	-- 1 vehicle, 2 he , else NA
				,av.MERK_CODE--ast.merk_code
				,av.TYPE_ITEM_CODE--ast.type_code_asset
				,av.TYPE_ITEM_NAME--ast.type_name_asset
				,right(av.type_item_code, len(av.type_item_code) - 1 - len(av.model_code))
						--
						--,@p_cre_date
				,dbo.xfn_get_system_date()
				,@p_cre_by
				,@p_cre_ip_address
						--,@p_cre_date
				,dbo.xfn_get_system_date()
				,@p_cre_by
				,@p_cre_ip_address
		from	XXX_ASSET_AFTER_31032025						 ast
				inner join dbo.asset_vehicle av on av.asset_code = ast.code
				outer apply
		(
			select	sum(adc.depreciation_amount) total_depre
			from	dbo.XXX_ASSET_DEPRECIATION_SCHEDULE_COMMERCIAL_AFTER_31032025 adc
			where	adc.asset_code			  = ast.code
					and adc.DEPRECIATION_DATE <= @p_cre_date
		)									 xschedule
		where	ast.PURCHASE_DATE						   <= @p_cre_date
				and
				(
					ast.SALE_DATE is null
					or	ast.SALE_DATE					   > @p_cre_date
				)
				and
				(
					ast.DISPOSAL_DATE is null
					or	ast.DISPOSAL_DATE				   > @p_cre_date
				)
				and ast.STATUS not in
		(
			'CANCEL', 'hold'
		)
				and
				(
					ast.PERMIT_SELL_DATE is null
					or	cast(ast.PERMIT_SELL_DATE as date) > @p_cre_date
				)
				or ast.CODE  IN (
		'2008.AST.2404.00004'
		,'2008.AST.2404.00005'
		,'2008.AST.2404.00006'
		,'2008.AST.2405.00010'
		,'2008.AST.2405.00011'
		,'4120032521'
		,'4120032522'
		,'4120042026'
		,'4120042027'
		,'4120042028'
		,'4120042029'
		,'4120042037'
		,'4120042038'
		,'4120042094'
		,'4120042097'
		,'4120042098'
		,'4120042120'
		,'4120042122'
		,'4120042123'
		,'4120042124'
		,'4120042125'
		,'4120042126'
		,'4120042127'
		,'4120042128'
		,'4120042129'
		,'4120042130'
		,'4120042131'
		,'4120042314'
		,'4120042315'
		,'4120042316'
		,'4120042318'
		,'4120042320'
		,'4120042321'
		,'4120042869')
		--SELECT * FROM rpt_ext_net_asset_depre

		--		and ast.CODE not in
		--(
		--	'2008.AST.2401.00029', '2008.AST.2401.00032', '2008.AST.2401.00033'
		--) ;
	

	-- (+) Ari 2024-02-05 ket : add log
	BEGIN
    
		DELETE dbo.rpt_ext_net_asset_depre_log WHERE eom = @p_cre_date
        
		insert into dbo.rpt_ext_net_asset_depre_log
		(
			eom
			,assetno
			,amt
			,assetconditionid
			,assettypeid
			,assetbrandid
			,assetbrandtypeid
			,assetbrandtypename
			,assetmodelid
			,cre_date
			,cre_by
			,cre_ip_address
			,mod_date
			,mod_by
			,mod_ip_address
		)
		select	eom
			   ,assetno
			   ,amt
			   ,assetconditionid
			   ,assettypeid
			   ,assetbrandid
			   ,assetbrandtypeid
			   ,assetbrandtypename
			   ,assetmodelid
			   ,cre_date
			   ,cre_by
			   ,cre_ip_address
			   ,mod_date
			   ,mod_by
			   ,mod_ip_address 
		from	rpt_ext_net_asset_depre
	end

	end try
	begin catch
		declare @error int ;

		set @error = @@error ;

		if (@error = 2627)
		begin
			set @msg = dbo.xfn_get_msg_err_code_already_exist() ;
		end ;

		if (len(@msg) <> 0)
		begin
			set @msg = N'v' + N';' + @msg ;
		end ;
		else
		begin
			if (
				   error_message() like '%v;%'
				   or	error_message() like '%e;%'
			   )
			begin
				set @msg = error_message() ;
			end ;
			else
			begin
				set @msg = N'e;' + dbo.xfn_get_msg_err_generic() + N';' + error_message() ;
			end ;
		end ;

		raiserror(@msg, 16, -1) ;

		return ;
	end catch ;
end ;
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--xsp_rpt_ext_net_asset_cost_price_insert

begin


	if (@p_cre_date < eomonth(@p_cre_date)) -- (+) Ari 2024-02-05 ket : get last eom
	begin
		set @p_cre_date = dateadd(month, -1, @p_cre_date) ;
		set @p_cre_date = eomonth(@p_cre_date) ;
	end ;

	begin try
		set @year = year(@p_cre_date) ;
		set @month = month(@p_cre_date) ;
		set @periode = @year + @month ;

		-- delete berdasarkan bulan dan tahun EOM
		delete	dbo.RPT_EXT_NET_ASSET_COST_PRICE ;

		--where	month(eom) = month(@p_cre_date)
		--and		year(eom) = year(@p_cre_date)
		--insert data asset yang period commercial nya sama dengan period EOM
		insert into RPT_EXT_NET_ASSET_COST_PRICE
		(
			EOM
			,ASSETNO
			,COSTPRICE
			,ASSETCONDITIONID
			,ASSETTYPEID
			,ASSETBRANDID
			,ASSETBRANDTYPEID
			,ASSETBRANDTYPENAME
			,ASSETMODELID
			,CRE_DATE
			,CRE_BY
			,CRE_IP_ADDRESS
			,MOD_DATE
			,MOD_BY
			,MOD_IP_ADDRESS
		)
		select	eomonth(@p_cre_date)
				,ast.CODE
				,ast.PURCHASE_PRICE
				,ast.CONDITION
				,case ast.TYPE_CODE
					when 'VHCL' then
						'1'
					when 'HE' then
						'2' else 'NA'
				end						-- 1 vehicle, 2 he , else NA
				,av.MERK_CODE			--ast.merk_code
				,av.TYPE_ITEM_CODE		--ast.type_code_asset
				,av.TYPE_ITEM_NAME		--ast.type_name_asset
				,right(av.TYPE_ITEM_CODE, len(av.TYPE_ITEM_CODE) - 1 - len(av.MODEL_CODE))
										--
										--,@p_cre_date
				,dbo.xfn_get_system_date()
				,@p_cre_by
				,@p_cre_ip_address
										--,@p_cre_date
				,dbo.xfn_get_system_date()
				,@p_cre_by
				,@p_cre_ip_address
		--from	dbo.ASSET_AGING				aa
		--		inner join ASSET			ast on aa.CODE	= ast.CODE
		--		inner join dbo.ASSET_VEHICLE av on av.ASSET_CODE = ast.CODE
		--where aa.AGING_DATE														= '2024-12-02'
		--	and ast.PURCHASE_DATE													<= '2024-11-30'
		--	and
		--	(
		--			ast.SALE_DATE is null or ast.SALE_DATE						> '2024-11-30'
		--		)
		--	and
		--	(
		--			ast.DISPOSAL_DATE is null or ast.DISPOSAL_DATE				> '2024-11-30'
		--		)
		--	and ast.STATUS not in ('CANCEL', 'HOLD')
		--	and
		--	(
		--			ast.PERMIT_SELL_DATE is null or cast(ast.PERMIT_SELL_DATE as date) > '2024-11-30'
		--		)
		--	and aa.CODE not in 
		from	dbo.XXX_ASSET_AFTER_31032025						 ast
				inner join dbo.asset_vehicle av on av.asset_code = ast.code
		where	ast.PURCHASE_DATE						   <= @p_cre_date
				and
				(
					ast.SALE_DATE is null
					or	ast.SALE_DATE					   > @p_cre_date
				)
				and
				(
					ast.DISPOSAL_DATE is null
					or	ast.DISPOSAL_DATE				   > @p_cre_date
				)
				and ast.STATUS not in
		(
			'CANCEL', 'HOLD'
		)
		and
		(
			ast.PERMIT_SELL_DATE is null
			or	cast(ast.PERMIT_SELL_DATE as date) > @p_cre_date
		)
		and	ast.asset_from = 'BUY'
		or ast.CODE  IN (
		'2008.AST.2404.00004'
		,'2008.AST.2404.00005'
		,'2008.AST.2404.00006'
		,'2008.AST.2405.00010'
		,'2008.AST.2405.00011'
		,'4120032521'
		,'4120032522'
		,'4120042026'
		,'4120042027'
		,'4120042028'
		,'4120042029'
		,'4120042037'
		,'4120042038'
		,'4120042094'
		,'4120042097'
		,'4120042098'
		,'4120042120'
		,'4120042122'
		,'4120042123'
		,'4120042124'
		,'4120042125'
		,'4120042126'
		,'4120042127'
		,'4120042128'
		,'4120042129'
		,'4120042130'
		,'4120042131'
		,'4120042314'
		,'4120042315'
		,'4120042316'
		,'4120042318'
		,'4120042320'
		,'4120042321'
		,'4120042869')


		SELECT * FROM RPT_EXT_NET_ASSET_COST_PRICE

		delete	dbo.RPT_EXT_NET_ASSET_COST_PRICE_LOG
		where EOM = @p_cre_date ;

		begin
			insert into dbo.RPT_EXT_NET_ASSET_COST_PRICE_LOG
			(
				EOM
				,ASSETNO
				,COSTPRICE
				,ASSETCONDITIONID
				,ASSETTYPEID
				,ASSETBRANDID
				,ASSETBRANDTYPEID
				,ASSETBRANDTYPENAME
				,ASSETMODELID
				,CRE_DATE
				,CRE_BY
				,CRE_IP_ADDRESS
				,MOD_DATE
				,MOD_BY
				,MOD_IP_ADDRESS
			)
			select	EOM
					,ASSETNO
					,COSTPRICE
					,ASSETCONDITIONID
					,ASSETTYPEID
					,ASSETBRANDID
					,ASSETBRANDTYPEID
					,ASSETBRANDTYPENAME
					,ASSETMODELID
					,CRE_DATE
					,CRE_BY
					,CRE_IP_ADDRESS
					,MOD_DATE
					,MOD_BY
					,MOD_IP_ADDRESS
			from	RPT_EXT_NET_ASSET_COST_PRICE ;
		end ;


	end try
	begin catch

		set @error = @@error ;

		if (@error = 2627)
		begin
			set @msg = dbo.xfn_get_msg_err_code_already_exist() ;
		end ;

		if (len(@msg) <> 0)
		begin
			set @msg = N'v' + N';' + @msg ;
		end ;
		else
		begin
			if (error_message() like '%v;%' or error_message() like '%e;%')
			begin
				set @msg = error_message() ;
			end ;
			else
			begin
				set @msg = N'e;' + dbo.xfn_get_msg_err_generic() + N';' + error_message() ;
			end ;
		end ;

		raiserror(@msg, 16, -1) ;

		return ;
	end catch ;
end ;

---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--BEGIN


--	select	
--			--@p_cre_date
--			--,isnull(ast.agreement_external_no,ast.code) 'AGRMNTNO'
--			--,cost.assetconditionid
--			--,cost.assetmodelid
--			--,isnull(cost.costprice,0)
--			--,isnull(depre.amt,0) 'DEPREAMT'
--			--,isnull(ovd.paymentbalance,0)
--			--,@p_cre_by
--			--,@system_date
--			--,@p_cre_ip_address
--			--,@p_cre_by
--			--,@system_date
--			--,@p_cre_ip_address
--			SUM(isnull(depre.amt,0))
--			,SUM(isnull(ovd.paymentbalance,0))
--			,SUM(isnull(cost.costprice,0))
--	from	ifinams.dbo.asset ast 
--	left	join ifinams.dbo.rpt_ext_net_asset_cost_price cost on  (ast.code = cost.assetno)
--	left	join ifinams.dbo.rpt_ext_net_asset_depre depre on (depre.assetno = cost.assetno)
--	left	join (

--					select	--agrmntno
--							sum(paymentbalance) 'paymentbalance'
--							,isnull(isnull(ass.fa_code,ass.replacement_fa_code),'') 'fa_code'
--					from	ifinopl.dbo.rpt_ext_overdue ovd
--					inner	join ifinopl.dbo.agreement_asset ass on (ass.asset_no = ovd.assetbrandtypeid)
--					group by isnull(isnull(ass.fa_code,ass.replacement_fa_code),'')
--							 --,ovd.agrmntno
--					) ovd on ovd.fa_code  = ast.code
--END
EXEC dbo.xsp_rpt_ext_costprice_depreamt_overdue
SELECT SUM(COSTPRICE),SUM(DEPREAMT),SUM(PAYMENTBALANCE) FROM dbo.RPT_EXT_COSTPRICE_DEPREAMT_OVERDUE
COMMIT TRANSACTION