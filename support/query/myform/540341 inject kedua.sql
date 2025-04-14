BEGIN TRANSACTION 
DECLARE 	 @p_cre_date		DATETIME		= GETDATE()
			,@p_cre_by			NVARCHAR(15)	= 'MTN_FAUZAN'
			,@p_cre_ip_address	NVARCHAR(15)	= 'PUSH_MANUAL'
			,@p_mod_date		DATETIME		= GETDATE()
			,@p_mod_by			NVARCHAR(15)	= 'MTN_FAUZAN'
			,@p_mod_ip_address	NVARCHAR(15)	= 'PUSH_MANUAL'
--SELECT * FROM REPLACEMENT_REQUEST			WHERE COVER_NOTE_NO LIKE '%966/SPBPKB/01/2025%'
--SELECT * FROM REPLACEMENT_REQUEST_DETAIL	WHERE REPLACEMENT_REQUEST_ID IN (3511,3531)
--SELECT * FROM REPLACEMENT					WHERE COVER_NOTE_NO LIKE '%966/SPBPKB/01/2025%'
--SELECT * FROM REPLACEMENT_DETAIL			WHERE REPLACEMENT_CODE = '2001.RPL.2503.000003'

	--insert into dbo.replacement_detail
	--(
	--	replacement_code
	--	,replacement_request_detail_id
	--	,asset_no
	--	,type
	--	,bpkb_no
	--	,bpkb_date
	--	,bpkb_name
	--	,bpkb_address
	--	,stnk_name
	--	,stnk_exp_date
	--	,stnk_tax_date
	--	,file_name
	--	,paths
	--	--
	--	,cre_date
	--	,cre_by
	--	,cre_ip_address
	--	,mod_date
	--	,mod_by
	--	,mod_ip_address
	--)
	select	'2001.RPL.2503.000003'
			,id
			,asset_no
			,null
			,null
			,null
			,null
			,null
			,null
			,null
			,null
			,null
			,null
			--
			,@p_cre_date		
			,@p_cre_by			
			,@p_cre_ip_address	
			,@p_mod_date		
			,@p_mod_by			
			,@p_mod_ip_address	
	from	dbo.replacement_request_detail
	where	replacement_request_id = 3531
			--and replacement_code is null 
			and	status = 'HOLD';

	--UPDATE	REPLACEMENT_REQUEST 
	--SET 	REPLACEMENT_CODE = NULL
	--		,COUNT_ASSET = 5		
	--		,mod_date 				= GETDATE() 
	--		,mod_by 				= 'MTN_FAUZAN'
	--		,mod_ip_address 		= 'MYFORM-540341'   
	-- WHERE	id = 3531

	--SELECT * FROM REPLACEMENT_REQUEST			WHERE COVER_NOTE_NO LIKE '%966/SPBPKB/01/2025%'
	--SELECT * FROM REPLACEMENT_REQUEST_DETAIL	WHERE REPLACEMENT_REQUEST_ID IN (3511,3531)
	--SELECT * FROM REPLACEMENT					WHERE COVER_NOTE_NO LIKE '%966/SPBPKB/01/2025%'
	--SELECT * FROM REPLACEMENT_DETAIL			WHERE REPLACEMENT_CODE = '2001.RPL.2503.000003'

ROLLBACK TRANSACTION 