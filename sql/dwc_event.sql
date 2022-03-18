/*
Created by Peter Desmet (INBO)
*/

-- CAMPAIGNS
SELECT
-- RECORD-LEVEL
-- basisOfRecord
  'HumanObservation' AS basisOfRecord,

-- EVENT
-- eventID
  c.CampaignID AS eventID,
-- parentEventID
  NULL AS parentEventID,
-- eventDate
  date(c.StartDate) || '/' || date(c.EndDate) AS eventDate,
-- eventRemarks
  c.Notes AS eventRemarks,

-- LOCATION
-- decimalLatitude
  NULL AS decimalLatitude,
-- decimalLongitude
  NULL AS decimalLongitude,
-- geodeticDatum
  NULL AS geodeticDatum

FROM
  samples AS s
  LEFT JOIN campaigns AS c
    ON s.CampaignID = c.campaignID

WHERE
  c.CampaignID = {campaign_id}

UNION

-- SAMPLES
SELECT
-- RECORD-LEVEL
-- basisOfRecord
  'HumanObservation' AS basisOfRecord,

-- EVENT
-- eventID
  c.CampaignID || ':' || s.SampleID AS eventID,
-- parentEventID
  c.CampaignID AS parentEventID,
-- eventDate
  date(s.Date) AS eventDate,
-- eventRemarks
  s.Notes AS eventRemarks,

-- LOCATION
-- decimalLatitude
  NULL AS decimalLatitude,
-- decimalLongitude
  NULL AS decimalLongitude,
-- geodeticDatum
  NULL AS geodeticDatum

FROM
  samples AS s
  LEFT JOIN campaigns AS c
    ON s.CampaignID = c.campaignID

WHERE
  c.CampaignID = {campaign_id}

UNION

-- POSITIONS
SELECT
-- RECORD-LEVEL
-- basisOfRecord
  'HumanObservation' AS basisOfRecord,

-- EVENT
-- eventID
  c.CampaignID || ':' || s.SampleID || ':' || p.PositionID AS eventID,
-- parentEventID
  c.CampaignID || ':' || s.SampleID AS parentEventID,
-- eventDate: p.Time is in UTC
  date(s.Date) || 'T' || time(p.Time) || 'Z' AS eventDate,
-- eventRemarks
  NULL AS eventRemarks,

-- LOCATION
-- decimalLatitude
  p.Latitude AS decimalLatitude,
-- decimalLongitude
  p.Longitude AS decimalLongitude,
-- geodeticDatum
  'EPSG:4326' AS geodeticDatum

FROM
  positions AS p
  LEFT JOIN samples AS s
    ON p.SampleID = s.sampleID
  LEFT JOIN campaigns AS c
    ON s.CampaignID = c.campaignID

WHERE
  c.CampaignID = {campaign_id}
