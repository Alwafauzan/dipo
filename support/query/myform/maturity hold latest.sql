--SELECT * FROM dbo.AGREEMENT_MAIN where AGREEMENT_EXTERNAL_NO = '0000328/4/01/08/2019'
--SELECT * FROM dbo.AGREEMENT_ASSET where AGREEMENT_NO = '0000328.4.01.08.2019'
--SELECT * FROM dbo.MATURITY where AGREEMENT_NO = '0000328.4.01.08.2019'
--SELECT * FROM dbo.MATURITY_DETAIL where MATURITY_CODE = '2001.MTR.2411.000010'
--SELECT HANDOVER_CODE,* FROM IFINAMS.dbo.HANDOVER_REQUEST where AGREEMENT_NO = '0000328.4.01.08.2019'
--SELECT * FROM IFINAMS.dbo.HANDOVER_ASSET where CODE IN
--(
--N'2001.HNR.2409.000006',
--N'2001.HNR.2412.000001'
--)

BEGIN TRANSACTION 

declare @agreement_no_ex nvarchar(50) = '0000328/4/01/08/2019'
		,@agreement_no nvarchar(50)
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
ROLLBACK TRANSACTION 
