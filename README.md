# ESAS2OBIS

[![funding](https://img.shields.io/static/v1?label=funded+by&message=EMODnet+Biology&labelColor=1872b1&color=f6b142)](https://www.emodnet-biology.eu/)

## Rationale

This repository contains the functionality to standardize the data of the [European Seabirds at Sea](http://esas.ices.dk/) to a [Darwin Core Archive](https://obis.org/manual/dataformat/#dwca) that can be harvested by [OBIS](http://www.obis.org).

## Workflow

[ESAS web services](https://esas.ices.dk/webservices) → Darwin Core [mapping script](src/dwc_mapping.Rmd) using [SQL](SQL) → generated [Darwin Core files](data/processed)

## Published dataset

* [Dataset on the IPT](#) - TBD
* [Dataset on OBIS](#) - TBD

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

## Installation

1. Clone this repository to your computer
2. Open the RStudio project file
3. Open the `dwc_mapping.Rmd` [R Markdown file](https://rmarkdown.rstudio.com/) in RStudio
4. Install any required packages
5. Click `Run > Run All` to generate the processed data

## License

[MIT License](LICENSE) for the code and documentation in this repository. The included data is released under another license.
