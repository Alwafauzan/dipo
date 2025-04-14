ALTER PROCEDURE dbo.xsp_quotation_review_getrows
(
	@p_keywords		 NVARCHAR(50)
	,@p_pagenumber	 INT
	,@p_rowspage	 INT
	,@p_order_by	 INT
	,@p_sort_by		 NVARCHAR(5)
	,@p_company_code NVARCHAR(50)
	,@p_status		 NVARCHAR(50)
)
as
begin
declare      @rows_count												int = 0
			,@code														nvarchar(50)
			,@company_code												nvarchar(50)
			,@quotation_review_date										nvarchar(50)
			,@expired_date												nvarchar(50)
			,@branch_code												nvarchar(50)
			,@branch_name												nvarchar(250)
			,@division_code												nvarchar(50)
			,@division_name												nvarchar(250)
			,@department_code											nvarchar(50)
			,@department_name											nvarchar(250)
			,@status													nvarchar(50)
			,@remark													nvarchar(400)
			,@mod_by													nvarchar(50)
			,@spesification												nvarchar(400)
			,@remark2													nvarchar(400)
			,@unit_form													nvarchar(400)


	declare @tabletemp table
	(
			 code														nvarchar(50)
			,company_code												nvarchar(50)
			,quotation_review_date										nvarchar(50)
			,expired_date												nvarchar(50)
			,branch_code												nvarchar(50)
			,branch_name												nvarchar(250)
			,division_code												nvarchar(50)
			,division_name												nvarchar(250)
			,department_code											nvarchar(50)
			,department_name											nvarchar(250)
			,status														nvarchar(50)
			,remark														nvarchar(400)
			,mod_by														nvarchar(50)
			,reff_no													nvarchar(50)
			,remark2													nvarchar(400)
			,unit_from													nvarchar(400)
	) ;

	insert into @tabletemp
	(
			 code														
			,company_code												
			,quotation_review_date										
			,expired_date												
			,branch_code												
			,branch_name												
			,division_code												
			,division_name												
			,department_code											
			,department_name											
			,status														
			,remark														
			,mod_by														
			--,reff_no											
			--,remark2
			,unit_from														
	)
	select		TOP 150
				 qr.code
				,qr.company_code
				,convert(varchar(30), qr.quotation_review_date, 103) 'quotation_review_date'
				,convert(varchar(30), qr.expired_date, 103)		  'expired_date'
				,branch_code
				,branch_name
				,qr.division_code
				,qr.division_name
				,qr.department_code
				,qr.department_name
				,qr.status
				,qr.remark
				,em.name 'mod_by'
				--,detail.reff_no
				--,detail.remark
				,qr.unit_from
	from		quotation_review qr WITH (NOLOCK)
	inner join ifinsys.dbo.sys_employee_main em WITH (NOLOCK) on (em.code = qr.mod_by collate database_default)
	--outer apply (SELECT TOP 1 qrd.REFF_NO 'reff_no'
	--			from dbo.quotation_review_detail qrd WITH (NOLOCK)
	--			where qr.code = qrd.quotation_review_code collate database_default
	--			and (qrd.REFF_NO	like '%' + @p_keywords + '%')) detail
	where		qr.company_code	= @p_company_code
				and qr.status		= case @p_status
									  when 'ALL' then qr.status
									  else @p_status
								  end
				and
				(
					qr.code													like '%' + @p_keywords + '%'
					or	qr.branch_name										like '%' + @p_keywords + '%'
					or	convert(varchar(30), qr.quotation_review_date, 103)	like '%' + @p_keywords + '%'
					or	qr.remark											like '%' + @p_keywords + '%'
					or	em.name												like '%' + @p_keywords + '%'
					or	qr.status											like '%' + @p_keywords + '%'
					or	qr.unit_from										like '%' + @p_keywords + '%'
					or	qr.DIVISION_NAME									like '%' + @p_keywords + '%'
					or	qr.DEPARTMENT_NAME									like '%' + @p_keywords + '%'
					--or  detail.reff_no								like '%' + @p_keywords + '%'
					--or  detail.remark										like '%' + @p_keywords + '%'		
				)
	group by	 qr.code
				,qr.company_code
				,convert(varchar(30), qr.quotation_review_date, 103)
				,convert(varchar(30), qr.expired_date, 103)	
				,branch_code
				,branch_name
				,qr.division_code
				,qr.division_name
				,qr.department_code
				,qr.department_name
				,qr.status
				,qr.remark
				,em.name
				--,detail.reff_no
				--,detail.remark
				,qr.unit_from
--------------------------------------------------------------------------------------------------------------
	select	@rows_count = count(1)
	from	@tabletemp
	where		(
					code													like '%' + @p_keywords + '%'
					or	branch_name											LIKE '%' + @p_keywords + '%'
					or	convert(varchar(30), quotation_review_date, 103)	like '%' + @p_keywords + '%'
					or	remark												LIKE '%' + @p_keywords + '%'
					or	mod_by												like '%' + @p_keywords + '%'
					or	status												like '%' + @p_keywords + '%'
					or	unit_from											like '%' + @p_keywords + '%'
					or	DIVISION_NAME										like '%' + @p_keywords + '%'
					or	DEPARTMENT_NAME										like '%' + @p_keywords + '%'
					--or  reff_no												LIKE '%' + @p_keywords + '%'
					or  remark												like '%' + @p_keywords + '%'		
				)

	select		 code						
				,company_code				
				,quotation_review_date		
				,expired_date				
				,branch_code				
				,branch_name				
				,division_code				
				,division_name				
				,department_code			
				,department_name			
				,status						
				,remark						
				,mod_by						
				--,reff_no				
				,remark
				,unit_from
				,@rows_count				 'rowcount'					
	from		@tabletemp
	order by	case
					when @p_sort_by = 'asc' then case @p_order_by
													 when 1 then code collate latin1_general_ci_as
													 when 2 then branch_name
													 when 3 then cast(quotation_review_date as sql_variant)
													 when 4 then mod_by
													 when 5 then remark
													 when 6 then status
												 end
				end asc
				,case
					 when @p_sort_by = 'desc' then case @p_order_by
														 when 1 then code collate latin1_general_ci_as
														 when 2 then branch_name
														 when 3 then cast(quotation_review_date as sql_variant)
														 when 4 then mod_by
														 when 5 then remark
														 when 6 then status
												   end
				 end desc offset ((@p_pagenumber - 1) * @p_rowspage) rows fetch next @p_rowspage rows only ;
end ;
GO
