/*
Created by Peter Desmet (INBO)
*/

/* RECORD-LEVEL */

SELECT
  'Event'                               AS type,
  'https://creativecommons.org/licenses/by/4.0/' AS license,
  NULL                                  AS rightsHolder,
  NULL                                  AS datasetID,
  'ICES'                                AS institutionCode,
  'ESAS'                                AS collectionCode,
  'European Seabirds at Sea (ESAS)'     AS datasetName,
  'HumanObservation'                    AS basisOfRecord,
  *
FROM (

/* CAMPAIGNS */

SELECT
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
