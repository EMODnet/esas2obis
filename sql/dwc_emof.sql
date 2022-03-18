/*
Created by Peter Desmet (INBO)
*/

/* SAMPLE: PLATFORM CODE */

SELECT
-- eventID
  s.CampaignID || ':' || s.SampleID AS eventID,
-- occurrenceID
  NULL AS occurrenceID,
-- measurementType
  'platform code' AS measurementType,
-- measurementTypeID
  'http://vocab.nerc.ac.uk/collection/C17/current/' AS measurementTypeID,
-- measurementValue
  shipc.Description AS measurementValue,
-- measurementValueID
  'http://vocab.nerc.ac.uk/collection/C17/current/' || shipc.Key AS measurementValueID,
-- measurementUnit
  NULL AS measurementUnit,
-- measurementUnitID
  NULL AS measurementUnitID
FROM
  samples AS s
  LEFT JOIN shipc
    ON s.PlatformCode = shipc.Key
WHERE
  s.PlatformCode IS NOT NULL
  AND s.CampaignID = {campaign_id}

UNION

/* SAMPLE: PLATFORM CLASS */

SELECT
-- eventID
  s.CampaignID || ':' || s.SampleID AS eventID,
-- occurrenceID
  NULL AS occurrenceID,
-- measurementType
  'platform class' AS measurementType,
-- measurementTypeID
  'http://vocab.ices.dk/?ref=311' AS measurementTypeID,
-- measurementValue
  platformclass.Description AS measurementValue,
-- measurementValueID
  platformclass.Key AS measurementValueID, -- TODO
-- measurementUnit
  NULL AS measurementUnit,
-- measurementUnitID
  NULL AS measurementUnitID
FROM
  samples AS s
  LEFT JOIN platformclass
    ON s.PlatformClass = platformclass.Key
WHERE
  s.PlatformClass IS NOT NULL
  AND s.CampaignID = {campaign_id}

UNION

/* SAMPLE: PLATFORM SIDE */

SELECT
-- eventID
  s.CampaignID || ':' || s.SampleID AS eventID,
-- occurrenceID
  NULL AS occurrenceID,
-- measurementType
  'platform side' AS measurementType,
-- measurementTypeID
  'http://vocab.ices.dk/?ref=1688' AS measurementTypeID,
-- measurementValue
  platformside.Description AS measurementValue,
-- measurementValueID
  platformside.Key AS measurementValueID, -- TODO
-- measurementUnit
  NULL AS measurementUnit,
-- measurementUnitID
  NULL AS measurementUnitID
FROM
  samples AS s
  LEFT JOIN platformside
    ON s.PlatformSide = platformside.Key
WHERE
  s.PlatformSide IS NOT NULL
  AND s.CampaignID = {campaign_id}

UNION

/* SAMPLE: PLATFORM HEIGHT */

SELECT
-- eventID
  s.CampaignID || ':' || s.SampleID AS eventID,
-- occurrenceID
  NULL AS occurrenceID,
-- measurementType
  'platform height' AS measurementType,
-- measurementTypeID
  NULL AS measurementTypeID, -- TODO
-- measurementValue
  s.PlatformHeight AS measurementValue,
-- measurementValueID
  NULL AS measurementValueID,
-- measurementUnit
  'm' AS measurementUnit,
-- measurementUnitID
  'http://vocab.nerc.ac.uk/collection/P06/current/ULAA' AS measurementUnitID
FROM
  samples AS s
WHERE
  s.PlatformHeight IS NOT NULL
  AND s.CampaignID = {campaign_id}

UNION

/* SAMPLE: TRANSECT WIDTH */

SELECT
-- eventID
  s.CampaignID || ':' || s.SampleID AS eventID,
-- occurrenceID
  NULL AS occurrenceID,
-- measurementType
  'transect width' AS measurementType,
-- measurementTypeID
  NULL AS measurementTypeID, -- TODO
-- measurementValue
  s.TransectWidth AS measurementValue,
-- measurementValueID
  NULL AS measurementValueID,
-- measurementUnit
  'm' AS measurementUnit,
-- measurementUnitID
  'http://vocab.nerc.ac.uk/collection/P06/current/ULAA' AS measurementUnitID
