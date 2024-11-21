import snowflake.connector
import os

# Snowflake connection details from environment variables
sf_account = os.getenv('SF_ACCOUNT')
sf_user = os.getenv('SF_USER')
sf_password = os.getenv('SF_PASSWORD')
sf_role = os.getenv('SF_ROLE')
sf_warehouse = os.getenv('SF_WAREHOUSE')

# Establish Snowflake connection
conn = snowflake.connector.connect(
    user=sf_user,
    password=sf_password,
    account=sf_account,
    warehouse=sf_warehouse,
    role=sf_role
)

cursor = conn.cursor()

# Query to get all databases
cursor.execute("SHOW DATABASES")
databases = cursor.fetchall()

# Create a directory in the repo to store the DDLs
repo_dir = './snowflake_ddls'
os.makedirs(repo_dir, exist_ok=True)

# Loop through each database and its objects
for db in databases:
    db_name = db[1]
    cursor.execute(f"USE DATABASE {db_name}")

    # Get all schemas in the database
    cursor.execute("SHOW SCHEMAS")
    schemas = cursor.fetchall()

    for schema in schemas:
        schema_name = schema[1]
        cursor.execute(f"USE SCHEMA {schema_name}")

        # Get all tables in the schema
        cursor.execute("SHOW TABLES")
        tables = cursor.fetchall()

        for table in tables:
            table_name = table[1]
            table_ddl_query = f"SHOW CREATE TABLE {schema_name}.{table_name}"
            cursor.execute(table_ddl_query)
            ddl_result = cursor.fetchone()
            ddl = ddl_result[0] if ddl_result else None

            # Create subdirectories based on the database and schema
            table_dir = os.path.join(repo_dir, db_name, schema_name, table_name)
            os.makedirs(table_dir, exist_ok=True)

            # Write the DDL to a file in the respective folder
            if ddl:
                with open(f"{table_dir}/{table_name}_ddl.sql", "w") as f:
                    f.write(ddl)

cursor.close()
conn.close()
