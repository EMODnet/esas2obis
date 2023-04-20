# ESAS2OBIS

[![funding](https://img.shields.io/static/v1?label=funded+by&message=EMODnet+Biology&labelColor=1872b1&color=f6b142)](https://www.emodnet-biology.eu/)

## Rationale

This repository contains the functionality to standardize the data of the [European Seabirds at Sea (ESAS)](http://esas.ices.dk/) to a [Darwin Core Archive](https://obis.org/manual/dataformat/#dwca) that can be harvested by [OBIS](http://www.obis.org) and [GBIF](https://www.gbif.org/).

## Workflow

To republish the data:

1. Clone this repository to your computer.
2. Download all public ESAS data from [ICES](https://esas.ices.dk/inventory).
3. Place the downloaded data in `data/raw`. The directory is ignored by git, so you will have to create it.
4. Open the repository in RStudio by opening the `esas2obis.Rproj` file.
5. Open the Darwin Core mapping script [`dwc_mapping.Rmd`](src/dwc_mapping.Rmd).
6. Click `Run > Run All` to transform the data to [Darwin Core files](data/processed) using [SQL](SQL). This will take a while.
7. Verify that all steps in the the mapping script ran without errors.
8. Verify in git or GitHub Desktop that the [sample data](data/processed_sample) are not affected (changes would indicate updates or issues in the mapping).
9. Upload the Darwin Core files to the [VLIZ "upload" IPT](https://ipt.vliz.be/upload/resource?r=esas).
10. Validate the Darwin Core Archive (by EurOBIS staff).
11. Publish the dataset to OBIS and GBIF (by EurOBIS staff).

## Published dataset

- [Dataset on the VLIZ "upload" IPT](https://ipt.vliz.be/upload/resource?r=esas)
- [Dataset on OBIS](#) - TBD
- [Dataset on GBIF](#) - TBD

## Darwin Core transformation

ESAS data is structured in [4 hierarchical tables](https://esas-docs.ices.dk/tables/): campaigns, samples, positions and observations.

### Event core

The Event core contains three types of events:

- [Campaigns](https://esas-docs.ices.dk/tables/#campaign) (`type=cruise`) with an `eventID`, date range, and remarks.
- [Samples](https://esas-docs.ices.dk/tables/#sample) (`type=sample`) with an `eventID`, `parentEventID` (the campaign), single date and remarks.
- [Positions](https://esas-docs.ices.dk/tables/#position) (`type=subSample`) with an `eventID`, `parentEventID` (the sample), datetime and location.

The `eventID`s are created by concatenating the parent identifiers, e.g. `<campaignID>_<sampleID>_<positionID>` for a position. This makes them unique within the dataset and easy to understand.

Record-level terms such as `institutionCode`, `datasetName`, `license` and `rightsHolder` are included as well.

See the [SQL file](sql/dwc_event.sql) for the full transformation.

### Occurrence extension

The Occurrence extension contains the [observations](https://esas-docs.ices.dk/tables/#observation), with the following terms:

- `eventID` (the position) and `occurrenceID`.
- `basisOfRecord` (always `HumanObservation`) and `occurrenceStatus` (always `present`).
- `scientificName`, `scientificNameID` (WoRMS identifier), `kingdom` (always `Animalia`) and `vernacularName`.
- `individualCount`, `sex`, `lifeStage`, `behavior`, `associatedTaxa` (also expressed as measurements or facts).
- `occurrenceRemarks`.

The `occurrenceID`s are created similarly to the `eventID`s, as `<campaignID>_<sampleID>_<positionID>_<observationID>`.

See the [SQL file](sql/dwc_occurrence.sql) for the full transformation.

### Extended Measurement Or Fact extension (EMOF)

The EMOF extension contains all other ESAS data, with the following terms:

- `eventID`: identifier of sample or position (there are no campaign measurements).
- `occurrenceID` (where applicable): identifier of the occurrence.
- `measurementType`: lowercase description of the measurement.
- `measurementTypeID` (where applicable): link to a definition of the measurement. Where possible, we use the [BODC Parameter Usage Vocabulary (P01)](http://vocab.nerc.ac.uk/collection/P01/current/) or fall back to ESAS vocabularies maintained by ICES (e.g. <https://vocab.ices.dk/services/rdf/collection/UseOfBinoculars>).
- `measurementValue`: human readable value or description, lowercased where appropriate.
- `measurementValueID` (where applicable): IRI for the value. These mostly link to values in ESAS vocabularies maintained by ICES (e.g. <https://vocab.ices.dk/services/rdf/collection/UseOfBinoculars/2>), except for platform code ([C17](http://vocab.nerc.ac.uk/collection/C17/current/)), sex ([S10](http://vocab.nerc.ac.uk/collection/S10/)) and life stage ([S11](http://vocab.nerc.ac.uk/collection/S11/current/)).
- `measurementUnit` (where applicable): unit of the measurement.
- `measurementUnitID`: link to a definition of the unit, with [XXXX](http://vocab.nerc.ac.uk/collection/P06/current/XXXX/) for not applicable and [UUUU](http://vocab.nerc.ac.uk/collection/P06/current/UUUU/) for dimensionless (e.g. `individualCount`).

The ESAS terms `behaviour` and `association` can contain multiple values for a single observation and are split into maximum 3 measurements or facts records.

See Table 1 for an overview and the [SQL file](sql/dwc_emof.sql) for the full transformation.

### Table 1: ESAS terms that are expressed as measurement or fact

table | measurement or fact | type | example
--- | --- | --- | ---
sample | [platform code](https://esas-docs.ices.dk/tables/#sample.PlatformCode) | vocab | `BELGICA`
sample | [platform class](https://esas-docs.ices.dk/tables/#sample.PlatformClass) | vocab | `ship`
sample | [platform side](https://esas-docs.ices.dk/tables/#sample.PlatformSide) | vocab | `left`
sample | [platform height](https://esas-docs.ices.dk/tables/#sample.PlatformHeight) | number | 
sample | [transect width](https://esas-docs.ices.dk/tables/#sample.TransectWidth) | integer | `300`
sample | [sampling method](https://esas-docs.ices.dk/tables/#sample.SamplingMethod) | vocab | `ship-based transect method with distance estimation and snapshot for flying birds`
sample | [primary sampling](https://esas-docs.ices.dk/tables/#sample.PrimarySampling) | boolean | `True`
sample | [target taxa](https://esas-docs.ices.dk/tables/#sample.TargetTaxa) | vocab | `all species recorded (standard)`
sample | [distance bins](https://esas-docs.ices.dk/tables/#sample.DistanceBins) | string | `0\|50\|100\|200\|300` 
sample | [use of binoculars](https://esas-docs.ices.dk/tables/#sample.UseOfBinoculars) | vocab | `Binoculars used extensively for scanning ahead and to the side, naked eye used for close observations (e.g. for cetacean monitoring)`
sample | [number of observers](https://esas-docs.ices.dk/tables/#sample.NumberOfObservers) | integer | `2`
position | [distance](https://esas-docs.ices.dk/tables/#position.Distance) | number | `0.7`
position | [area](https://esas-docs.ices.dk/tables/#position.Area) | number | `0.21`
position | [wind force](https://esas-docs.ices.dk/tables/#position.WindForce) | vocab | `moderate breeze`
position | [visibility](https://esas-docs.ices.dk/tables/#position.Visibility) | vocab | `C`
position | [glare](https://esas-docs.ices.dk/tables/#position.Glare) | vocab | `weak`
position | [sun angle](https://esas-docs.ices.dk/tables/#position.SunAngle) | integer | 
position | [cloud cover](https://esas-docs.ices.dk/tables/#position.CloudCover) | vocab | 
position | [precipitation](https://esas-docs.ices.dk/tables/#position.Precipitation) | vocab | `none`
position | [ice cover](https://esas-docs.ices.dk/tables/#position.IceCover) | integer | `0`
position | [observation conditions](https://esas-docs.ices.dk/tables/#position.ObservationConditions) | vocab | 
observation | [group identifier](https://esas-docs.ices.dk/tables/#observation.GroupID) | string | `12`
observation | [in transect](https://esas-docs.ices.dk/tables/#observation.Transect) | boolean | `True`
observation | [individual count](https://esas-docs.ices.dk/tables/#observation.Count) | integer | `1`
observation | [observation distance](https://esas-docs.ices.dk/tables/#observation.ObservationDistance) | vocab | `100-200`
observation | [life stage](https://esas-docs.ices.dk/tables/#observation.LifeStage) | vocab | `adult`
observation | [moult](https://esas-docs.ices.dk/tables/#observation.Moult) | vocab | `active primary moult`
observation | [plumage](https://esas-docs.ices.dk/tables/#observation.Plumage) | vocab | `non-breeding (winter) plumage`
observation | [sex](https://esas-docs.ices.dk/tables/#observation.Sex) | vocab | `female`
observation | [travel direction](https://esas-docs.ices.dk/tables/#observation.TravelDirection) | vocab | `45`
observation | [prey](https://esas-docs.ices.dk/tables/#observation.Prey) | vocab | `medium fish, unidentified (ca. 2-5x bill length)`
observation | [association](https://esas-docs.ices.dk/tables/#observation.Association) x 3 | vocab | `associated with observation base`
observation | [behaviour](https://esas-docs.ices.dk/tables/#observation.Behaviour) x 3 | vocab | `scavenging`

## Repo structure

The repository structure is based on [Cookiecutter Data Science](http://drivendata.github.io/cookiecutter-data-science/) and the [Checklist recipe](https://github.com/trias-project/checklist-recipe). Files and directories indicated with `GENERATED` should not be edited manually.

```
├── README.md              : Description of this repository
├── LICENSE                : Repository license
├── esas2obis.Rproj        : RStudio project file
├── .gitignore             : Files and directories to be ignored by git
│
├── src
│   └── dwc_mapping.Rmd    : Darwin Core mapping script
|
├── sql                    : Darwin Core transformations
│   ├── dwc_event.sql
│   ├── dwc_occurrence.sql
│   └── dwc_mof.sql
|
└── data
    ├── processed          : Darwin Core output of mapping script GENERATED
    └── processed_sample   : Darwin Core sample output of mapping script for git comparison GENERATED
```

## License

[MIT License](LICENSE) for the code and documentation in this repository. The included data is released under another license.
