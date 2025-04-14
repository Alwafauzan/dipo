BEGIN TRANSACTION 
-- Cek keberadaan di tabel utama dan detail
SELECT 'invoice' AS source, inv.invoice_no, agreement_no, invoice_due_date, invoice_status, is_journal_date, invoice_type
FROM ifinopl.dbo.invoice inv
JOIN IFINOPL.dbo.INVOICE_DETAIL ON INVOICE_DETAIL.INVOICE_NO = inv.INVOICE_NO
WHERE agreement_no = '0001797.4.10.01.2024'

UNION ALL

SELECT 'invoice_detail' AS source, invoice_no, agreement_no, id AS invoice_detail_id, billing_amount
FROM ifinopl.dbo.invoice_detail
WHERE agreement_no = '0001797.4.10.01.2024'

UNION ALL

SELECT 'agreement_main' AS source, agreement_no, agreement_external_no, agreement_date, client_no, client_name, periode, credit_term
FROM ifinopl.dbo.agreement_main
WHERE agreement_no = '0001797.4.10.01.2024';

-- Cek apakah kondisi WHERE terpenuhi untuk invoice yang mungkin ada
SELECT invoice_no, agreement_no, invoice_due_date, invoice_status, is_journal_date, invoice_type,
       CASE(invoice_type) WHEN 'penalty' THEN convert(nvarchar(8), invoice_due_date, 112) ELSE convert(nvarchar(8), is_journal_date, 112) END AS date_for_comparison,
       convert(nvarchar(8), GETDATE(), 112) AS eod_date_comparison,
       cast(invoice_due_date as date) AS invoice_due_date_cast,
       GETDATE() AS eod_date
FROM ifinopl.dbo.invoice
WHERE agreement_no = '0001797.4.10.01.2024'
AND invoice_status = 'post';
ROLLBACK TRANSACTION 