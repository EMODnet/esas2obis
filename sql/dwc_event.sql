/* EVENT CORE */

/* HELPER TABLE FOR DATA RIGHTS HOLDERS

Key       | Description
--------- | -----------
3269      | Federal Agency for Nature Conservation (BfN)
3269~2299 | Federal Agency for Nature Conservation (BfN) | Research and Technology Centre (Buesum) (FTZ)
*/
WITH datarightsholders AS (
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
  NULL                                  AS coordinateUncertaintyInMeters
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
  NULL                                  AS coordinateUncertaintyInMeters
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
  COALESCE(
  /*
  Coordinate uncertainty is not recorded and can very a lot (e.g. historical vs current data).
  We make a best attempt by:
  - Assuming coordinates are recorded by GPS: 30m, http://rs.tdwg.org/dwc/terms/coordinateUncertaintyInMeters
  - Assuming coordinates are precise to 3 decimals: 157m, https://doi.org/10.15468/doc-gg7h-s853#table-uncertainty
  - Considering the Distance that the ship has travelled: converted from km to m
  - Not considering the ObservationDistance, because it can vary too much (0 - 5km)
  */
    30 + 157 + ROUND(p.distance * 1000),
    30 + 157
  )                                     AS coordinateUncertaintyInMeters
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
