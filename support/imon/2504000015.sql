BEGIN TRANSACTION 
DECLARE     @AGREEMENT_NO VARCHAR(20) = '0000991/4/08/03/2023'
--2504000015
EXEC dbo.xsp_mtn_hold_maturity_v2 @p_agreement_no = @AGREEMENT_NO, -- nvarchar(50)
                                  @p_mod_by = N'MTN-FAUZAN-2504000015'        -- nvarchar(50)
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
SELECT * FROM dbo.MTN_DATA_DSF_LOG WHERE REFF_1 = replace(@AGREEMENT_NO,'/','.')
ROLLBACK TRANSACTION; 

BEGIN TRANSACTION 
DECLARE     @AGREEMENT_NO VARCHAR(20) = '0000992/4/08/03/2023'
--2504000015
EXEC dbo.xsp_mtn_hold_maturity_v2 @p_agreement_no = @AGREEMENT_NO, -- nvarchar(50)
                                  @p_mod_by = N'MTN-FAUZAN-2504000015'        -- nvarchar(50)
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
SELECT * FROM dbo.MTN_DATA_DSF_LOG WHERE REFF_1 = replace(@AGREEMENT_NO,'/','.')
ROLLBACK TRANSACTION 