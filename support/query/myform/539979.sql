BEGIN TRANSACTION 
--539979
EXEC dbo.xsp_mtn_hold_maturity_v2 @p_agreement_no = N'0001799.4.10.01.2024', -- nvarchar(50)
                                  @p_mod_by = N''        -- nvarchar(50)
DECLARE     @AGREEMENT_NO VARCHAR(20) = '0001799.4.10.01.2024'
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

ROLLBACK TRANSACTION 