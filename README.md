# The STAC Book

The STAC Book: A Guide for Using STAC and STAC API in Geospatial Software Systems

- [The STAC Book](#the-stac-book)
  - [Chapter 1: Introduction](#chapter-1-introduction)
    - [Open Catalogs](#open-catalogs)
  - [Chapter 2: STAC Specification](#chapter-2-stac-specification)
    - [Design Flaws](#design-flaws)
      - [Coupling STAC to JSON](#coupling-stac-to-json)
      - [Foreign Members](#foreign-members)
      - [Assets](#assets)
  - [Chapter 3: STAC API](#chapter-3-stac-api)
  - [Chapter 4: STAC Client Tooling](#chapter-4-stac-client-tooling)
    - [STAC and STAC API Client Libraries](#stac-and-stac-api-client-libraries)
      - [Python](#python)
      - [JavaScript / TypeScript](#javascript--typescript)
      - [Rust](#rust)
      - [R](#r)
      - [Julia](#julia)
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

<https://stacspec.org>

- Ontology: object types, vocabulary, and relationships
- Taxonomy: Catalog and Collections for organizing a hierarchical relationship between related items
  - related by homogeneous or owner
- Choreography - STAC API

- Overview of STAC and its purpose
- Key components of STAC
- Introduction to STAC API
- Benefits of using STAC and STAC API

### Open Catalogs

Earth Search and Planetary Computer

## Chapter 2: STAC Specification

- STAC Item
- STAC Catalog
- STAC Collection
- STAC Extensions
- STAC Best Practices

### Design Flaws

#### Coupling STAC to JSON

STAC (no qualifier) should only be an ontology and taxonomy without being coupled to a serialization format (JSON).
There should be a separate thing "STAC JSON" like there is for "CQL2 JSON" and "CQL2 Text", and then others like
"STAC GeoParquet" or "STAC Postgres Schema".  

#### Foreign Members

GeoJSON Feature has type, id (optional), geometry (nullable), bbox (optional), and properties.
Item is a Feature with "foreign members", adding stac_version, stac_extensions, collection, links, and assets.
making the other Feature fields required or conditionally optional (e.g., geometry or bbox). This could
have just as easily put these fields in the properties. It's unclear what foreign members are even for, since
everythign could just go in properties.

Key part here is that the ontology can be the same with a different taxonomy.

#### Assets

The `assets` field is an object instead of an array. Groups of the same type of things (Asset) should
be lists of them rather than maps. The name should be in the Asset object. This was a mistake of making
the serialized format the same as the intended usage pattern, e.g., get the asset named `visual_rgb`. In
practice, the serialized for generally doesn't matter, as most users with either use a formal API (e.g., pystac)
to interact with the entities, or write their own convenience functions to do so. finding an object in a array by
property value is not hard, so there's no need to make it a serialized object / map / dict.

## Chapter 3: STAC API

- Foundational Spec
- Extensions

Choreography

Hypermedia web API

Navigation from root catalog / landing page via link relations.

conformance classes for advertising functionality -- some are redunant, because they can be discovered via link relations

Filter / CQL2

## Chapter 4: STAC Client Tooling

### STAC and STAC API Client Libraries

A more complete list is available at [STAC Index](https://stacindex.org/ecosystem) by language, but many
of these projects are unmaintained. This list is more curated.

- Querying STAC API
- Filtering and searching STAC Items
- Pagination and sorting

#### Python

Python has the best support for STAC of any language.

- [PySTAC](https://pystac.readthedocs.io/) - datamodel, reading STAC from files or URLs, and writing to files
- [PySTAC Client](https://pystac-client.readthedocs.io/) - STAC API client. Choose this over stacrs unless you need the
  specific features that stacrs provides.
- [stacrs](https://github.com/stac-utils/stacrs) - Python bindings for [stac-rs](https://github.com/stac-utils/stac-rs).
  Can read, write, and search stac-geoparquet, go to and from Arrow tables to interop with tools like GeoPandas, and has
  async support.

#### JavaScript / TypeScript

JavaScript / TypeScript library support isn't great, even though it's the most common language to build UIs with.

- [stac-js](https://github.com/m-mohr/stac-js) - datamodel and utils for interacting with STAC json
- [stac-browser](https://github.com/radiantearth/stac-browser) - a UI project, but some STAC API interaction code that can be reused
- [filmdrop-ui](https://github.com/Element84/filmdrop-ui) - a UI project, but some STAC API interaction code that can be reused
- [stac-ts](https://github.com/blacha/stac-ts) - TypeScript typings

#### Rust

- [stac-rs](https://github.com/stac-utils/stac-rs) - support for many different STAC formats, overall great package.

#### R

- [rstac](https://github.com/brazil-data-cube/rstac)

#### Julia

- [STAC.jl](https://github.com/JuliaClimate/STAC.jl) - datamodel, reading STAC from files or URLs. As of April 2025, lacking features, but under active development.

## Chapter 5: STAC Generation Tooling

- stac-factory
- PySTAC
- rustac
- [stactools](https://stactools.readthedocs.io/en/stable/)
  - Xml helper tools, since source metadata is commonly in XML
  - cogify
  - add_raster_to_item with stats
  - move assets from source to destination
  - reprojection utilities, built on shapely?
  - epsg from utm
  - affine calculation
  - raster footprint
  - data mask
  - desify polygon and simplify polygon
  - densify_reproject_simplify
- [stactools-packages](https://stactools-packages.github.io/) - lots of examples, maybe even for the exact dataset you're converting
- [antimeridian](https://github.com/gadomski/antimeridian) - fix winding and antimeridian splitting

https://stactools.readthedocs.io/en/stable/footprint.html

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

- [stac-fastapi](https://github.com/stac-utils/stac-fastapi) - Python, FastAPI, modular backend
  - [stac-fastapi-pgstac](https://github.com/stac-utils/stac-fastapi-pgstac): [PostgreSQL](https://github.com/postgres/postgres) + [PostGIS](https://github.com/postgis/postgis) via [PgSTAC](https://github.com/stac-utils/pgstac).
  - [stac-fastapi-elasticsearch-opensearch](https://github.com/stac-utils/stac-fastapi-elasticsearch-opensearch): [Elasticsearch](https://github.com/elastic/elasticsearch) or [OpenSearch](https://github.com/opensearch-project/OpenSearch)
- [stac-server](https://github.com/stac-utils/stac-server) - JavaScript, Express.js OpenSearch, intended to be run as an AWS Lambda, includes example serverless 3.x
  deploy and included in [filmdrop-aws-tf-modules](https://github.com/Element84/filmdrop-aws-tf-modules) and its
  example deployment project [goose](https://github.com/Element84/goose)
- [resto](https://github.com/jjrom/resto) - PHP, PostgreSQL + PostGIS

stac-fastapi-os-es and stac-server use the same format for the storage, so can be interchanged

Other implementations include:

- stac-fastapi
  - [stac-fastapi-mongo](https://github.com/Healy-Hyperspatial/stac-fastapi-mongo): [MongoDB](https://github.com/mongodb/mongo)
  - [stac-fastapi-geoparquet)](https://github.com/stac-utils/stac-fastapi-geoparquet): [GeoParquet](https://geoparquet.org) via [stacrs](https://github.com/stac-utils/stacrs) (experimental)
  - [stac-fastapi-duckdb](https://github.com/Healy-Hyperspatial/stac-fastapi-duckdb): [DuckDB](https://github.com/duckdb/duckdb) (experimental)

Abandoned

- Franklin - Scala - PostgreSQL
- staccato - Java
- dotnetstac - C# .Net library
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
| Filter - Basic Spatial Functions       | ✓[^4]               | ✓[^4]              | ✓            | ✓     |
| Filter - Basic Spatial Plus Functions  | ✓[^4]               | ✓[^4]              | ✓            | ✓     |
| Filter - Spatial Functions             | ✓                   | ✓                  |              |       |
| Filter - Temporal Functions            | ✓                   |                    |              | ✓     |
| Filter - Array Functions               | ✓                   |                    |              |       |
| Filter - Property-Property Comparisons | ✓                   |                    |              |       |
| Filter - Functions                     | ✓                   |                    |              |       |
| Filter - Arithmetic Expressions        | ✓                   |                    |              |       |
| Filter - Case-insensitive Comparison   | ✓                   |                    |              |       |
| Filter - Accent-insensitive Comparison | ✓                   |                    |              |       |
| Sort                                   | ✓                   | ✓                  | ✓            | ✓     |
| Fields                                 | ✓                   | ✓                  | ✓            | ✓     |
| Query                                  | ✓                   | ✓                  | ✓            |       |
| Transaction                            | ✓                   | ✓                  | ✓ [^1]       |       |
| Collection Transaction                 |                     |                    |              |       |
| Collection Search                      | ✓                   |                    |              |       |
| Language (I18N)                        |                     |                    |              |       |
| Aggregations                           |                     | ✓                  | ✓ [^3]       |       |
| Browseable                             |                     |                    |              | ✓     |
| Children                               |                     |                    |              | ✓     |
| Free-Text Search                       | ✓                   |                    |              |       |
| Queue-based Ingestion                  |                     |                    | ✓            |       |
| Deployment template                    |                     |                    | ✓            |       |
|                                        |                     |                    |              |       |
|                                        |                     |                    |              |       |
|                                        |                     |                    |              |       |
|                                        |                     |                    |              |       |
|                                        |                     |                    |              |       |

- resto only supports GET /search endpoint

[^1]: stac-server does not support create with ItemCollection
[^2]: stac-server supports IN and BETWEEN, but not LIKE
[^3]: stac-server supports only GET aggregation endpoints
[^4]: may not support literal bbox?

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
