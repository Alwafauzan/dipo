USE IFINOPL
--https://365dipostar.sharepoint.com/:f:/s/AttachmentForIfinancing/Eh2mZIZO641GmXsP3awK9SwBO9hcw0--3db9vNU-FSjh2g?e=MHf9v8
/*Detail Request: status unit minta dikembalikan menjadi golive, dan dimunculkan maturity request agar bisa di perpanjang 0002221/4/10/04/2024 Reason for the Request: SAAT INI AKAN DIAJUKAN PERPANJANGAN KONTRAK KEMBALI SELAMA 2 BULAN Before: terminate After: minta balikin ke golive, dan dimunculkan di maturity request untuk bisa diperpanjang*/
--2504000134
BEGIN TRANSACTION 
DECLARE     @AGREEMENT_NO VARCHAR(20) = '0002221/4/10/04/2024'
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
				FROM maturity ma INNER join dbo.agreement_main am on (am.agreement_no = ma.agreement_no) WHERE am.AGREEMENT_NO = replace(@AGREEMENT_NO,'/','.')
SELECT		'AGREEMENT_ASSET',ASSET_STATUS,* FROM dbo.AGREEMENT_ASSET WHERE AGREEMENT_NO = replace(@AGREEMENT_NO,'/','.')
SELECT		'AGREEMENT_MAIN',AGREEMENT_STATUS,* FROM dbo.AGREEMENT_MAIN WHERE AGREEMENT_NO = replace(@AGREEMENT_NO,'/','.')
SELECT      'MTN_DATA_DSF_LOG',* FROM dbo.MTN_DATA_DSF_LOG WHERE REFF_1 = replace(@AGREEMENT_NO,'/','.')

EXEC dbo.xsp_mtn_hold_maturity_v2 @p_agreement_no = @AGREEMENT_NO, -- nvarchar(50)
                                  @p_mod_by = N'MTN-FZN'        -- nvarchar(50)

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
				FROM maturity ma INNER join dbo.agreement_main am on (am.agreement_no = ma.agreement_no) WHERE am.AGREEMENT_NO = replace(@AGREEMENT_NO,'/','.')
SELECT		'AGREEMENT_ASSET',ASSET_STATUS,* FROM dbo.AGREEMENT_ASSET WHERE AGREEMENT_NO = replace(@AGREEMENT_NO,'/','.')
SELECT		'AGREEMENT_MAIN',AGREEMENT_STATUS,* FROM dbo.AGREEMENT_MAIN WHERE AGREEMENT_NO = replace(@AGREEMENT_NO,'/','.')
SELECT      'MTN_DATA_DSF_LOG',* FROM dbo.MTN_DATA_DSF_LOG WHERE REFF_1 = replace(@AGREEMENT_NO,'/','.')
ROLLBACK TRANSACTION 