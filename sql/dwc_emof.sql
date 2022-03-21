/*
Created by Peter Desmet (INBO)
*/

/* SAMPLE: PLATFORM CODE */

SELECT
  s.CampaignID || ':' || s.SampleID     AS eventID,
  NULL                                  AS occurrenceID,
  'platform code'                       AS measurementType,
  'http://vocab.nerc.ac.uk/collection/C17/current/' AS measurementTypeID,
  shipc.Description                     AS measurementValue,
  'http://vocab.nerc.ac.uk/collection/C17/current/' || shipc.Key AS measurementValueID,
  NULL                                  AS measurementUnit,
  NULL                                  AS measurementUnitID
FROM
  samples AS s
  LEFT JOIN shipc
    ON s.PlatformCode = shipc.Key
WHERE
  s.PlatformCode IS NOT NULL
  AND s.CampaignID IN ({campaign_id*})

UNION

/* SAMPLE: PLATFORM CLASS */

SELECT
  s.CampaignID || ':' || s.SampleID     AS eventID,
  NULL                                  AS occurrenceID,
  'platform class'                      AS measurementType,
  'https://vocab.ices.dk/services/rdf/collection/Platform%20Class' AS measurementTypeID,
  platformclass.Description             AS measurementValue,
  'https://vocab.ices.dk/services/rdf/collection/Platform%20Class/' || platformclass.Key AS measurementValueID,
  NULL                                  AS measurementUnit,
  NULL                                  AS measurementUnitID
FROM
  samples AS s
  LEFT JOIN platformclass
    ON s.PlatformClass = platformclass.Key
WHERE
  s.PlatformClass IS NOT NULL
  AND s.CampaignID IN ({campaign_id*})

UNION

/* SAMPLE: PLATFORM SIDE */

SELECT
  s.CampaignID || ':' || s.SampleID     AS eventID,
  NULL                                  AS occurrenceID,
  'platform side'                       AS measurementType,
  'https://vocab.ices.dk/services/rdf/collection/PlatformSide' AS measurementTypeID,
  platformside.Description              AS measurementValue,
  'https://vocab.ices.dk/services/rdf/collection/PlatformSide/' || platformside.Key AS measurementValueID,
  NULL                                  AS measurementUnit,
  NULL                                  AS measurementUnitID
FROM
  samples AS s
  LEFT JOIN platformside
    ON s.PlatformSide = platformside.Key
WHERE
  s.PlatformSide IS NOT NULL
  AND s.CampaignID IN ({campaign_id*})

UNION

/* SAMPLE: PLATFORM HEIGHT */

SELECT
  s.CampaignID || ':' || s.SampleID     AS eventID,
  NULL                                  AS occurrenceID,
  'platform height'                     AS measurementType,
  NULL                                  AS measurementTypeID, -- TODO
  s.PlatformHeight                      AS measurementValue,
  NULL                                  AS measurementValueID,
  'm'                                   AS measurementUnit,
  'http://vocab.nerc.ac.uk/collection/P06/current/ULAA' AS measurementUnitID
FROM
  samples AS s
WHERE
  s.PlatformHeight IS NOT NULL
  AND s.CampaignID IN ({campaign_id*})

UNION

/* SAMPLE: TRANSECT WIDTH */

SELECT
  s.CampaignID || ':' || s.SampleID     AS eventID,
  NULL                                  AS occurrenceID,
  'transect width'                      AS measurementType,
  NULL                                  AS measurementTypeID, -- TODO
  s.TransectWidth                       AS measurementValue,
  NULL                                  AS measurementValueID,
  'm'                                   AS measurementUnit,
  'http://vocab.nerc.ac.uk/collection/P06/current/ULAA' AS measurementUnitID
FROM
  samples AS s
WHERE
  s.TransectWidth IS NOT NULL
  AND s.CampaignID IN ({campaign_id*})

UNION

/* SAMPLE: SAMPLING METHOD */