FROM
  samples AS s
WHERE
  s.TransectWidth IS NOT NULL
  AND s.CampaignID = {campaign_id}

UNION

/* SAMPLE: SAMPLING METHOD */

SELECT
-- eventID
  s.CampaignID || ':' || s.SampleID AS eventID,
-- occurrenceID
  NULL AS occurrenceID,
-- measurementType
  'sampling method' AS measurementType,
-- measurementTypeID
  'http://vocab.ices.dk/?ref=1440' AS measurementTypeID,
-- measurementValue
  bdcountmethod.Description AS measurementValue,
-- measurementValueID
  bdcountmethod.Key AS measurementValueID, -- TODO
-- measurementUnit
  NULL AS measurementUnit,
-- measurementUnitID
  NULL AS measurementUnitID
FROM
  samples AS s
  LEFT JOIN bdcountmethod
    ON s.SamplingMethod = bdcountmethod.Key
WHERE
  s.SamplingMethod IS NOT NULL
  AND s.CampaignID = {campaign_id}

UNION

/* SAMPLE: PRIMARY SAMPLING */

SELECT
-- eventID
  s.CampaignID || ':' || s.SampleID AS eventID,
-- occurrenceID
  NULL AS occurrenceID,
-- measurementType
  'primary sampling' AS measurementType,
-- measurementTypeID
  NULL AS measurementTypeID, -- TODO
-- measurementValue
  s.PrimarySampling AS measurementValue,
-- measurementValueID
  NULL AS measurementValueID,
-- measurementUnit
  NULL AS measurementUnit,
-- measurementUnitID
  NULL AS measurementUnitID
FROM
  samples AS s
WHERE
  s.TransectWidth IS NOT NULL
  AND s.CampaignID = {campaign_id}

UNION

/* SAMPLE: TARGET TAXA */

SELECT
-- eventID
  s.CampaignID || ':' || s.SampleID AS eventID,
-- occurrenceID
  NULL AS occurrenceID,
-- measurementType
  'target taxa' AS measurementType,
-- measurementTypeID
  'http://vocab.ices.dk/?ref=1713' AS measurementTypeID,
-- measurementValue
  targettaxa.Description AS measurementValue,
-- measurementValueID
  targettaxa.Key AS measurementValueID,
-- measurementUnit
  NULL AS measurementUnit,
-- measurementUnitID
  NULL AS measurementUnitID
FROM
  samples AS s
  LEFT JOIN targettaxa
    ON s.TargetTaxa = targettaxa.Key
WHERE
  s.TargetTaxa IS NOT NULL
  AND s.CampaignID = {campaign_id}

UNION

/* SAMPLE: DISTANCE BINS */

SELECT
-- eventID
  s.CampaignID || ':' || s.SampleID AS eventID,
-- occurrenceID
  NULL AS occurrenceID,
-- measurementType
  'distance bins' AS measurementType,
-- measurementTypeID
  NULL AS measurementTypeID, -- TODO
-- measurementValue
  s.DistanceBins AS measurementValue,
-- measurementValueID
  NULL AS measurementValueID,
-- measurementUnit
  NULL AS measurementUnit,
-- measurementUnitID
  NULL AS measurementUnitID
FROM
  samples AS s
WHERE
  s.DistanceBins IS NOT NULL
  AND s.CampaignID = {campaign_id}

UNION

/* SAMPLE: USE OF BINOCULARS */

SELECT
-- eventID
  s.CampaignID || ':' || s.SampleID AS eventID,
-- occurrenceID
  NULL AS occurrenceID,
-- measurementType
  'use of binoculars' AS measurementType,
-- measurementTypeID
  'http://vocab.ices.dk/?ref=1719' AS measurementTypeID,
-- measurementValue
  useofbinoculars.Description AS measurementValue,
-- measurementValueID
  useofbinoculars.Key AS measurementValueID, -- TODO
-- measurementUnit
  NULL measurementUnit,
-- measurementUnitID
  NULL as measurementUnitID
FROM
  samples AS s
  LEFT JOIN useofbinoculars
    ON s.UseOfBinoculars = useofbinoculars.Key
WHERE
  s.UseOfBinoculars IS NOT NULL
  AND s.CampaignID = {campaign_id}
