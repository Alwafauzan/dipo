BEGIN TRANSACTION 
exec dbo.xsp_rpt_ext_disbursement_insert
exec dbo.xsp_rpt_ext_write_off_insert
exec IFINAMS.dbo.xsp_rpt_ext_net_asset_cost_price_insert --nnti
exec IFINAMS.dbo.xsp_rpt_ext_net_asset_depre_insert --nnti
exec IFINAMS.dbo.xsp_rpt_ext_asset_selling_insert --nnti
exec IFINAMS.dbo.xsp_rpt_ext_costprice_depreamt_overdue --nnti
exec IFINAMS.dbo.xsp_rpt_ext_expense_insert
 
 
SELECT top 10 * FROM IFINAMS.dbo.RPT_EXT_EXPENSE
--SELECT top 10 * FROM IFINOPL.dbo.RPT_EXT_REVENUE
--SELECT top 10 * FROM IFINOPL.dbo.RPT_EXT_INTEREST_EXPENSE
--SELECT top 10 * FROM IFINOPL.dbo.RPT_EXT_OVERDUE
SELECT top 10 * FROM IFINOPL.dbo.RPT_EXT_DISBURSEMENT
SELECT top 10 * FROM IFINOPL.dbo.RPT_EXT_WRITE_OFF
SELECT top 10 * FROM IFINAMS.dbo.RPT_EXT_NET_ASSET_COST_PRICE
SELECT top 10 * FROM IFINAMS.dbo.RPT_EXT_NET_ASSET_DEPRE
SELECT top 10 * FROM IFINAMS.dbo.RPT_EXT_ASSET_SELLING
SELECT top 10 * FROM IFINAMS.dbo.RPT_EXT_COSTPRICE_DEPREAMT_OVERDUE
ROLLBACK TRANSACTION