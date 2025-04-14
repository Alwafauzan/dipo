SELECT GETDATE()
DECLARE	@berhasil1 NVARCHAR(50) = '0000001.4.01.11.2023'
		,@berhasil12 NVARCHAR(50) = '0000001.4.29.06.2021'
		,@gagal1 NVARCHAR(50) = '0001797.4.10.01.2024'
-- Ganti '[AGREEMENT_NO_1]', '[AGREEMENT_NO_2]', '[AGREEMENT_NO_3]' dengan AGREEMENT_NO yang muncul
SELECT     CASE WHEN AGREEMENT_NO = @gagal1 THEN 'gagal' ELSE 'berhasil' END AS status, 'invoice' AS source, inv.invoice_no, agreement_no, invoice_due_date, invoice_status, is_journal_date, invoice_type,inv.IS_JOURNAL_DATE
FROM ifinopl.dbo.invoice inv
JOIN IFINOPL.dbo.INVOICE_DETAIL ON INVOICE_DETAIL.INVOICE_NO = inv.INVOICE_NO
WHERE agreement_no IN (@berhasil1, @berhasil12, @gagal1)

--UNION ALL

SELECT CASE WHEN AGREEMENT_NO = @gagal1 THEN 'gagal' ELSE 'berhasil' END AS status,'invoice_detail' AS source, invoice_no, agreement_no, ID, billing_amount, NULL, NULL -- Menambahkan NULL untuk menyamakan jumlah kolom
FROM ifinopl.dbo.invoice_detail
WHERE agreement_no IN (@berhasil1, @berhasil12, @gagal1)

--UNION ALL

SELECT CASE WHEN AGREEMENT_NO = @gagal1 THEN 'gagal' ELSE 'berhasil' END AS status,'agreement_main' AS source, NULL, agreement_no, NULL, NULL, NULL, NULL -- Menambahkan NULL untuk menyamakan jumlah kolom
FROM ifinopl.dbo.agreement_main
WHERE agreement_no IN (@berhasil1, @berhasil12, @gagal1);

-- Cek kondisi WHERE untuk AGREEMENT_NO yang muncul
SELECT CASE WHEN AGREEMENT_NO = @gagal1 THEN 'gagal' ELSE 'berhasil' END AS status,inv.invoice_no, agreement_no, invoice_due_date, invoice_status, is_journal_date, invoice_type,
       CASE(invoice_type) WHEN 'penalty' THEN CONVERT(nvarchar(8), invoice_due_date, 112) ELSE CONVERT(nvarchar(8), is_journal_date, 112) END AS date_for_comparison,
       CONVERT(nvarchar(8), GETDATE(), 112) AS eod_date_comparison,
       CAST(invoice_due_date AS date) AS invoice_due_date_cast,
       GETDATE() AS eod_date
FROM ifinopl.dbo.invoice inv
JOIN IFINOPL.dbo.INVOICE_DETAIL ON INVOICE_DETAIL.INVOICE_NO = inv.INVOICE_NO
WHERE agreement_no IN (@berhasil1, @berhasil12, @gagal1)
AND invoice_status = 'post';

SELECT * FROM IFINACC.dbo.JOURNAL WHERE JOURNAL_REFF_NO = '06122.INV.2010.03.2025'
SELECT IS_JOURNAL_DATE,* FROM dbo.INVOICE WHERE INVOICE_NO = '06122.INV.2010.03.2025'