SELECT
  s.CampaignID || ':' || s.SampleID     AS eventID,
  NULL                                  AS occurrenceID,
  'sampling method'                     AS measurementType,
  'https://vocab.ices.dk/services/rdf/collection/BD_CountMethod' AS measurementTypeID,
  bdcountmethod.Description             AS measurementValue,
  'https://vocab.ices.dk/services/rdf/collection/BD_CountMethod/' || bdcountmethod.Key AS measurementValueID,
  NULL                                  AS measurementUnit,
  NULL                                  AS measurementUnitID
FROM
  samples AS s
  LEFT JOIN bdcountmethod
    ON s.SamplingMethod = bdcountmethod.Key
WHERE
  s.SamplingMethod IS NOT NULL
  AND s.CampaignID IN ({campaign_id*})

UNION

/* SAMPLE: PRIMARY SAMPLING */

SELECT
  s.CampaignID || ':' || s.SampleID     AS eventID,
  NULL                                  AS occurrenceID,
  'primary sampling'                    AS measurementType,
  NULL                                  AS measurementTypeID, -- TODO
  s.PrimarySampling                     AS measurementValue,
  NULL                                  AS measurementValueID,
  NULL                                  AS measurementUnit,
  NULL                                  AS measurementUnitID
FROM
  samples AS s
WHERE
  s.PrimarySampling IS NOT NULL
  AND s.CampaignID IN ({campaign_id*})

UNION

/* SAMPLE: TARGET TAXA */

SELECT
  s.CampaignID || ':' || s.SampleID     AS eventID,
  NULL                                  AS occurrenceID,
  'target taxa'                         AS measurementType,
  'https://vocab.ices.dk/services/rdf/collection/TargetTaxa' AS measurementTypeID,
  targettaxa.Description                AS measurementValue,
  'https://vocab.ices.dk/services/rdf/collection/TargetTaxa/' || targettaxa.Key AS measurementValueID,
  NULL                                  AS measurementUnit,
  NULL                                  AS measurementUnitID
FROM
  samples AS s
  LEFT JOIN targettaxa
    ON s.TargetTaxa = targettaxa.Key
WHERE
  s.TargetTaxa IS NOT NULL
  AND s.CampaignID IN ({campaign_id*})

UNION

/* SAMPLE: DISTANCE BINS */

SELECT
  s.CampaignID || ':' || s.SampleID     AS eventID,
  NULL                                  AS occurrenceID,
  'distance bins'                       AS measurementType,
  NULL                                  AS measurementTypeID, -- TODO
  s.DistanceBins                        AS measurementValue,
  NULL                                  AS measurementValueID,
  NULL                                  AS measurementUnit,
  NULL                                  AS measurementUnitID
FROM
  samples AS s
WHERE
  s.DistanceBins IS NOT NULL
  AND s.CampaignID IN ({campaign_id*})

UNION

/* SAMPLE: USE OF BINOCULARS */

SELECT
  s.CampaignID || ':' || s.SampleID     AS eventID,
  NULL                                  AS occurrenceID,
  'use of binoculars'                   AS measurementType,
  'https://vocab.ices.dk/services/rdf/collection/UseOfBinoculars' AS measurementTypeID,
  useofbinoculars.Description           AS measurementValue,
  'https://vocab.ices.dk/services/rdf/collection/UseOfBinoculars/' || useofbinoculars.Key AS measurementValueID,
  NULL                                  AS measurementUnit,
  NULL                                  AS measurementUnitID
FROM
  samples AS s
  LEFT JOIN useofbinoculars
    ON s.UseOfBinoculars = useofbinoculars.Key
WHERE
  s.UseOfBinoculars IS NOT NULL
  AND s.CampaignID IN ({campaign_id*})

UNION

/* SAMPLE: NUMBER OF OBSERVERS */

SELECT
  s.CampaignID || ':' || s.SampleID     AS eventID,
  NULL                                  AS occurrenceID,
  'number of observers'                 AS measurementType,
  NULL                                  AS measurementTypeID, -- TODO
  s.NumberOfObservers                   AS measurementValue,
  NULL                                  AS measurementValueID,
  NULL                                  AS measurementUnit,
  NULL                                  AS measurementUnitID
FROM
  samples AS s
