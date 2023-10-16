#
# This is the configuration file containing the extensions that are used when testing the httpfs extension
#

duckdb_extension_load(json)
duckdb_extension_load(parquet)
duckdb_extension_load(tpcds)
duckdb_extension_load(tpch)