/*
Created by Peter Desmet (INBO)
*/

/* RECORD-LEVEL */

SELECT
  'ICES'                                AS institutionCode,
  'ESAS'                                AS collectionCode,
  'https://esas.ices.dk'                AS datasetID,
  'European Seabirds At Sea (ESAS)'     AS datasetName,
  'https://creativecommons.org/licenses/by/4.0/' AS license,
  NULL                                  AS rightsHolder,
  'HumanObservation'                    AS basisOfRecord,
  -- Type is set to specific values, rather than 'Event' for all
  -- See https://github.com/iobis/env-data/issues/4#issuecomment-331807994
  *
FROM (

/* CAMPAIGNS */

SELECT
-- RECORD-LEVEL
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
  samples AS s
  LEFT JOIN campaigns AS c
    ON s.CampaignID = c.campaignID
WHERE
  c.CampaignID IN ({campaign_id*})

UNION

/* SAMPLES */

SELECT
-- RECORD-LEVEL
  'sample'                              AS type,
-- EVENT
  c.CampaignID || ':' || s.SampleID     AS eventID,
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
WHERE
  c.CampaignID IN ({campaign_id*})

UNION

/* POSITIONS */

SELECT
-- RECORD-LEVEL
  'subSample'                           AS type,
-- EVENT
  c.CampaignID || ':' || s.SampleID || ':' || p.PositionID AS eventID,
  c.CampaignID || ':' || s.SampleID     AS parentEventID,
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
WHERE
  c.CampaignID IN ({campaign_id*})
)
ORDER BY
  eventID