WHERE
  s.NumberOfObservers IS NOT NULL
  AND s.CampaignID IN ({campaign_id*})

UNION

/* POSITION: DISTANCE */

SELECT
  s.CampaignID || ':' || s.SampleID || ':' || p.PositionID AS eventID,
  NULL                                  AS occurrenceID,
  'distance'                            AS measurementType,
  NULL                                  AS measurementTypeID, -- TODO
  p.Distance                            AS measurementValue,
  NULL                                  AS measurementValueID,
  'km'                                  AS measurementUnit,
  'http://vocab.nerc.ac.uk/collection/P06/current/ULKM' AS measurementUnitID
FROM
  positions AS p
  LEFT JOIN samples AS s
    ON p.SampleID = s.SampleID
WHERE
  p.Distance IS NOT NULL
  AND s.CampaignID IN ({campaign_id*})

UNION

/* POSITION: AREA */

SELECT
  s.CampaignID || ':' || s.SampleID || ':' || p.PositionID AS eventID,
  NULL                                  AS occurrenceID,
  'area'                                AS measurementType,
  NULL                                  AS measurementTypeID, -- TODO
  p.Area                                AS measurementValue,
  NULL                                  AS measurementValueID,
  'km2'                                 AS measurementUnit,
  'http://vocab.nerc.ac.uk/collection/P06/current/SQKM' AS measurementUnitID
FROM
  positions AS p
  LEFT JOIN samples AS s
    ON p.SampleID = s.SampleID
WHERE
  p.Area IS NOT NULL
  AND s.CampaignID IN ({campaign_id*})

UNION

/* POSITION: WINDFORCE */

SELECT
  s.CampaignID || ':' || s.SampleID || ':' || p.PositionID AS eventID,
  NULL                                  AS occurrenceID,
  'wind force'                          AS measurementType,
  'https://vocab.ices.dk/services/rdf/collection/Beaufort' AS measurementTypeID,
  beaufort.Description                  AS measurementValue,
  'https://vocab.ices.dk/services/rdf/collection/Beaufort/' || beaufort.Key AS measurementValueID,
  NULL                                  AS measurementUnit,
  NULL                                  AS measurementUnitID
FROM
  positions AS p
  LEFT JOIN samples AS s
    ON p.SampleID = s.SampleID
  LEFT JOIN beaufort
    ON p.WindForce = beaufort.Key
WHERE
  p.WindForce IS NOT NULL
  AND s.CampaignID IN ({campaign_id*})

UNION

/* POSITION: VISIBILITY */

SELECT
  s.CampaignID || ':' || s.SampleID || ':' || p.PositionID AS eventID,
  NULL                                  AS occurrenceID,
  'visibility'                          AS measurementType,
  'https://vocab.ices.dk/services/rdf/collection/Visibility' AS measurementTypeID,
  visibility.Description                AS measurementValue,
  'https://vocab.ices.dk/services/rdf/collection/Visibility/' || visibility.Key AS measurementValueID,
  NULL                                  AS measurementUnit,
  NULL                                  AS measurementUnitID
FROM
  positions AS p
  LEFT JOIN samples AS s
    ON p.SampleID = s.SampleID
  LEFT JOIN visibility
    ON p.Visibility = visibility.Key
WHERE
  p.Visibility IS NOT NULL
  AND s.CampaignID IN ({campaign_id*})

UNION

/* POSITION: GLARE */

SELECT
  s.CampaignID || ':' || s.SampleID || ':' || p.PositionID AS eventID,
  NULL                                  AS occurrenceID,
  'glare'                               AS measurementType,
  'https://vocab.ices.dk/services/rdf/collection/Glare' AS measurementTypeID,
  glare.Description                     AS measurementValue,
  'https://vocab.ices.dk/services/rdf/collection/Glare/' || glare.Key AS measurementValueID,
  NULL                                  AS measurementUnit,
  NULL                                  AS measurementUnitID
FROM
  positions AS p
  LEFT JOIN samples AS s
    ON p.SampleID = s.SampleID
  LEFT JOIN glare
    ON p.Glare = glare.Key
WHERE
  p.Glare IS NOT NULL
  AND s.CampaignID IN ({campaign_id*})

