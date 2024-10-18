-- Create demo_db_dev with schema and table
USE DATABASE demo_db_dev;

CREATE SCHEMA demo_schema_dev;

CREATE TABLE demo_schema_dev.demo_table (
    id INT,
    name STRING
);

-- Insert values into the table
INSERT INTO demo_schema_dev.demo_table (id, name)
VALUES 
    (1, 'Alice'),
    (2, 'Bob'),
    (3, 'Charlie');

-- Create empty demo_db_prod
