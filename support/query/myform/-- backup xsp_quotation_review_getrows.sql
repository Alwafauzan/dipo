-- backup xsp_quotation_review_getrows
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
BEGIN

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
from		quotation_review qr 
			inner join ifinsys.dbo.sys_employee_main em on (em.code = qr.mod_by collate database_default)
WHERE		qr.CODE IN (
	
			SELECT	DISTINCT quotation_review_code	collate latin1_general_ci_as 'quotation_review_code'
			from	quotation_review_detail 
			where	spesification	like '%' + @p_keywords + '%'
			or		remark			like '%' + @p_keywords + '%'

			union all
    
			select		DISTINCT qr.code collate latin1_general_ci_as			'quotation_review_code'
			from		quotation_review qr
			where		qr.status		= case @p_status
												when 'all' then qr.status
												else @p_status
											end
						and
						(
							qr.code													like '%' + @p_keywords + '%'
							or	qr.branch_name										like '%' + @p_keywords + '%'
							or	convert(varchar(30), qr.quotation_review_date, 103)	like '%' + @p_keywords + '%'
							or	qr.remark											like '%' + @p_keywords + '%'
							or	qr.status											like '%' + @p_keywords + '%'
							or	qr.unit_from										like '%' + @p_keywords + '%'
							or	qr.division_name									like '%' + @p_keywords + '%'
							or	qr.department_name									like '%' + @p_keywords + '%'
						)
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



--------------------------------------------------------------------------------------------------------
---- region menghapus table temporary kalau table nya  ada
--	IF OBJECT_ID('tempdb..#QUOTATION_REVIEW_DETAIL') IS NOT NULL
--		DROP TABLE #QUOTATION_REVIEW_DETAIL; 
---- end region
---- region membuat table temporary
--	SELECT	* 
--	INTO	#QUOTATION_REVIEW_DETAIL 
--	FROM	QUOTATION_REVIEW_DETAIL 
--	WHERE	spesification	like '%' + @p_keywords + '%'
--	or		remark			like '%' + @p_keywords + '%'

--	DECLARE @QUOTATION_REVIEW TABLE
--	(
--	[CODE] [nvarchar] (50)  ,
--	[COMPANY_CODE] [nvarchar] (50)  ,
--	[QUOTATION_REVIEW_DATE] [nvarchar] (500)  ,
--	[EXPIRED_DATE] [nvarchar] (500)  ,
--	[BRANCH_CODE] [nvarchar] (50) ,
--	[BRANCH_NAME] [nvarchar] (250) ,
--	[DIVISION_CODE] [nvarchar] (50),
--	[DIVISION_NAME] [nvarchar] (250) ,
--	[DEPARTMENT_CODE] [nvarchar] (50) ,
--	[DEPARTMENT_NAME] [nvarchar] (250),
--	[STATUS] [nvarchar] (20),
--	[REMARK] [nvarchar] (4000) ,
--	NAME  [nvarchar] (250),
--	SPESIFICATION [nvarchar] (4000),
--	REMARK_DETAIL [nvarchar] (4000)			
--	)  

--	INSERT @QUOTATION_REVIEW
--	select		qr.code
--				,qr.company_code
--				,convert(varchar(30), qr.quotation_review_date, 103) 'quotation_review_date'
--				,convert(varchar(30), qr.expired_date, 103)		  'expired_date'
--				,branch_code
--				,branch_name
--				,qr.division_code
--				,qr.division_name
--				,qr.department_code
--				,qr.department_name
--				,qr.status
--				,qr.remark
--				,em.name 'mod_by'
--				,detail.spesification
--				,detail.remark
--	from		quotation_review qr
--	inner join ifinsys.dbo.sys_employee_main em on (em.code = qr.mod_by collate database_default)
--	outer apply (SELECT TOP 1 qrd.spesification 'spesification', qrd.remark 'remark'
--				from dbo.quotation_review_detail qrd
--				where qr.code = qrd.quotation_review_code collate database_default
--				and (qrd.spesification	like '%' + @p_keywords + '%'
--				or qrd.remark			like '%' + @p_keywords + '%')) detail
--	where		qr.company_code	= @p_company_code
--				and qr.status		= case @p_status
--									  when 'ALL' then qr.status
--									  else @p_status
--								  end
--				and
--				(
--					qr.code													like '%' + @p_keywords + '%'
--					or	qr.branch_name										like '%' + @p_keywords + '%'
--					or	convert(varchar(30), qr.quotation_review_date, 103)	like '%' + @p_keywords + '%'
--					or	qr.remark											like '%' + @p_keywords + '%'
--					or	em.name												like '%' + @p_keywords + '%'
--					or	qr.status											like '%' + @p_keywords + '%'
--					or	qr.unit_from										like '%' + @p_keywords + '%'
--					or	qr.DIVISION_NAME									like '%' + @p_keywords + '%'
--					or	qr.DEPARTMENT_NAME									like '%' + @p_keywords + '%'
--					or  detail.spesification								like '%' + @p_keywords + '%'
--					or  detail.remark										like '%' + @p_keywords + '%'		
--				)


---- end region
--------------------------------------------------------------------------------------------------------

--	DECLARE @rows_count INT = 0 ;

--	SELECT	@rows_count = COUNT(1) 
--	FROM	@QUOTATION_REVIEW tqr
--		OUTER APPLY (SELECT TOP 1 * FROM #QUOTATION_REVIEW_DETAIL tqrd WHERE tqrd.QUOTATION_REVIEW_CODE  COLLATE SQL_Latin1_General_CP1_CI_AS = tqr.CODE) AS DETAIL

--select	tqr.code
--		,tqr.company_code
--		,convert(varchar(30), tqr.quotation_review_date, 103) 'quotation_review_date'
--		,convert(varchar(30), tqr.expired_date, 103)		  'expired_date'
--		,tqr.branch_code
--		,tqr.branch_name
--		,tqr.division_code
--		,tqr.division_name
--		,tqr.department_code
--		,tqr.department_name
--		,tqr.status
--		,tqr.remark
--		,tqr.NAME 'mod_by'
--		,detail.spesification
--		,detail.remark
--		,@rows_count									  'rowcount'
--FROM	@QUOTATION_REVIEW tqr
--    OUTER APPLY (SELECT TOP 1 * FROM #QUOTATION_REVIEW_DETAIL tqrd WHERE tqrd.QUOTATION_REVIEW_CODE  COLLATE SQL_Latin1_General_CP1_CI_AS = tqr.CODE) AS DETAIL

--	order by	case
--					when @p_sort_by = 'asc' then case @p_order_by
--													 when 1 then tqr.code collate latin1_general_ci_as
--													 when 2 then tqr.branch_name
--													 when 3 then cast(tqr.quotation_review_date as sql_variant)
--													 when 4 then tqr.name
--													 when 5 then tqr.remark
--													 when 6 then tqr.status
--												 end
--				end asc
--				,case
--					 when @p_sort_by = 'desc' then case @p_order_by
--													 when 1 then tqr.code collate latin1_general_ci_as
--													 when 2 then tqr.branch_name
--													 when 3 then cast(tqr.quotation_review_date as sql_variant)
--													 when 4 then tqr.name
--													 when 5 then tqr.remark
--													 when 6 then tqr.status
--												   end
--				 end desc offset ((@p_pagenumber - 1) * @p_rowspage) rows fetch next @p_rowspage rows only ;
end ;
GO
