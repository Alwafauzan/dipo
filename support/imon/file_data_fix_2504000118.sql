BEGIN TRANSACTION 
DECLARE	@sale_code				NVARCHAR(50)	= '' --diisi dengan sale code pada Menu Sell Settlement. Contoh : 1000.SL.2504.00034
		,@sale_date				DATETIME		= '' --diisi dengan tanggal pergantian sale date dengan format yyyy-mm-dd. Contoh : 2025-04-26
		,@mod_date				DATETIME		= GETDATE()
		,@mod_ip_address		NVARCHAR(50)	= '' --diisi dengan tujuan data maintenance. Contoh : MYFORM-5xxxx1
		,@mod_by				NVARCHAR(50)	= '' --diisi dengan siapa yang melakukan data maintenance. Contoh : MTN_USER
SELECT	'SALE_DETAIL_BEFORE',SALE_DATE,* 
FROM	SALE_DETAIL
WHERE	SALE_CODE		= @sale_code

UPDATE	dbo.SALE_DETAIL 
SET		SALE_DATE		= @sale_date
		,mod_date		= @mod_date
		,mod_by			= @mod_by
		,mod_ip_address = MOD_IP_ADDRESS
WHERE	SALE_CODE		= @sale_code

SELECT	'SALE_DETAIL_AFTER',SALE_DATE,* 
FROM	SALE_DETAIL
WHERE	SALE_CODE		= @sale_code

		begin
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
			(	'Request Perubahan Sale Date'										-- MAINTENANCE_NAME - nvarchar(50)
				,'Dikarnakan user melakukan kesalahan input '+@mod_ip_address		-- REMARK - nvarchar(4000)
				,'SALE_DATE'														-- TABEL_UTAMA - nvarchar(50)
				,@sale_code															-- REFF_1 - nvarchar(50)
				,null																-- REFF_2 - nvarchar(50)
				,null																-- REFF_3 - nvarchar(50)
				,@mod_date															-- CRE_DATE - datetime
				,@mod_by+' '+@mod_ip_address										-- CRE_BY - nvarchar(250)
				);
		end;
SELECT * FROM dbo.MTN_DATA_DSF_LOG WHERE CRE_BY = @mod_by+' '+@mod_ip_address
ROLLBACK TRANSACTION 