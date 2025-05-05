BEGIN TRANSACTION 
DECLARE @temp TABLE 
(a NVARCHAR(50)) INSERT INTO @temp (a) VALUES

('1000AA20220800001'),
('BYD.BYDFRK.BFEB35'),
('BYD.BYDFRK.ECB25B'),
('DSFMIT231100058'),
('DSFMIT231100059'),
('DSFMIT231200010'),
('DSFMIT240100023'),
('DSFMIT240200001'),
('DSFMIT240500020'),
('DSFMIT240500021'),
('DSFMIT240500022'),
('DSFMIT240500023'),
('DSFMIT240500024'),
('DSFMIT240500025'),
('DSFMIT240500028'),
('DSFMIT240500029'),
('DSFMIT240500031'),
('DSFMIT240500032'),
('DSFMIT240500034'),
('DSFMIT240700009'),
('DSFMIT240700010'),
('DSFMIT240700011'),
('DSFMIT240700012'),
('DSFMIT240700013'),
('DSFMIT240700014'),
('DSFMIT240700015'),
('DSFMIT240700016'),
('DSFMIT240700017'),
('DSFMIT240700018'),
('DSFMIT240700019'),
('DSFMIT240700020'),
('DSFMIT240700034'),
('DSFMIT240800030'),
('DSFMIT240800038'),
('DSFMIT240800039'),
('DSFMIT240800040'),
('DSFMIT240800172'),
('DSFMIT240800173'),
('DSFMIT240800194'),
('DSFMIT240800210'),
('DSFMIT240800230'),
('DSFMIT241200009'),
('DSFMIT241200010'),
('DSFMIT241200035'),
('DSFMIT250300017'),
('H-004.EXC.SK130H'),
('M-000.OT.CON503'),
('M-000.OT.MDRM35'),
('M-050.CRN.MCV24E'),
('M-104.OT.XCE345'),
('M-109.HOP.HP30FE'),
('V-001.FGT.FN2FHRM'),
('V-001.FSO.FN2HDM'),
('V-001.L20.TDCE4M'),
('V-001.L20.TDCU4A'),
('V-001.L20.TDGS4M'),
('V-001.L20.TSGX2M'),
('V-001.PJR.P21D2B'),
('V-001.PJR.P21D2W'),
('V-001.PJR.P21EAB'),
('V-001.PJR.P21EAW'),
('V-001.PJR.P21EMB'),
('V-001.PJR.P21EMW'),
('V-001.PJR.P21G4B'),
('V-001.PJR.P21G4W'),
('V-001.PJR.P21U2B'),
('V-001.PJR.P21U2W'),
('V-001.PJR.P21U4B'),
('V-001.PJR.P21U4W'),
('V-001.PJR.P22D2B'),
('V-001.PJR.P22D2W'),
('V-001.PJR.P22EAB'),
('V-001.PJR.P22EAW'),
('V-001.PJR.P22EMB'),
('V-001.PJR.P22EMW'),
('V-001.PJR.P22G4B'),
('V-001.PJR.P22G4W'),
('V-001.PJR.P22U2B'),
('V-001.PJR.P22U2W'),
('V-001.PJR.P22U4B'),
('V-001.PJR.P22U4W'),
('V-001.PJR.P23D2B'),
('V-001.PJR.P23D2W'),
('V-001.PJR.P23U2B'),
('V-001.PJR.P23U2W'),
('V-001.PJR.P23U4B'),
('V-001.PJR.PDUK8A'),
('V-001.PJR.PSD28L'),
('V-001.PJR.PSD2LR'),
('V-001.PJR.PSD2LW'),
('V-001.PJR.PSD2UL'),
('V-001.PJR.PSD2UW'),
('V-001.PJR.PSD48L'),
('V-001.PJR.PSDC2A'),
('V-001.PJR.PSDC2W'),
('V-001.PJR.PSDC4A'),
('V-001.PJR.PSDC4W'),
('V-001.PJR.PSDCAT'),
('V-001.PJR.PSDK8A'),
('V-001.PJR.PSDU8A'),
('V-001.PJR.PSDU8W'),
('V-001.PJR.PSEC2A'),
('V-001.PJR.PSEC2M'),
('V-001.PJR.PSEC2U'),
('V-001.PJR.PSEC2W'),
('V-001.PJR.PSECUA'),
('V-001.PJR.PSGC4W'),
('V-001.PJR.PSHIC4'),
('V-002.HLX.HSCD4M'),
('V-004.GMX.GM13FH'),
('V-012.TRK.TFH550')

