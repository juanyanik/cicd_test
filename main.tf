terraform {
  required_providers {
    snowflake = {
      source  = "chanzuckerberg/snowflake"
      version = "0.25.17"
    }
  }

  backend "remote" {
    organization = "cicd-test"

    workspaces {
      name = "gh-actions-demo"
    }
  }
}

provider "snowflake" {
}

resource "snowflake_database" "demo_db" {
  name    = "DEMO_DB"
  comment = "Database for Snowflake Terraform demo"
}

resource "snowflake_database" "demo_db_dev" {
  name    = "DEMO_DB_DEV"
  comment = "Database for DEV"
}

resource "snowflake_database" "demo_db_prod" {
  name    = "DEMO_DB_PROD"
  comment = "Database for PROD"
}

resource "snowflake_schema" "demo_schema" {
  database = snowflake_database.demo_db.name
  name     = "DEMO_SCHEMA"
  comment  = "Schema for Snowflake Terraform demo"
}

resource "snowflake_schema" "demo_schema_dev" {
  database = snowflake_database.demo_db_dev.name
  name     = "DEMO_SCHEMA_DEV"
  comment  = "Schema for Snowflake Terraform demo"
}


resource "snowflake_schema" "demo_schema_prod" {
  database = snowflake_database.demo_db_prod.name
  name     = "DEMO_SCHEMA_PROD"
  comment  = "Schema for Snowflake Terraform demo"
}