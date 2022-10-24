/* OCCURRENCE EXTENSION */

SELECT
  c.CampaignID || '_' || s.SampleID || '_' || p.PositionID AS eventID,
-- RECORD-LEVEL
  'HumanObservation'                    AS basisOfRecord,
-- OCCURRENCE
  c.CampaignID || '_' || s.SampleID || '_' || p.PositionID || '_' || o.ObservationID AS occurrenceID,
-- recordedBy: observer name(s) not available
  o.Count                               AS individualCount, -- Also in EMOF
  CASE
    -- http://vocab.nerc.ac.uk/collection/S10/current/
    WHEN o.Sex = 'F' THEN 'female'
    WHEN o.Sex = 'M' THEN 'male'
    -- All other values are ignored, but are typically not used by ESAS
  END                                   AS sex, -- Also in EMOF with orig vocab
  CASE
    -- http://vocab.nerc.ac.uk/collection/S11/current/
    WHEN o.LifeStage = 'A' THEN 'adult'
    WHEN o.LifeStage IN ('I', 1, 2, 3, 4, 5) THEN 'immature'
  END                                   AS lifeStage, -- Also in EMOF with orig vocab
  behaviour.Description                 AS behavior, -- Also in EMOF
  'present'                             AS occurrenceStatus,
  CASE
    WHEN o.Association = '10' THEN 'Pisces'
    WHEN o.Association = '11' THEN 'Cetacea'
    -- All other associations are non biological
  END                                   AS associatedTaxa, -- Also in EMOF with orig vocab
  o.Notes                               AS occurrenceRemarks,
-- IDENTIFICATION
-- identifiedBy: observer name(s) not available
-- TAXON
  'urn:lsid:marinespecies.org:taxname:' || o.wormsAphiaID AS scientificNameID,
  o.speciesScientificName               AS scientificName,
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
  LEFT JOIN behaviour
    ON o.Behaviour = behaviour.Key
ORDER BY
  c.CampaignID || '_' || s.SampleID || '_' || p.PositionID || '_' || o.ObservationID -- occurrenceID
