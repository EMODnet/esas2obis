/*
Created by Peter Desmet (INBO)
*/
SELECT
-- eventID
  c.CampaignID || ':' || s.SampleID AS eventID,
-- measurementID
-- occurrenceID
-- measurementType
  'platform' AS measurementType,
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
  LEFT JOIN campaigns AS c
    ON s.CampaignID = c.campaignID
  LEFT JOIN shipc AS shipc
    ON s.PlatformCode = shipc.Key

WHERE
  c.CampaignID = {campaign_id}

