BEGIN TRANSACTION 

DECLARE     @AGREEMENT_NO VARCHAR(20) = '0002241/4/38/05/2024'
SELECT		'HANDOVER_ASSET',STATUS,* FROM IFINAMS.dbo.HANDOVER_ASSET WHERE REMARK like '%'+replace(@AGREEMENT_NO,'.','/')+'%'
SELECT		'HANDOVER_REQUEST',STATUS,* FROM IFINAMS.dbo.HANDOVER_REQUEST WHERE REMARK like '%'+replace(@AGREEMENT_NO,'.','/')+'%'
select		'MATURITY'
			,ma.code
			,dbo.xfn_agreement_get_os_principal(am.agreement_no, dbo.xfn_get_system_date(), null) 'outstanding_rental'
			,dbo.xfn_agreement_get_ovd_rental_amount(am.agreement_no, null) 'overdue_invice'
			,am.agreement_external_no
			,ma.agreement_no
			,am.client_name
			,convert(nvarchar(15), ma.date, 103) 'agreement_date'
			,ma.branch_code
			,ma.branch_name
			,ma.status
			,*
				FROM maturity ma INNER join dbo.agreement_main am on (am.agreement_no = ma.agreement_no) WHERE am.AGREEMENT_NO = replace(@AGREEMENT_NO,'/','.')
SELECT		'AGREEMENT_ASSET',ASSET_STATUS,* FROM dbo.AGREEMENT_ASSET WHERE AGREEMENT_NO = replace(@AGREEMENT_NO,'/','.')
SELECT		'AGREEMENT_MAIN',AGREEMENT_STATUS,* FROM dbo.AGREEMENT_MAIN WHERE AGREEMENT_NO = replace(@AGREEMENT_NO,'/','.')
SELECT      'MTN_DATA_DSF_LOG',* FROM dbo.MTN_DATA_DSF_LOG WHERE REFF_1 = replace(@AGREEMENT_NO,'/','.')


declare @agreement_no_ex nvarchar(50) = '0002241/4/38/05/2024'
		--,@agreement_no nvarchar(50)
		,@client_no nvarchar(50)
		,@client_name nvarchar(250)
		,@asset_no nvarchar(50)
		,@p_fa_code nvarchar(50)

SELECT @agreement_no = am.AGREEMENT_NO
		,@client_no = am.CLIENT_NO
		,@client_name = am.CLIENT_NAME
		,@asset_no = ass.ASSET_NO
		,@p_fa_code = ass.FA_CODE
from dbo.AGREEMENT_MAIN am
INNER JOIN dbo.AGREEMENT_ASSET ass on ass.AGREEMENT_NO = am.AGREEMENT_NO
where AGREEMENT_EXTERNAL_NO = @agreement_no_ex

update	IFINAMS.dbo.asset
set		fisical_status			= 'ON CUSTOMER'
		,rental_status			= 'IN USE'
		,agreement_no			= @agreement_no
		,agreement_external_no	= @agreement_no_ex
		,client_no				= @client_no
		,client_name			= @client_name
		,asset_no				= @asset_no
		,re_rent_status			= 'IN USE'
		--
		,mod_date				= getdate()	  
		,mod_by					= 'MTN_RAFFI'		  
		,mod_ip_address			= 'MF_503468'
where	code = @p_fa_code ;

SELECT * FROM IFINAMS.dbo.ASSET where CODE = @p_fa_code

exec dbo.xsp_mtn_hold_maturity_v2 @p_agreement_no = @agreement_no	-- nvarchar(50)
							,@p_mod_by = 'MTN_RAFFI'			-- nvarchar(50)

insert into dbo.MTN_DATA_DSF_LOG
(
	MAINTENANCE_NAME
	,REMARK
	,TABEL_UTAMA
	,REFF_1
	,REFF_2
	,REFF_3
	,CRE_DATE
	,CRE_BY
)
values
(	'MTURITY HOLD'	-- MAINTENANCE_NAME - nvarchar(50)
	,'MF 503468'	-- REMARK - nvarchar(4000)
	,'MATURITY'	-- TABEL_UTAMA - nvarchar(50)
	,'0000328.4.01.08.2019'	-- REFF_1 - nvarchar(50)
	,null	-- REFF_2 - nvarchar(50)
	,null	-- REFF_3 - nvarchar(50)
	,'2024-12-10'	-- CRE_DATE - datetime
	,'MTN_RAFFI'	-- CRE_BY - nvarchar(250)
	)

--DECLARE     @AGREEMENT_NO VARCHAR(20) = '0002241/4/38/05/2024'
SELECT		'HANDOVER_ASSET',STATUS,* FROM IFINAMS.dbo.HANDOVER_ASSET WHERE REMARK like '%'+replace(@AGREEMENT_NO,'.','/')+'%'
SELECT		'HANDOVER_REQUEST',STATUS,* FROM IFINAMS.dbo.HANDOVER_REQUEST WHERE REMARK like '%'+replace(@AGREEMENT_NO,'.','/')+'%'
select		'MATURITY'
			,ma.code
			,dbo.xfn_agreement_get_os_principal(am.agreement_no, dbo.xfn_get_system_date(), null) 'outstanding_rental'
			,dbo.xfn_agreement_get_ovd_rental_amount(am.agreement_no, null) 'overdue_invice'
			,am.agreement_external_no
			,ma.agreement_no
			,am.client_name
			,convert(nvarchar(15), ma.date, 103) 'agreement_date'
			,ma.branch_code
			,ma.branch_name
			,ma.status
			,*
				FROM maturity ma INNER join dbo.agreement_main am on (am.agreement_no = ma.agreement_no) WHERE am.AGREEMENT_NO = replace(@AGREEMENT_NO,'/','.')
SELECT		'AGREEMENT_ASSET',ASSET_STATUS,* FROM dbo.AGREEMENT_ASSET WHERE AGREEMENT_NO = replace(@AGREEMENT_NO,'/','.')
SELECT		'AGREEMENT_MAIN',AGREEMENT_STATUS,* FROM dbo.AGREEMENT_MAIN WHERE AGREEMENT_NO = replace(@AGREEMENT_NO,'/','.')
SELECT      'MTN_DATA_DSF_LOG',* FROM dbo.MTN_DATA_DSF_LOG WHERE REFF_1 = replace(@AGREEMENT_NO,'/','.')
ROLLBACK TRANSACTION 