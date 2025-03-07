/*
Schema: https://rs.gbif.org/core/dwc_occurrence_2022-02-02.xml
*/

/* HELPER TABLES */

WITH
-- BEHAVIOURS
-- Concatenate up to 3 behaviours with " | " into a single value
-- E.g. Courtship display | Play
behaviours AS (
  SELECT
    Behaviour AS Key,
    COALESCE(
      behaviour_1.Description || ' | ' || behaviour_2.Description || ' | ' || behaviour_3.Description,
      behaviour_1.Description || ' | ' || behaviour_2.Description,
      behaviour_1.Description
    ) AS Description
  FROM
    (
      SELECT DISTINCT
        Behaviour,
        Behaviour_1,
        Behaviour_2,
        Behaviour_3
      FROM
        observations
    ) AS o
    LEFT JOIN behaviour AS behaviour_1
      ON o.behaviour_1 = behaviour_1.Key
    LEFT JOIN behaviour AS behaviour_2
      ON o.behaviour_2 = behaviour_2.Key
    LEFT JOIN behaviour AS behaviour_3
      ON o.behaviour_3 = behaviour_3.Key
)

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
  lower(behaviours.Description)         AS behavior, -- Also in EMOF
  CASE
    WHEN o.Count = 0 OR o.Count = '0' THEN 'absent'
    ELSE 'present'
  END                                   AS occurrenceStatus,
  CASE
    WHEN o.Association_1 = '10' OR o.Association_2 = '10' OR o.Association_3 = '10' THEN 'Pisces'
    WHEN o.Association_1 = '11' OR o.Association_2 = '11' OR o.Association_3 = '11' THEN 'Cetacea'
    -- All other associations are non biological
  END                                   AS associatedTaxa, -- Also in EMOF with orig vocab
  o.Notes                               AS occurrenceRemarks,
-- IDENTIFICATION
-- identifiedBy: observer name(s) not available
-- TAXON
  'urn:lsid:marinespecies.org:taxname:' || o.WormsAphiaID AS scientificNameID,
  CASE
    WHEN o.SpeciesScientificName IS NOT NULL THEN o.SpeciesScientificName
    ELSE o.WormsScientificName -- Use WoRMS name in case scientific name is empty (e.g. "Cetacea" for "unidentified small whale")
  END                                   AS scientificName,
  'Animalia'                            AS kingdom,
-- taxonRank: not available
  o.SpeciesEnglishName                  AS vernacularName
FROM
  observations AS o
  LEFT JOIN positions AS p
    ON o.PositionID = p.PositionID
  LEFT JOIN samples AS s
    ON p.SampleID = s.SampleID
  LEFT JOIN campaigns AS c
    ON s.CampaignID = c.CampaignID
  LEFT JOIN behaviours
    ON o.Behaviour = behaviours.Key
ORDER BY
  c.CampaignID || '_' || s.SampleID || '_' || p.PositionID || '_' || o.ObservationID -- occurrenceID
