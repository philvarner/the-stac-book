# The STAC Book

The STAC Book: A Guide for Using STAC and STAC API in Geospatial Software Systems

- [The STAC Book](#the-stac-book)
  - [Chapter 1: Introduction](#chapter-1-introduction)
  - [Chapter 2: STAC Specification](#chapter-2-stac-specification)
  - [Chapter 3: STAC API](#chapter-3-stac-api)
  - [Chapter 4: STAC Client Tooling](#chapter-4-stac-client-tooling)
    - [STAC API Client Tooling](#stac-api-client-tooling)
  - [Chapter 5: STAC Generation Tooling](#chapter-5-stac-generation-tooling)
    - [Creating STAC Items - Use Cases and Examples](#creating-stac-items---use-cases-and-examples)
  - [Chapter 6: STAC API Tooling](#chapter-6-stac-api-tooling)
  - [Chapter 7: Implementing a STAC API](#chapter-7-implementing-a-stac-api)
    - [Comparison](#comparison)
      - [Possible implementation](#possible-implementation)
      - [Suites](#suites)
    - [Database support](#database-support)
  - [Chapter 8 Advanced Topics in STAC API](#chapter-8-advanced-topics-in-stac-api)
  - [Chapter 9: UI](#chapter-9-ui)
  - [Chapter 10: Integrating STAC with other geospatial tools](#chapter-10-integrating-stac-with-other-geospatial-tools)
  - [Chapter X: Future developments and roadmap](#chapter-x-future-developments-and-roadmap)


## Chapter 1: Introduction

- Overview of STAC and its purpose
- Key components of STAC
- Introduction to STAC API
- Benefits of using STAC and STAC API

Earth Search and Planetary Computer

## Chapter 2: STAC Specification

- STAC Item
- STAC Catalog
- STAC Collection
- STAC Extensions
- STAC Best Practices

## Chapter 3: STAC API

- Foundational Spec
- Extensions

## Chapter 4: STAC Client Tooling

### STAC API Client Tooling

- Querying STAC API
- Filtering and searching STAC Items
- Pagination and sorting


## Chapter 5: STAC Generation Tooling

### Creating STAC Items - Use Cases and Examples

- Real-world use cases of STAC and STAC API
- Example applications and projects using STAC
- Tutorials and step-by-step guides
- Common challenges and solutions

## Chapter 6: STAC API Tooling

## Chapter 7: Implementing a STAC API

- Setting up a STAC API server

Choosing.

Open Source tradeoff -- Maintained vs. forking the code gives a good starting point.

Python

- stac-fastapi - modular backend
  - [stac-fastapi-pgstac](https://github.com/stac-utils/stac-fastapi-pgstac): [PostgreSQL](https://github.com/postgres/postgres) + [PostGIS](https://github.com/postgis/postgis) via [PgSTAC](https://github.com/stac-utils/pgstac).
  - [stac-fastapi-elasticsearch-opensearch](https://github.com/stac-utils/stac-fastapi-elasticsearch-opensearch): [Elasticsearch](https://github.com/elastic/elasticsearch) or [OpenSearch](https://github.com/opensearch-project/OpenSearch)
- stac-server - JavaScript , OpenSearch, intended to be run as a lambda
- resto - PHP, PostgreSQL + PostGIS

stac-fastapi-os-es and stac-server use the same format for the storage, so can be interchanged

Other implementations include:

- stac-fastapi
  - [stac-fastapi-mongo](https://github.com/Healy-Hyperspatial/stac-fastapi-mongo): [MongoDB](https://github.com/mongodb/mongo)
  - [stac-fastapi-geoparquet)](https://github.com/stac-utils/stac-fastapi-geoparquet): [GeoParquet](https://geoparquet.org) via [stacrs](https://github.com/stac-utils/stacrs) (experimental)
  - [stac-fastapi-duckdb](https://github.com/Healy-Hyperspatial/stac-fastapi-duckdb): [DuckDB](https://github.com/duckdb/duckdb) (experimental)

Abandoned

- Franklin - Scala - PostgreSQL
- staccato - Java
- dotnetstac
- [stac-fastapi-sqlalchemy](https://github.com/stac-utils/stac-fastapi-sqlalchemy): [PostgreSQL](https://github.com/postgres/postgres) + [PostGIS](https://github.com/postgis/postgis) via [SQLAlchemy](https://www.sqlalchemy.org/) (abandoned in favor of stac-fastapi-pgstac)


### Comparison

| Feature                                | stac-fastapi-pgstac | stac-fastapi-es-os | stac-server  | resto |
| -------------------------------------- | ------------------- | ------------------ | ------------ | ----- |
| Core                                   | ✓                   | ✓                  | ✓            | ✓     |
| Item Search GET                        | ✓                   | ✓                  | ✓            | ✓     |
| Item Search POST                       | ✓                   | ✓                  | ✓            |       |
| Features                               | ✓                   | ✓                  | ✓            | ✓     |
| Collections                            | ✓                   | ✓                  | ✓            | ✓     |
| Features - Filter                      | ✓                   | ✓                  | ✓            | ✓     |
| Item Search - Filter                   | ✓                   | ✓                  | ✓            | ✓     |
| Filter - CQL2-Text                     | ✓                   | ✓                  |              | ✓     |
| Filter - CQL2-JSON                     | ✓                   | ✓                  | ✓            |       |
| Filter - Basic CQL2                    | ✓                   | ✓                  | ✓            | ✓     |
| Filter - Advanced Comparison           | ✓                   | ✓                  | partial [^2] | ✓     |
| Filter - Basic Spatial Functions       |                     |                    | ✓            | ✓     |
| Filter - Basic Spatial Plus Functions  |                     |                    | ✓            | ✓     |
| Filter - Spatial Functions             |                     |                    |              |       |
| Filter - Temporal Functions            |                     |                    |              | ✓     |
| Filter - Array Functions               |                     |                    |              |       |
| Filter - Property-Property Comparisons |                     |                    |              |       |
| Filter - Functions                     |                     |                    |              |       |
| Filter - Arithmetic Expressions        |                     |                    |              |       |
| Filter - Case-insensitive Comparison   |                     |                    |              |       |
| Filter - Accent-insensitive Comparison |                     |                    |              |       |
| Sort                                   | ✓                   | ✓                  | ✓            | ✓     |
| Fields                                 | ✓                   | ✓                  | ✓            | ✓     |
| Query                                  | ✓                   | ✓                  | ✓            |       |
| Transaction                            | ✓                   | ✓                  | ✓ [^1]       |       |
| Collection Transaction                 |                     |                    |              |       |
| Collection Search                      | ✓                   |                    |              |       |
| Language (I18N)                        |                     |                    |              |       |
| Aggregations                           |                     |                    | ✓ [^3]       |       |
| Browseable                             |                     |                    |              | ✓     |
| Children                               |                     |                    |              | ✓     |
| Free-Text Search                       | ✓                   |                    |              |       |

- resto only supports GET /search endpoint

[^1]: stac-server does not support create with ItemCollection
[^2]: stac-server supports IN and BETWEEN, but not LIKE
[^3]: stac-server supports only GET aggregation endpoints


#### Possible implementation

stac-fastapi-pgstac and stac-fastapi-os-es can implement Aggregations. 

pgstac h3-pg extension for hex indexing.

Or, pre-calculate the 16 levels of H3 for the centroid of a scene.

#### Suites

- [eoAPI](https://github.com/developmentseed/eoAPI) combines stac-fastapi-pgstac, TiTiler, TiPg. mosaicking.
- FilmDrop - stac-server + titler-mosaicjson

### Database support

- PostgreSQL + PostGIS - R-tree , h3-pg
- Opensearch & Elasticsearch Block K-Dimensional (BKD) trees
- MongoDB - modified B-tree
- DuckDB - R-tree
- CouchDB + GeoCouch - R-tree
- HBase + GeoMesa
- Azure CosmosDB
- RavenDB
- AWS DocumentDB
- AWS Redshift
- Oracle Database  


Aggregations - H3 Hexagonal indexing 0-15 levels  



## Chapter 8 Advanced Topics in STAC API

- Performance optimization
- Security considerations

## Chapter 9: UI

stac-browser
FilmDrop UI

## Chapter 10: Integrating STAC with other geospatial tools

- TBD

## Chapter X: Future developments and roadmap

- TBD
