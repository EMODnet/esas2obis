/*
Created by Peter Desmet (INBO)
*/
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
  s.Date || 'T' || p.Time || 'Z' AS eventDate,

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

LIMIT {limit}
