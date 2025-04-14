BEGIN TRANSACTION 
DECLARE

	@p_coverage_code		nvarchar(50) = 'COMPR'
	,@p_insurance_type_code nvarchar(50) = 'PSGC'
	,@p_unit_amount			decimal(18, 2) = 542300000
	,@p_region_code			nvarchar(50) = 'REGION2'
	,@p_asset_year			nvarchar(4) = 2023
	,@p_date				DATETIME = dbo.xfn_get_system_date()
	,@p_depre_amount		decimal(18, 2) = 75

begin
	declare @total_budget_amount decimal(18, 2) = 0
			,@year				 int ;

	begin
		set @year = (year(getdate()) - @p_asset_year) ;

		select	
										(@p_unit_amount *( @p_depre_amount/100)) 
										* (case
											when @year < 5 then mbird.rate_1
											when @year < 10 then mbird.rate_2
											when @year < 15 then mbird.rate_3
											when @year > 15 then mbird.rate_4
										end ) / 100
										
		from	dbo.master_budget_insurance_rate mbir
				inner join dbo.master_budget_insurance_rate_detail mbird on (mbird.budget_insurance_rate_code = mbir.code)
		where	coverage_code			   = @p_coverage_code
				and mbir.vehicle_type_code = @p_insurance_type_code
				and @p_unit_amount *( @p_depre_amount/100)
				between mbird.sum_insured_from and mbird.sum_insured_to
				and region_code			   = @p_region_code
				and exp_date			   >= @p_date 
				and mbir.is_active		   = '1'
	end ;

end ;
ROLLBACK TRANSACTION 