UNION

/* POSITION: SUN ANGLE */

SELECT
  s.CampaignID || ':' || s.SampleID || ':' || p.PositionID AS eventID,
  NULL                                  AS occurrenceID,
  'sun angle'                           AS measurementType,
  NULL                                  AS measurementTypeID, -- TODO
  p.SunAngle                            AS measurementValue,
  NULL                                  AS measurementValueID,
  'degrees'                             AS measurementUnit,
  'http://vocab.nerc.ac.uk/collection/P06/current/UAAA' AS measurementUnitID
FROM
  positions AS p
  LEFT JOIN samples AS s
    ON p.SampleID = s.SampleID
WHERE
  p.SunAngle IS NOT NULL
  AND s.CampaignID IN ({campaign_id*})

UNION

/* POSITION: CLOUD COVER */

SELECT
  s.CampaignID || ':' || s.SampleID || ':' || p.PositionID AS eventID,
  NULL                                  AS occurrenceID,
  'cloud cover'                         AS measurementType,
  'https://vocab.ices.dk/services/rdf/collection/CloudCover' AS measurementTypeID,
  cloudcover.Description                AS measurementValue,
  'https://vocab.ices.dk/services/rdf/collection/CloudCover/' || cloudcover.Key AS measurementValueID,
  'octas'                               AS measurementUnit,
  NULL                                  AS measurementUnitID -- TODO
FROM
  positions AS p
  LEFT JOIN samples AS s
    ON p.SampleID = s.SampleID
  LEFT JOIN cloudcover
    ON p.CloudCover = cloudcover.Key
WHERE
  p.CloudCover IS NOT NULL
  AND s.CampaignID IN ({campaign_id*})

UNION

/* POSITION: PRECIPITATION */

SELECT
  s.CampaignID || ':' || s.SampleID || ':' || p.PositionID AS eventID,
  NULL                                  AS occurrenceID,
  'precipitation'                       AS measurementType,
  'https://vocab.ices.dk/services/rdf/collection/Precipitation' AS measurementTypeID,
  precipitation.Description             AS measurementValue,
  'https://vocab.ices.dk/services/rdf/collection/Precipitation/' || precipitation.Key AS measurementValueID,
  NULL                                  AS measurementUnit,
  NULL                                  AS measurementUnitID
FROM
  positions AS p
  LEFT JOIN samples AS s
    ON p.SampleID = s.SampleID
  LEFT JOIN precipitation
    ON p.Precipitation = precipitation.Key
WHERE
  p.Precipitation IS NOT NULL
  AND s.CampaignID IN ({campaign_id*})

UNION

/* POSITION: ICE COVER */

SELECT
  s.CampaignID || ':' || s.SampleID || ':' || p.PositionID AS eventID,
  NULL                                  AS occurrenceID,
  'ice cover'                           AS measurementType,
  NULL                                  AS measurementTypeID, -- TODO
  p.IceCover                            AS measurementValue,
  NULL                                  AS measurementValueID,
  'percent'                             AS measurementUnit,
  'http://vocab.nerc.ac.uk/collection/P06/current/UPCT' AS measurementUnitID
FROM
  positions AS p
  LEFT JOIN samples AS s
    ON p.SampleID = s.SampleID
WHERE
  p.IceCover IS NOT NULL
  AND s.CampaignID IN ({campaign_id*})

UNION

/* POSITION: OBSERVATION CONDITIONS */

SELECT
  s.CampaignID || ':' || s.SampleID || ':' || p.PositionID AS eventID,
  NULL                                  AS occurrenceID,
  'observation conditions'              AS measurementType,
  'https://vocab.ices.dk/services/rdf/collection/Sightability' AS measurementTypeID,
  sightability.Description              AS measurementValue,
  'https://vocab.ices.dk/services/rdf/collection/Sightability/' || sightability.Key AS measurementValueID,
  NULL                                  AS measurementUnit,
  NULL                                  AS measurementUnitID
FROM
  positions AS p
  LEFT JOIN samples AS s
    ON p.SampleID = s.SampleID
  LEFT JOIN sightability
    ON p.ObservationConditions = sightability.Key
