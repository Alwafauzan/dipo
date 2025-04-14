begin transaction 

declare @eod_date	 datetime = GETDATE()

select		agr.agreement_external_no
			,agr.agreement_date
			,agr.client_no
			,agr.client_name
			,count(invd.asset_no)	'jumlah_unit'
			,agr.periode			'tenor'
			,ags.rental_amount
			,agr.credit_term				'top_days'
			,inv.invoice_due_date
			,inv.invoice_external_no		'invoice_no'

			,sum(invd.billing_amount)		'rental_amount'
			--
			,case when inv.invoice_type = 'rental' then 
					case when inv.billing_to_faktur_type = '01' then isnull(sum(cn.new_rental_amount),sum(invd.billing_amount)) + isnull(sum(cn.new_ppn_amount),sum(invd.ppn_amount)) - isnull(sum(invd.discount_amount),0)
						else isnull(sum(cn.new_rental_amount),sum(invd.billing_amount))
					end
				else isnull(sum(cn.new_rental_amount),sum(invd.billing_amount)) + isnull(sum(cn.new_ppn_amount),sum(invd.ppn_amount)) - isnull(sum(invd.discount_amount),0)
			end'overdue_amount_inc_vat'
			--
			,isnull(sum(cn.new_rental_amount),sum(invd.billing_amount)) - isnull(sum(invd.discount_amount),0)'overdue_amount_exc_vat'
			,datediff(day, invoice_due_date, dateadd(day,-1,@eod_date))'ovd_days'
			--
from		[ifinopl].dbo.invoice inv with (nolock) 
			inner join ifinopl.dbo.invoice_detail invd on invd.invoice_no = inv.invoice_no 
			inner join [ifinopl].dbo.agreement_main agr with (nolock) on agr.agreement_no = invd.agreement_no
			--
			outer apply (	select	max(ags.asset_name) 'asset_name'
									,max(ags.monthly_rental_rounded_amount) 'rental_amount'
							from	dbo.agreement_asset ags 
							where	ags.asset_no = invd.asset_no
							and		invd.invoice_no = inv.invoice_no
						) ags
			outer apply (	select	crnd.new_rental_amount
									,crnd.new_ppn_amount
									,crnd.adjustment_amount
									,crnd.new_pph_amount
									,crnd.new_total_amount
							from	dbo.credit_note cn
									inner join dbo.credit_note_detail crnd on crnd.invoice_no = cn.invoice_no
							where	cn.invoice_no = inv.invoice_no and crnd.invoice_detail_id = invd.id
							and		cn.status = 'post'
						) cn
			outer apply (
							select	ama.marketing_name
									,head.name								'marketing_leader'
							from	ifinopl.dbo.agreement_main ama
									left join ifinsys.dbo.sys_employee_main sem on sem.code = ama.marketing_code
									left join ifinsys.dbo.sys_employee_main head on head.code = sem.head_emp_code
							where	ama.agreement_no = invd.agreement_no
						)agrm
			outer apply (
						select	count(distinct invp.invoice_no) 'invoice_paid' 
						from	ifinopl.dbo.invoice_detail invdp
								inner join ifinopl.dbo.invoice invp on invp.invoice_no = invdp.invoice_no
						where	invdp.agreement_no = invd.agreement_no
						and		invp.invoice_status = 'paid'
			) invp
			outer apply (
						select	count(distinct invp.invoice_no) 'invoice_notdue' 
						from	ifinopl.dbo.invoice_detail invdp
								inner join ifinopl.dbo.invoice invp on invp.invoice_no = invdp.invoice_no
						where	invdp.agreement_no = invd.agreement_no
						and		invp.invoice_status = 'post'
						and		invp.invoice_due_date >= @eod_date
			) invdn
where		(case(inv.invoice_type) when 'penalty' then convert(nvarchar(8), inv.invoice_due_date, 112) 
			else  convert(nvarchar(8), inv.is_journal_date, 112) end)	< convert(nvarchar(8), @eod_date, 112)
			and cast(inv.invoice_due_date as date) < @eod_date
			and inv.invoice_status = 'post'
group by	agr.agreement_external_no
			,agr.agreement_date
			,agr.client_no
			,agr.client_name 
			,ags.asset_name		
			,agr.periode
			,ags.rental_amount
			,agr.credit_term
			,inv.invoice_due_date
			,inv.invoice_external_no
			,inv.invoice_type
			,inv.billing_to_faktur_type

rollback transaction 