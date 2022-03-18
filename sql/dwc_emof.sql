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
  NULL as measurementUnit,
-- measurementUnitID
  NULL as measurementUnitID
FROM
  samples AS s
  LEFT JOIN shipc AS shipc
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
  NULL as measurementUnit,
-- measurementUnitID
  NULL as measurementUnitID
FROM
  samples AS s
  LEFT JOIN platformclass AS platformclass
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
  NULL as measurementUnit,
-- measurementUnitID
  NULL as measurementUnitID
FROM
  samples AS s
  LEFT JOIN platformside AS platformside
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
  'm' as measurementUnit,
-- measurementUnitID
  'http://vocab.nerc.ac.uk/collection/P06/current/ULAA' as measurementUnitID
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
  'm' as measurementUnit,
-- measurementUnitID
  'http://vocab.nerc.ac.uk/collection/P06/current/ULAA' as measurementUnitID
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
  NULL as measurementUnit,
-- measurementUnitID
  NULL as measurementUnitID
FROM
  samples AS s
  LEFT JOIN bdcountmethod AS bdcountmethod
    ON s.SamplingMethod = bdcountmethod.Key
WHERE
  s.SamplingMethod IS NOT NULL
  AND s.CampaignID = {campaign_id}