WHERE
  p.ObservationConditions IS NOT NULL
  AND s.CampaignID IN ({campaign_id*})

UNION

/* OBSERVATION: GROUP IDENTIFIER */

SELECT
  s.CampaignID || ':' || s.SampleID || ':' || p.PositionID AS eventID,
  s.CampaignID || ':' || s.SampleID || ':' || p.PositionID || ':' || o.ObservationID AS occurrenceID,
  'group identifier'                    AS measurementType,
  NULL                                  AS measurementTypeID, -- TODO
  o.GroupID                             AS measurementValue,
  NULL                                  AS measurementValueID,
  NULL                                  AS measurementUnit,
  NULL                                  AS measurementUnitID
FROM
  observations AS o
  LEFT JOIN positions AS p
    ON o.PositionID = p.PositionID
  LEFT JOIN samples AS s
    ON p.SampleID = s.SampleID
WHERE
  o.GroupID IS NOT NULL
  AND s.CampaignID IN ({campaign_id*})

UNION

/* OBSERVATION: TRANSECT */

SELECT
  s.CampaignID || ':' || s.SampleID || ':' || p.PositionID AS eventID,
  s.CampaignID || ':' || s.SampleID || ':' || p.PositionID || ':' || o.ObservationID AS occurrenceID,
  'in transect'                         AS measurementType,
  NULL                                  AS measurementTypeID, -- TODO
  o.Transect                            AS measurementValue,
  NULL                                  AS measurementValueID,
  NULL                                  AS measurementUnit,
  NULL                                  AS measurementUnitID
FROM
  observations AS o
  LEFT JOIN positions AS p
    ON o.PositionID = p.PositionID
  LEFT JOIN samples AS s
    ON p.SampleID = s.SampleID
WHERE
  o.Transect IS NOT NULL
  AND s.CampaignID IN ({campaign_id*})

UNION

/* OBSERVATION: INDIVIDUAL COUNT */

SELECT
  s.CampaignID || ':' || s.SampleID || ':' || p.PositionID AS eventID,
  s.CampaignID || ':' || s.SampleID || ':' || p.PositionID || ':' || o.ObservationID AS occurrenceID,
  'individual count'                    AS measurementType,
  NULL                                  AS measurementTypeID, -- TODO
  o.Count                               AS measurementValue,
  NULL                                  AS measurementValueID,
  NULL                                  AS measurementUnit,
  NULL                                  AS measurementUnitID
FROM
  observations AS o
  LEFT JOIN positions AS p
    ON o.PositionID = p.PositionID
  LEFT JOIN samples AS s
    ON p.SampleID = s.SampleID
WHERE
  o.Count IS NOT NULL
  AND s.CampaignID IN ({campaign_id*})

UNION

/* OBSERVATION: OBSERVATION DISTANCE */

SELECT
  s.CampaignID || ':' || s.SampleID || ':' || p.PositionID AS eventID,
  s.CampaignID || ':' || s.SampleID || ':' || p.PositionID || ':' || o.ObservationID AS occurrenceID,
  'observation distance'                AS measurementType,
  'https://vocab.ices.dk/services/rdf/collection/ObservationDistance' AS measurementTypeID,
  observationdistance.Description       AS measurementValue,
  'https://vocab.ices.dk/services/rdf/collection/ObservationDistance/' || observationdistance.Key AS measurementValueID,
  NULL                                  AS measurementUnit,
  NULL                                  AS measurementUnitID
FROM
  observations AS o
  LEFT JOIN positions AS p
    ON o.PositionID = p.PositionID
  LEFT JOIN samples AS s
    ON p.SampleID = s.SampleID
  LEFT JOIN observationdistance
    ON o.ObservationDistance = observationdistance.Key
WHERE
  o.ObservationDistance IS NOT NULL
  AND s.CampaignID IN ({campaign_id*})

UNION

/* OBSERVATION: LIFE STAGE */

