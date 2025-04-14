DECLARE @periode					  INT
,@no						  int
SELECT * FROM dbo.ASSET_INSURANCE_DETAIL WHERE ASSET_NO = '2001.OPLAA.2311.000012'

		select	((value * 1.00) / 100) AS parameter_calculate_asset_2
		from	dbo.sys_global_param
		where	code = 'PCAA2' ;

			select	periode
					,(otr_amount - discount_amount) + ((karoseri_amount + (karoseri_amount * 0.08500000)) - discount_karoseri_amount) AS unit_amount
					,asset_type_code
					,asset_year
			from	dbo.application_asset
			where	ASSET_NO = '2001.OPLAA.2311.000012'

			select	insurance_asset_type_code
			from	dbo.application_asset_vehicle aah
					inner join dbo.master_vehicle_unit mhu on (aah.vehicle_unit_code = mhu.code)
			where	ASSET_NO = '2001.OPLAA.2311.000012'

		--while (@no <= ceiling((@periode*1.00) / 12)) 
		--begin 
			select	cast(description as decimal(18, 2)) AS depre_amount 
			from	dbo.sys_general_subcode
			where	general_code = 'DEPRE'
					--and code = case
					--		   when @no <= 1 then 'TAHUN1'
					--		   when @no <= 2 then 'TAHUN2'
					--		   when @no <= 3 then 'TAHUN3'
					--		   when @no <= 4 then 'TAHUN4'
					--		   when @no <= 5 then 'TAHUN5'
					--		   when @no <= 6 then 'TAHUN6'
					--		   when @no <= 7 then 'TAHUN7'


SELECT ceiling((36*1.00) / 12) AS no

--SELECT REPLACE(APPLICATION_ASSET.APPLICATION_NO, '.', '/') AS APPLICATION_NO FROM dbo.APPLICATION_ASSET
--join dbo.APPLICATION_MAIN ON APPLICATION_MAIN.APPLICATION_NO = APPLICATION_ASSET.APPLICATION_NO
--WHERE ASSET_NAME like '%HIACE%'
--AND IS_SIMULATION = 1



--xsp_application_asset_detail_insurance_insert
--[xsp_application_asset_insurance_getrate]
--[xsp_asset_insurance_detail_update]
--[xsp_asset_insurance_detail_insert]
--xsp_rpt_provision_of_doubtful_account
--EXEC dbo.cari_sp_mengandung @keyword = 'main_coverage_premium_amount' -- varchar(500)
