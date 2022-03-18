/*
Created by Peter Desmet (INBO)
*/

/* SAMPLE: PLATFORM CODE */

SELECT
  s.CampaignID || ':' || s.SampleID     AS eventID,
  NULL                                  AS occurrenceID,
  'platform code'                       AS measurementType,
  'http://vocab.nerc.ac.uk/collection/C17/current/' AS measurementTypeID,
  shipc.Description                     AS measurementValue,
  'http://vocab.nerc.ac.uk/collection/C17/current/' || shipc.Key AS measurementValueID,
  NULL                                  AS measurementUnit,
  NULL                                  AS measurementUnitID
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
  s.CampaignID || ':' || s.SampleID     AS eventID,
  NULL                                  AS occurrenceID,
  'platform class'                      AS measurementType,
  'http://vocab.ices.dk/?ref=311'       AS measurementTypeID,
  platformclass.Description             AS measurementValue,
  platformclass.Key                     AS measurementValueID, -- TODO
  NULL                                  AS measurementUnit,
  NULL                                  AS measurementUnitID
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
  s.CampaignID || ':' || s.SampleID     AS eventID,
  NULL                                  AS occurrenceID,
  'platform side'                       AS measurementType,
  'http://vocab.ices.dk/?ref=1688'      AS measurementTypeID,
  platformside.Description              AS measurementValue,
  platformside.Key                      AS measurementValueID, -- TODO
  NULL                                  AS measurementUnit,
  NULL                                  AS measurementUnitID
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
  s.CampaignID || ':' || s.SampleID     AS eventID,
  NULL                                  AS occurrenceID,
  'platform height'                     AS measurementType,
  NULL                                  AS measurementTypeID, -- TODO
  s.PlatformHeight                      AS measurementValue,
  NULL                                  AS measurementValueID,
  'm'                                   AS measurementUnit,
  'http://vocab.nerc.ac.uk/collection/P06/current/ULAA' AS measurementUnitID
FROM
  samples AS s
WHERE
  s.PlatformHeight IS NOT NULL
  AND s.CampaignID = {campaign_id}

UNION

/* SAMPLE: TRANSECT WIDTH */

SELECT
  s.CampaignID || ':' || s.SampleID     AS eventID,
  NULL                                  AS occurrenceID,
  'transect width'                      AS measurementType,
  NULL                                  AS measurementTypeID, -- TODO
  s.TransectWidth                       AS measurementValue,
  NULL                                  AS measurementValueID,
  'm'                                   AS measurementUnit,
  'http://vocab.nerc.ac.uk/collection/P06/current/ULAA' AS measurementUnitID
FROM
  samples AS s
WHERE
  s.TransectWidth IS NOT NULL
  AND s.CampaignID = {campaign_id}

UNION

/* SAMPLE: SAMPLING METHOD */

SELECT
  s.CampaignID || ':' || s.SampleID     AS eventID,
  NULL                                  AS occurrenceID,
  'sampling method'                     AS measurementType,
  'http://vocab.ices.dk/?ref=1440'      AS measurementTypeID,
  bdcountmethod.Description             AS measurementValue,
  bdcountmethod.Key                     AS measurementValueID, -- TODO
  NULL                                  AS measurementUnit,
  NULL                                  AS measurementUnitID
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
  s.CampaignID || ':' || s.SampleID     AS eventID,
  NULL                                  AS occurrenceID,
  'primary sampling'                    AS measurementType,
  NULL                                  AS measurementTypeID, -- TODO
  s.PrimarySampling                     AS measurementValue,
  NULL                                  AS measurementValueID,
  NULL                                  AS measurementUnit,
  NULL                                  AS measurementUnitID
FROM
  samples AS s
WHERE
  s.TransectWidth IS NOT NULL
  AND s.CampaignID = {campaign_id}

UNION

/* SAMPLE: TARGET TAXA */

SELECT
  s.CampaignID || ':' || s.SampleID     AS eventID,
  NULL                                  AS occurrenceID,
  'target taxa'                         AS measurementType,
  'http://vocab.ices.dk/?ref=1713'      AS measurementTypeID,
  targettaxa.Description                AS measurementValue,
  targettaxa.Key                        AS measurementValueID, -- TODO
  NULL                                  AS measurementUnit,
  NULL                                  AS measurementUnitID
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
  s.CampaignID || ':' || s.SampleID     AS eventID,
  NULL                                  AS occurrenceID,
  'distance bins'                       AS measurementType,
  NULL                                  AS measurementTypeID, -- TODO
  s.DistanceBins                        AS measurementValue,
  NULL                                  AS measurementValueID,
  NULL                                  AS measurementUnit,
  NULL                                  AS measurementUnitID
FROM
  samples AS s
WHERE
  s.DistanceBins IS NOT NULL
  AND s.CampaignID = {campaign_id}

UNION

/* SAMPLE: USE OF BINOCULARS */

SELECT
  s.CampaignID || ':' || s.SampleID     AS eventID,
  NULL                                  AS occurrenceID,
  'use of binoculars'                   AS measurementType,
  'http://vocab.ices.dk/?ref=1719'      AS measurementTypeID,
  useofbinoculars.Description           AS measurementValue,
  useofbinoculars.Key                   AS measurementValueID, -- TODO
  NULL                                  AS measurementUnit,
  NULL                                  AS measurementUnitID
FROM
  samples AS s
  LEFT JOIN useofbinoculars
    ON s.UseOfBinoculars = useofbinoculars.Key
WHERE
  s.UseOfBinoculars IS NOT NULL
  AND s.CampaignID = {campaign_id}

UNION

/* SAMPLE: NUMBER OF OBSERVERS */

SELECT
  s.CampaignID || ':' || s.SampleID     AS eventID,
  NULL                                  AS occurrenceID,
  'number of observers'                 AS measurementType,
  NULL                                  AS measurementTypeID, -- TODO
  s.NumberOfObservers                   AS measurementValue,
  NULL                                  AS measurementValueID,
  NULL                                  AS measurementUnit,
  NULL                                  AS measurementUnitID
FROM
  samples AS s
WHERE
  s.NumberOfObservers IS NOT NULL
  AND s.CampaignID = {campaign_id}

UNION

/* POSITION: DISTANCE */

SELECT
  s.CampaignID || ':' || s.SampleID || ':' || p.PositionID AS eventID,
  NULL                                  AS occurrenceID,
  'distance'                            AS measurementType,
  NULL                                  AS measurementTypeID, -- TODO
  p.Distance                            AS measurementValue,
  NULL                                  AS measurementValueID,
  'km'                                  AS measurementUnit,
  'http://vocab.nerc.ac.uk/collection/P06/current/ULKM' AS measurementUnitID
FROM
  positions AS p
  LEFT JOIN samples AS s
    ON p.SampleID = s.SampleID
WHERE
  p.Distance IS NOT NULL
  AND s.CampaignID = {campaign_id}

UNION

/* POSITION: AREA */

SELECT
  s.CampaignID || ':' || s.SampleID || ':' || p.PositionID AS eventID,
  NULL                                  AS occurrenceID,
  'area'                                AS measurementType,
  NULL                                  AS measurementTypeID, -- TODO
  p.Area                                AS measurementValue,
  NULL                                  AS measurementValueID,
  'km2'                                 AS measurementUnit,
  'http://vocab.nerc.ac.uk/collection/P06/current/SQKM' AS measurementUnitID
FROM
  positions AS p
  LEFT JOIN samples AS s
    ON p.SampleID = s.SampleID
WHERE
  p.Area IS NOT NULL
  AND s.CampaignID = {campaign_id}