--SELECT  * into XXX_OPL_INTERFACE_MASTER_ITEM_250425_fix FROM IFINOPL.dbo.OPL_INTERFACE_MASTER_ITEM		
--SELECT  * into XXX_master_electronic_unit_250425_fix FROM IFINOPL.dbo.master_electronic_unit			
--SELECT  * into XXX_master_he_unit_250425_fix FROM IFINOPL.dbo.master_he_unit					
--SELECT  * into XXX_master_vehicle_unit_250425_fix FROM IFINOPL.dbo.master_vehicle_unit			
--SELECT  * into XXX_master_machinery_unit_250425_fix FROM IFINOPL.dbo.master_machinery_unit		
--SELECT * FROM @temp
SELECT  ITEM_NAME,TYPE_NAME,* FROM IFINOPL.dbo.OPL_INTERFACE_MASTER_ITEM WHERE ITEM_CODE IN (SELECT a FROM @temp)
SELECT  description,electronic_name,* FROM IFINOPL.dbo.master_electronic_unit WHERE code IN (SELECT a FROM @temp)
SELECT  description,he_name,* FROM IFINOPL.dbo.master_he_unit WHERE code IN (SELECT a FROM @temp)
SELECT  description,vehicle_name,* FROM IFINOPL.dbo.master_vehicle_unit WHERE code IN (SELECT a FROM @temp)
SELECT  description,machinery_name,* FROM IFINOPL.dbo.master_machinery_unit WHERE code IN (SELECT a FROM @temp)

UPDATE IFINOPL.dbo.OPL_INTERFACE_MASTER_ITEM
SET
    ITEM_NAME = mi.DESCRIPTION,
    TYPE_NAME = mi.DESCRIPTION
FROM
    IFINOPL.dbo.OPL_INTERFACE_MASTER_ITEM oi
INNER JOIN
    dbo.MASTER_ITEM mi ON oi.ITEM_CODE = mi.CODE
WHERE
    oi.ITEM_CODE IN (SELECT a FROM @temp) AND TYPE_NAME <> 'OTHER'; 
------------------------------------------------------------------------------
UPDATE IFINOPL.dbo.master_electronic_unit
SET
    description = mi.DESCRIPTION,
    electronic_name = mi.DESCRIPTION
FROM
    IFINOPL.dbo.master_electronic_unit oi
INNER JOIN
    dbo.MASTER_ITEM mi ON oi.CODE = mi.CODE
WHERE
    oi.CODE IN (SELECT a FROM @temp)-- AND TYPE_NAME <> 'OTHER'; 
------------------------------------------------------------------------------
UPDATE IFINOPL.dbo.master_he_unit
SET
    description = mi.DESCRIPTION,
    he_name = mi.DESCRIPTION
FROM
    IFINOPL.dbo.master_he_unit oi
INNER JOIN
    dbo.MASTER_ITEM mi ON oi.CODE = mi.CODE
WHERE
    oi.CODE IN (SELECT a FROM @temp) --AND TYPE_NAME <> 'OTHER'; 
------------------------------------------------------------------------------
UPDATE IFINOPL.dbo.master_vehicle_unit
SET
    description = mi.DESCRIPTION,
    vehicle_name = mi.DESCRIPTION
FROM
    IFINOPL.dbo.master_vehicle_unit oi
INNER JOIN
    dbo.MASTER_ITEM mi ON oi.CODE = mi.CODE
WHERE
    oi.CODE IN (SELECT a FROM @temp) --AND TYPE_NAME <> 'OTHER'; 
------------------------------------------------------------------------------
UPDATE IFINOPL.dbo.master_machinery_unit
SET
    description = mi.DESCRIPTION,
    machinery_name = mi.DESCRIPTION
FROM
    IFINOPL.dbo.master_machinery_unit oi
INNER JOIN
    dbo.MASTER_ITEM mi ON oi.CODE = mi.CODE
WHERE
    oi.CODE IN (SELECT a FROM @temp) --AND TYPE_NAME <> 'OTHER'; 
------------------------------------------------------------------------------



SELECT  ITEM_NAME,TYPE_NAME,* FROM IFINOPL.dbo.OPL_INTERFACE_MASTER_ITEM WHERE ITEM_CODE IN (SELECT a FROM @temp)
SELECT  description,electronic_name,* FROM IFINOPL.dbo.master_electronic_unit WHERE code IN (SELECT a FROM @temp)
SELECT  description,he_name,* FROM IFINOPL.dbo.master_he_unit WHERE code IN (SELECT a FROM @temp)
SELECT  description,vehicle_name,* FROM IFINOPL.dbo.master_vehicle_unit WHERE code IN (SELECT a FROM @temp)
SELECT  description,machinery_name,* FROM IFINOPL.dbo.master_machinery_unit WHERE code IN (SELECT a FROM @temp)
ROLLBACK TRANSACTION 