SELECT
  s.CampaignID || ':' || s.SampleID || ':' || p.PositionID AS eventID,
  s.CampaignID || ':' || s.SampleID || ':' || p.PositionID || ':' || o.ObservationID AS occurrenceID,
  'life stage'                          AS measurementType,
  'https://vocab.ices.dk/services/rdf/collection/LifeStage' AS measurementTypeID,
  lifestage.Description                 AS measurementValue,
  'https://vocab.ices.dk/services/rdf/collection/LifeStage/' || lifestage.Key AS measurementValueID,
  NULL                                  AS measurementUnit,
  NULL                                  AS measurementUnitID
FROM
  observations AS o
  LEFT JOIN positions AS p
    ON o.PositionID = p.PositionID
  LEFT JOIN samples AS s
    ON p.SampleID = s.SampleID
  LEFT JOIN lifestage
    ON o.LifeStage = lifestage.Key
WHERE
  o.LifeStage IS NOT NULL
  AND s.CampaignID IN ({campaign_id*})

UNION

/* OBSERVATION: MOULT */

SELECT
  s.CampaignID || ':' || s.SampleID || ':' || p.PositionID AS eventID,
  s.CampaignID || ':' || s.SampleID || ':' || p.PositionID || ':' || o.ObservationID AS occurrenceID,
  'moult'                               AS measurementType,
  'https://vocab.ices.dk/services/rdf/collection/Moult' AS measurementTypeID,
  moult.Description                     AS measurementValue,
  'https://vocab.ices.dk/services/rdf/collection/Moult/' || moult.Key AS measurementValueID,
  NULL                                  AS measurementUnit,
  NULL                                  AS measurementUnitID
FROM
  observations AS o
  LEFT JOIN positions AS p
    ON o.PositionID = p.PositionID
  LEFT JOIN samples AS s
    ON p.SampleID = s.SampleID
  LEFT JOIN moult
    ON o.Moult = moult.Key
WHERE
  o.Moult IS NOT NULL
  AND s.CampaignID IN ({campaign_id*})

UNION

/* OBSERVATION: PLUMAGE */

SELECT
  s.CampaignID || ':' || s.SampleID || ':' || p.PositionID AS eventID,
  s.CampaignID || ':' || s.SampleID || ':' || p.PositionID || ':' || o.ObservationID AS occurrenceID,
  'plumage'                             AS measurementType,
  'https://vocab.ices.dk/services/rdf/collection/Plumage' AS measurementTypeID,
  plumage.Description                   AS measurementValue,
  'https://vocab.ices.dk/services/rdf/collection/Plumage/' || plumage.Key AS measurementValueID,
  NULL                                  AS measurementUnit,
  NULL                                  AS measurementUnitID
FROM
  observations AS o
  LEFT JOIN positions AS p
    ON o.PositionID = p.PositionID
  LEFT JOIN samples AS s
    ON p.SampleID = s.SampleID
  LEFT JOIN plumage
    ON o.Plumage = plumage.Key
WHERE
  o.Plumage IS NOT NULL
  AND s.CampaignID IN ({campaign_id*})

UNION

/* OBSERVATION: SEX */

SELECT
  s.CampaignID || ':' || s.SampleID || ':' || p.PositionID AS eventID,
  s.CampaignID || ':' || s.SampleID || ':' || p.PositionID || ':' || o.ObservationID AS occurrenceID,
  'sex'                                 AS measurementType,
  'https://vocab.ices.dk/services/rdf/collection/SEXCO' AS measurementTypeID,
  sex.Description                       AS measurementValue,
  'https://vocab.ices.dk/services/rdf/collection/SEXCO/' || sex.Key AS measurementValueID,
  NULL                                  AS measurementUnit,
  NULL                                  AS measurementUnitID
FROM
  observations AS o
  LEFT JOIN positions AS p
    ON o.PositionID = p.PositionID
  LEFT JOIN samples AS s
    ON p.SampleID = s.SampleID
  LEFT JOIN sex
    ON o.Sex = sex.Key
WHERE
  o.Sex IS NOT NULL
  AND s.CampaignID IN ({campaign_id*})

UNION

/* OBSERVATION: TRAVEL DIRECTION */

