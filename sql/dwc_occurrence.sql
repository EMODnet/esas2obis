/*
Created by Peter Desmet (INBO)
*/
SELECT
  p.positionID                          AS eventID,
-- OCCURRENCE
  o.ObservationID                       AS occurrenceID,
-- recordedBy: observer name(s) not available
  CASE
    WHEN o.Sex = 'F' THEN 'female'
    WHEN o.Sex = 'M' THEN 'male'
  END                                   AS sex, -- http://vocab.nerc.ac.uk/collection/S10/current/
  CASE
    WHEN o.LifeStage = 'A' THEN 'adult'
    WHEN o.LifeStage IN ('I', 1, 2, 3, 4, 5) THEN 'immature'
  END                                   AS lifeStage, -- http://vocab.nerc.ac.uk/collection/S11/current/
  beh.description                       AS behavior,
  'present'                             AS occurrenceStatus,
  CASE
    WHEN o.Association = '10' THEN 'Pisces'
    WHEN o.Association = '10' THEN 'Cetacea'
  END                                   AS associatedTaxa,
  o.Notes                               AS occurrenceRemarks,
-- IDENTIFICATION
-- identifiedBy: observer name(s) not available
-- TAXON
  CASE
    WHEN sp.aphia_id IS NOT NULL THEN 'urn:lsid:marinespecies.org:taxname:' || sp.aphia_id
  END                                   AS scientificNameID,
  sp.euring_scientific_name             AS scientificName,
  'Animalia'                            AS kingdom
-- taxonRank: not available
FROM
  observations AS o
  LEFT JOIN positions AS p
    ON o.PositionID = p.PositionID
  LEFT JOIN samples AS s
    ON p.SampleID = s.SampleID
  LEFT JOIN campaigns AS c
    ON s.CampaignID = c.CampaignID
  LEFT JOIN species AS sp
    ON o.SpeciesCode = sp.euring_code
  LEFT JOIN behaviour AS beh
    ON o.Behaviour = beh.Key
WHERE
  c.CampaignID = {campaign_id}
