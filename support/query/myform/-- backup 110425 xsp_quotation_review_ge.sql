-- backup 110425 xsp_quotation_review_getrows
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
------------------------------------------------------------------------------------------------------
-- region menghapus table temporary kalau table nya  ada
	IF OBJECT_ID('tempdb..#QUOTATION_REVIEW_DETAIL') IS NOT NULL
		DROP TABLE #QUOTATION_REVIEW_DETAIL; 
-- end region
-- region membuat table temporary
	SELECT	* 
	INTO	#QUOTATION_REVIEW_DETAIL 
	FROM	QUOTATION_REVIEW_DETAIL 
	WHERE	spesification	like '%' + @p_keywords + '%'
	or		remark			like '%' + @p_keywords + '%'

	DECLARE @QUOTATION_REVIEW TABLE
	(
	[CODE] [nvarchar] (50)  ,
	[COMPANY_CODE] [nvarchar] (50)  ,
	[QUOTATION_REVIEW_DATE] [nvarchar] (500)  ,
	[EXPIRED_DATE] [nvarchar] (500)  ,
	[BRANCH_CODE] [nvarchar] (50) ,
	[BRANCH_NAME] [nvarchar] (250) ,
	[DIVISION_CODE] [nvarchar] (50),
	[DIVISION_NAME] [nvarchar] (250) ,
	[DEPARTMENT_CODE] [nvarchar] (50) ,
	[DEPARTMENT_NAME] [nvarchar] (250),
	[REQUESTOR_CODE] [nvarchar] (50) ,
	[REQUESTOR_NAME] [nvarchar] (250) ,
	[STATUS] [nvarchar] (20),
	[DATE_FLAG] [nvarchar] (500) ,
	[REMARK] [nvarchar] (4000) ,
	[UNIT_FROM] [nvarchar] (60),
	[CRE_DATE] [nvarchar] (500) ,
	[CRE_BY] [nvarchar] (15),
	[CRE_IP_ADDRESS] [nvarchar] (15),
	[MOD_DATE] [nvarchar] (500)  ,
	[MOD_BY] [nvarchar] (15),
	[MOD_IP_ADDRESS] [nvarchar] (15) ,
	[ITEM_CODE] [nvarchar] (50) ,
	NAME  [nvarchar] (250),
	SPESIFICATION [nvarchar] (4000),
	REMARK_DETAIL [nvarchar] (4000)			
	)  

	INSERT @QUOTATION_REVIEW
	SELECT	qr.*,NAME,detail.spesification,detail.remark 
	FROM	QUOTATION_REVIEW qr
	left join IFINSYS.dbo.SYS_EMPLOYEE_MAIN tem on (tem.code = qr.mod_by collate database_default)
	outer apply (SELECT TOP 1 qrd.spesification 'spesification', qrd.remark 'remark'
			from dbo.quotation_review_detail qrd
			where qr.code = qrd.quotation_review_code collate database_default
			and (qrd.spesification	like '%' + @p_keywords + '%'
			or qrd.remark			like '%' + @p_keywords + '%')) detail
	WHERE	qr.company_code	= 'DSF'
	and		qr.status		= case @p_status
							  when 'ALL' then qr.status
							  else @p_status
						  end
	and		(	qr.code												LIKE '%' + @p_keywords + '%'
			or	qr.branch_name										like '%' + @p_keywords + '%'
			or	convert(varchar(30), qr.quotation_review_date, 103)	like '%' + @p_keywords + '%'
			or	qr.remark											like '%' + @p_keywords + '%'
			or	qr.status											like '%' + @p_keywords + '%'
			or	qr.unit_from										like '%' + @p_keywords + '%'
			or	qr.DIVISION_NAME									like '%' + @p_keywords + '%'
			or	qr.DEPARTMENT_NAME									like '%' + @p_keywords + '%'
			or	tem.NAME											like '%' + @p_keywords + '%')


-- end region
------------------------------------------------------------------------------------------------------

	DECLARE @rows_count INT = 0 ;

	SELECT	@rows_count = COUNT(1) 
	FROM	@QUOTATION_REVIEW tqr
		OUTER APPLY (SELECT TOP 1 * FROM #QUOTATION_REVIEW_DETAIL tqrd WHERE tqrd.QUOTATION_REVIEW_CODE  COLLATE SQL_Latin1_General_CP1_CI_AS = tqr.CODE) AS DETAIL

select	tqr.code
		,tqr.company_code
		,convert(varchar(30), tqr.quotation_review_date, 103) 'quotation_review_date'
		,convert(varchar(30), tqr.expired_date, 103)		  'expired_date'
		,tqr.branch_code
		,tqr.branch_name
		,tqr.division_code
		,tqr.division_name
		,tqr.department_code
		,tqr.department_name
		,tqr.status
		,tqr.remark
		,tqr.NAME 'mod_by'
		,detail.spesification
		,detail.remark
		,@rows_count									  'rowcount'
FROM	@QUOTATION_REVIEW tqr
    OUTER APPLY (SELECT TOP 1 * FROM #QUOTATION_REVIEW_DETAIL tqrd WHERE tqrd.QUOTATION_REVIEW_CODE  COLLATE SQL_Latin1_General_CP1_CI_AS = tqr.CODE) AS DETAIL

	order by	case
					when @p_sort_by = 'asc' then case @p_order_by
													 when 1 then tqr.code collate latin1_general_ci_as
													 when 2 then tqr.branch_name
													 when 3 then cast(tqr.quotation_review_date as sql_variant)
													 when 4 then tqr.name
													 when 5 then tqr.remark
													 when 6 then tqr.status
												 end
				end asc
				,case
					 when @p_sort_by = 'desc' then case @p_order_by
													 when 1 then tqr.code collate latin1_general_ci_as
													 when 2 then tqr.branch_name
													 when 3 then cast(tqr.quotation_review_date as sql_variant)
													 when 4 then tqr.name
													 when 5 then tqr.remark
													 when 6 then tqr.status
												   end
				 end desc offset ((@p_pagenumber - 1) * @p_rowspage) rows fetch next @p_rowspage rows only ;
end ;
GO
