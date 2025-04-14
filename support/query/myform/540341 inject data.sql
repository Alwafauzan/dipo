BEGIN TRANSACTION 

DECLARE @p_asset_code		NVARCHAR(50)	= '2010.AST.2502.00001'
		,@p_cre_date			DATETIME	= GETDATE()
		,@p_cre_by			NVARCHAR(15)	= 'MTN_FAUZAN'
		,@p_cre_ip_address	NVARCHAR(15)	= 'PUSH_MANUAL'
		,@p_mod_date		DATETIME	= GETDATE()
		,@p_mod_by			NVARCHAR(15)	= 'MTN_FAUZAN'
		,@p_mod_ip_address	NVARCHAR(15)	= 'PUSH_MANUAL'



INSERT INTO dbo.FIXED_ASSET_MAIN
(
    ASSET_NO,
    ASSET_TYPE_CODE,
    ASSET_NAME,
    ASSET_CONDITION,
    MARKET_VALUE,
    ASSET_VALUE,
    DOC_ASSET_NO,
    ASSET_YEAR,
    REFF_NO_1,
    REFF_NO_2,
    REFF_NO_3,
    VENDOR_CODE,
    VENDOR_NAME,
    VENDOR_ADDRESS,
    VENDOR_PIC_NAME,
    VENDOR_PIC_AREA_PHONE_NO,
    VENDOR_PIC_PHONE_NO,
    CRE_DATE,
    CRE_BY,
    CRE_IP_ADDRESS,
    MOD_DATE,
    MOD_BY,
    MOD_IP_ADDRESS
)
select	code
		,type_code
		,item_name
		,condition
		,original_price
		,purchase_price
		,isnull(av.bpkb_no, isnull(am.invoice_no, isnull(ah.invoice_no, ae.serial_no)))
		,isnull(av.built_year, isnull(am.built_year, ''))
		,isnull(av.plat_no, isnull(ah.invoice_no, isnull(am.invoice_no, ae.serial_no)))
		,isnull(av.chassis_no, isnull(ah.chassis_no, isnull(am.chassis_no, ae.imei)))
		,isnull(av.engine_no, isnull(ah.engine_no, isnull(am.engine_no, ae.imei)))
		,vendor_code
		,vendor_name
		,'' --vendor_address
		,'' --vendor_pic_name
		,'' --vendor_pic_name 
		,'' --vendor_pic_phone_no
		--
		,@p_cre_date
		,@p_cre_by
		,@p_cre_ip_address
		,@p_mod_date
		,@p_mod_by
		,@p_mod_ip_address
from	IFINAMS.dbo.asset aa
		left join IFINAMS.dbo.asset_vehicle av on (av.asset_code	= aa.code)
		left join IFINAMS.dbo.asset_he ah on (ah.asset_code			= aa.code)
		left join IFINAMS.dbo.asset_machine am on (am.asset_code	= aa.code)
		left join IFINAMS.dbo.asset_electronic ae on (ae.asset_code = aa.code)
where	aa.code = @p_asset_code ;

--UPDATE dbo.DOCUMENT_MAIN
--SET ASSET_NO = @p_asset_code
--	,MOD_DATE = @p_mod_date
--	,MOD_BY = @p_mod_by
--	,MOD_IP_ADDRESS = @p_mod_ip_address
--WHERE CODE IN
--(
--N'2008.DCM.2405.000027',
--N'2008.DCM.2405.000028'
--)


SELECT * FROM dbo.DOCUMENT_MAIN WHERE MOD_IP_ADDRESS = @p_mod_ip_address
SELECT * FROM dbo.FIXED_ASSET_MAIN WHERE MOD_IP_ADDRESS = @p_mod_ip_address



ROLLBACK TRANSACTION