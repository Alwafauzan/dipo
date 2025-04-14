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
AS
BEGIN
	DECLARE @rows_count INT = 0 ;

	SELECT	@rows_count = COUNT(1) 
	FROM	quotation_review qr
	OUTER APPLY (SELECT TOP 1 qrd.spesification 'spesification', qrd.remark 'remark'
				FROM dbo.quotation_review_detail qrd 
				WHERE qr.code = qrd.quotation_review_code collate database_default
				AND (qrd.spesification	LIKE '%' + @p_keywords + '%'
				OR qrd.remark			LIKE '%' + @p_keywords + '%')) detail
	WHERE	company_code	= @p_company_code
			AND status		= case @p_status
								  when 'ALL' then status
								  else @p_status
							  end
			and
			(
				code													like '%' + @p_keywords + '%'
				or	qr.branch_name										like '%' + @p_keywords + '%'
				or	convert(varchar(30), qr.quotation_review_date, 103)	like '%' + @p_keywords + '%'
				or	qr.remark											like '%' + @p_keywords + '%'
				or	qr.mod_by											like '%' + @p_keywords + '%'
				or	qr.status											like '%' + @p_keywords + '%'
				or	qr.unit_from										like '%' + @p_keywords + '%'
				or	qr.DIVISION_NAME									like '%' + @p_keywords + '%'
				or	qr.DEPARTMENT_NAME									like '%' + @p_keywords + '%'
				or  detail.spesification								like '%' + @p_keywords + '%'
				or  detail.remark										like '%' + @p_keywords + '%'			

			) ;

	select		qr.code
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
				,@rows_count									  'rowcount'
				,detail.spesification
				,detail.remark
	from		quotation_review qr
	inner join ifinsys.dbo.sys_employee_main em on (em.code = qr.mod_by collate database_default)
	outer apply (SELECT TOP 1 qrd.spesification 'spesification', qrd.remark 'remark'
				from dbo.quotation_review_detail qrd
				where qr.code = qrd.quotation_review_code collate database_default
				and (qrd.spesification	like '%' + @p_keywords + '%'
				or qrd.remark			like '%' + @p_keywords + '%')) detail
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
					or  detail.spesification								like '%' + @p_keywords + '%'
					or  detail.remark										like '%' + @p_keywords + '%'		
				)
	order by	case
					when @p_sort_by = 'asc' then case @p_order_by
													 when 1 then qr.code collate latin1_general_ci_as
													 when 2 then qr.branch_name
													 when 3 then cast(qr.quotation_review_date as sql_variant)
													 when 4 then em.name
													 when 5 then qr.remark
													 when 6 then qr.status
												 end
				end asc
				,case
					 when @p_sort_by = 'desc' then case @p_order_by
														 when 1 then qr.code collate latin1_general_ci_as
														 when 2 then qr.branch_name
														 when 3 then cast(qr.quotation_review_date as sql_variant)
														 when 4 then em.name
														 when 5 then qr.remark
														 when 6 then qr.status
												   end
				 end desc offset ((@p_pagenumber - 1) * @p_rowspage) rows fetch next @p_rowspage rows only ;
end ;
GO
