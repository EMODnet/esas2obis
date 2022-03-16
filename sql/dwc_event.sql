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
  campaigns AS c
  LEFT JOIN samples AS s
    ON c.CampaignID = s.CampaignID
  LEFT JOIN positions AS p
    ON s.SampleID = p.SampleID
