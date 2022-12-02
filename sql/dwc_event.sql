/*
Schema: https://rs.gbif.org/core/dwc_event_2022-02-02.xml
*/

/* HELPER TABLES */

WITH
-- DATA RIGHTS HOLDERS
-- Concatenate up to 3 data rights holders with " | " into a single value
-- E.g. Federal Agency for Nature Conservation (BfN) | Research and Technology Centre (Buesum) (FTZ)
datarightsholders AS (
  SELECT
    DataRightsHolder AS Key,
    COALESCE(
      edmo_1.Description || ' | ' || edmo_2.Description || ' | ' || edmo_3.Description,
      edmo_1.Description || ' | ' || edmo_2.Description,
      edmo_1.Description
    ) AS Description
  FROM
    (
      SELECT DISTINCT
        DataRightsHolder,
        DataRightsHolder_1,
        DataRightsHolder_2,
        DataRightsHolder_3
      FROM
        campaigns
    ) AS c
    LEFT JOIN edmo AS edmo_1
      ON c.DataRightsHolder_1 = edmo_1.Key
    LEFT JOIN edmo AS edmo_2
      ON c.DataRightsHolder_2 = edmo_2.Key
    LEFT JOIN edmo AS edmo_3
      ON c.DataRightsHolder_3 = edmo_3.Key
)

/* RECORD-LEVEL */

SELECT
  'ICES'                                AS institutionCode,
  'ESAS'                                AS collectionCode,
  'https://esas.ices.dk'                AS datasetID,
  'European Seabirds At Sea (ESAS)'     AS datasetName,
  'https://creativecommons.org/licenses/by/4.0/' AS license,
  -- Type is set to specific values, rather than 'Event' for all
  -- See https://github.com/iobis/env-data/issues/4#issuecomment-331807994
  *
FROM (

/* CAMPAIGNS */

SELECT
-- RECORD-LEVEL
  datarightsholders.Description         AS rightsHolder,
  'cruise'                              AS type,
-- EVENT
  c.CampaignID                          AS eventID,
  NULL                                  AS parentEventID,
  date(c.StartDate) || '/' || date(c.EndDate) AS eventDate,
  c.Notes                               AS eventRemarks,
-- LOCATION
  NULL                                  AS decimalLatitude,
  NULL                                  AS decimalLongitude,
  NULL                                  AS geodeticDatum,
  NULL                                  AS georeferenceRemarks
FROM
  campaigns AS c
  LEFT JOIN datarightsholders
    ON c.DataRightsHolder = datarightsholders.Key

UNION

/* SAMPLES */

SELECT
-- RECORD-LEVEL
  datarightsholders.Description         AS rightsHolder,
  'sample'                              AS type,
-- EVENT
  c.CampaignID || '_' || s.SampleID     AS eventID,
  c.CampaignID                          AS parentEventID,
  date(s.Date)                          AS eventDate,
  s.Notes                               AS eventRemarks,
-- LOCATION
  NULL                                  AS decimalLatitude,
  NULL                                  AS decimalLongitude,
  NULL                                  AS geodeticDatum,
  NULL                                  AS georeferenceRemarks
FROM
  samples AS s
  LEFT JOIN campaigns AS c
    ON s.CampaignID = c.campaignID
  LEFT JOIN datarightsholders
    ON c.DataRightsHolder = datarightsholders.Key

UNION

/* POSITIONS */

SELECT
-- RECORD-LEVEL
  datarightsholders.Description         AS rightsHolder,
  'subSample'                           AS type,
-- EVENT
  c.CampaignID || '_' || s.SampleID || '_' || p.PositionID AS eventID,
  c.CampaignID || '_' || s.SampleID     AS parentEventID,
  date(s.Date) || 'T' || time(p.Time) || 'Z' AS eventDate, -- p.Time is in UTC
  NULL                                  AS eventRemarks,
-- LOCATION
  p.Latitude                            AS decimalLatitude,
  p.Longitude                           AS decimalLongitude,
  'EPSG:4326'                           AS geodeticDatum,
  'coordinate uncertainty unknown, see https://github.com/inbo/esas2obis/issues/5' AS georeferenceRemarks
FROM
  positions AS p
  LEFT JOIN samples AS s
    ON p.SampleID = s.sampleID
  LEFT JOIN campaigns AS c
    ON s.CampaignID = c.campaignID
  LEFT JOIN datarightsholders
    ON c.DataRightsHolder = datarightsholders.Key
)
ORDER BY
  eventID