SELECT
  s.CampaignID || ':' || s.SampleID || ':' || p.PositionID AS eventID,
  s.CampaignID || ':' || s.SampleID || ':' || p.PositionID || ':' || o.ObservationID AS occurrenceID,
  'travel direction'                    AS measurementType,
  'https://vocab.ices.dk/services/rdf/collection/TravelDirection' AS measurementTypeID,
  traveldirection.Description           AS measurementValue,
  'https://vocab.ices.dk/services/rdf/collection/TravelDirection/' || traveldirection.Key AS measurementValueID,
  NULL                                  AS measurementUnit,
  NULL                                  AS measurementUnitID
FROM
  observations AS o
  LEFT JOIN positions AS p
    ON o.PositionID = p.PositionID
  LEFT JOIN samples AS s
    ON p.SampleID = s.SampleID
  LEFT JOIN traveldirection
    ON o.TravelDirection = traveldirection.Key
WHERE
  o.TravelDirection IS NOT NULL
  AND s.CampaignID IN ({campaign_id*})

UNION

/* OBSERVATION: PREY */

SELECT
  s.CampaignID || ':' || s.SampleID || ':' || p.PositionID AS eventID,
  s.CampaignID || ':' || s.SampleID || ':' || p.PositionID || ':' || o.ObservationID AS occurrenceID,
  'prey'                                AS measurementType,
  'https://vocab.ices.dk/services/rdf/collection/PreyType' AS measurementTypeID,
  preytype.Description                  AS measurementValue,
  'https://vocab.ices.dk/services/rdf/collection/PreyType/' || preytype.Key AS measurementValueID,
  NULL                                  AS measurementUnit,
  NULL                                  AS measurementUnitID
FROM
  observations AS o
  LEFT JOIN positions AS p
    ON o.PositionID = p.PositionID
  LEFT JOIN samples AS s
    ON p.SampleID = s.SampleID
  LEFT JOIN preytype
    ON o.Prey = preytype.Key
WHERE
  o.Prey IS NOT NULL
  AND s.CampaignID IN ({campaign_id*})

UNION

/* OBSERVATION: ASSOCIATION */

SELECT
  s.CampaignID || ':' || s.SampleID || ':' || p.PositionID AS eventID,
  s.CampaignID || ':' || s.SampleID || ':' || p.PositionID || ':' || o.ObservationID AS occurrenceID,
  'association'                         AS measurementType,
  'https://vocab.ices.dk/services/rdf/collection/Association' AS measurementTypeID,
  association.Description               AS measurementValue,
  'https://vocab.ices.dk/services/rdf/collection/Association/' || association.Key AS measurementValueID,
  NULL                                  AS measurementUnit,
  NULL                                  AS measurementUnitID
FROM
  observations AS o
  LEFT JOIN positions AS p
    ON o.PositionID = p.PositionID
  LEFT JOIN samples AS s
    ON p.SampleID = s.SampleID
  LEFT JOIN association
    ON o.Association = association.Key
WHERE
  o.Association IS NOT NULL
  AND s.CampaignID IN ({campaign_id*})

UNION

/* OBSERVATION: BEHAVIOUR */

SELECT
  s.CampaignID || ':' || s.SampleID || ':' || p.PositionID AS eventID,
  s.CampaignID || ':' || s.SampleID || ':' || p.PositionID || ':' || o.ObservationID AS occurrenceID,
  'behaviour'                           AS measurementType,
  'https://vocab.ices.dk/services/rdf/collection/Behaviour' AS measurementTypeID,
  behaviour.Description                 AS measurementValue,
  'https://vocab.ices.dk/services/rdf/collection/Behaviour/' || behaviour.Key AS measurementValueID,
  NULL                                  AS measurementUnit,
  NULL                                  AS measurementUnitID
FROM
  observations AS o
  LEFT JOIN positions AS p
    ON o.PositionID = p.PositionID
  LEFT JOIN samples AS s
    ON p.SampleID = s.SampleID
  LEFT JOIN behaviour
    ON o.Behaviour = behaviour.Key
WHERE
  o.Behaviour IS NOT NULL
  AND s.CampaignID IN ({campaign_id*})
