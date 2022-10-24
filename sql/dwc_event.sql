/* EVENT CORE */

*/

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
  edmo.Description                      AS rightsHolder,
  'cruise'                              AS type,
-- EVENT
  c.CampaignID                          AS eventID,
  NULL                                  AS parentEventID,
  date(c.StartDate) || '/' || date(c.EndDate) AS eventDate,
  c.Notes                               AS eventRemarks,
-- LOCATION
  NULL                                  AS decimalLatitude,
  NULL                                  AS decimalLongitude,
  NULL                                  AS geodeticDatum
FROM
  campaigns AS c
  LEFT JOIN edmo
    ON c.DataRightsHolder = edmo.Key

UNION

/* SAMPLES */

SELECT
-- RECORD-LEVEL
  edmo.Description                      AS rightsHolder,
  'sample'                              AS type,
-- EVENT
  c.CampaignID || '_' || s.SampleID     AS eventID,
  c.CampaignID                          AS parentEventID,
  date(s.Date)                          AS eventDate,
  s.Notes                               AS eventRemarks,
-- LOCATION
  NULL                                  AS decimalLatitude,
  NULL                                  AS decimalLongitude,
  NULL                                  AS geodeticDatum
FROM
  samples AS s
  LEFT JOIN campaigns AS c
    ON s.CampaignID = c.campaignID
  LEFT JOIN edmo
    ON c.DataRightsHolder = edmo.Key

UNION

/* POSITIONS */

SELECT
-- RECORD-LEVEL
  edmo.Description                      AS rightsHolder,
  'subSample'                           AS type,
-- EVENT
  c.CampaignID || '_' || s.SampleID || '_' || p.PositionID AS eventID,
  c.CampaignID || '_' || s.SampleID     AS parentEventID,
  date(s.Date) || 'T' || time(p.Time) || 'Z' AS eventDate, -- p.Time is in UTC
  NULL                                  AS eventRemarks,
-- LOCATION
  p.Latitude                            AS decimalLatitude,
  p.Longitude                           AS decimalLongitude,
  'EPSG:4326'                           AS geodeticDatum
FROM
  positions AS p
  LEFT JOIN samples AS s
    ON p.SampleID = s.sampleID
  LEFT JOIN campaigns AS c
    ON s.CampaignID = c.campaignID
  LEFT JOIN edmo
    ON c.DataRightsHolder = edmo.Key
)
ORDER BY
  eventID
