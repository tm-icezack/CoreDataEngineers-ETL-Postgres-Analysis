#!/bin/bash
# ==============================================================
# load_csv_to_postgres.sh
# Load CSV files into PostgreSQL with inferred column types
# Database: posey
# Each table will be named after its CSV filename
# ==============================================================

# PostgreSQL connection settings
DB_NAME="posey"
USER="postgres"
export PGPASSWORD='PUTPASSWORDHERE'

# Folder where CSV files are stored
CSV_DIR=~/Parch-and-Posey-Database-for-SQL

infer_type() {
  value="$1"

  # Empty = TEXT
  if [ -z "$value" ]; then
    echo "TEXT"
    return
  fi

  # Integer check
  if [[ "$value" =~ ^-?[0-9]+$ ]]; then
    echo "INTEGER"
    return
  fi

  # Numeric/decimal check
  if [[ "$value" =~ ^-?[0-9]+\.[0-9]+$ ]]; then
    echo "NUMERIC"
    return
  fi

  # Date/DateTime check (ISO formats)
  if [[ "$value" =~ ^[0-9]{4}-[0-9]{2}-[0-9]{2}$ ]]; then
    echo "DATE"
    return
  fi
  if [[ "$value" =~ ^[0-9]{4}-[0-9]{2}-[0-9]{2}T ]]; then
    echo "TIMESTAMP"
    return
  fi

  # Fallback
  echo "TEXT"
}

# Loop through every CSV file
for file in "$CSV_DIR"/*.csv; do
  table=$(basename "$file" .csv)
  echo " Loading $file into table $table..."

  # Drop table if it exists
  psql -U $USER -d $DB_NAME -c "DROP TABLE IF EXISTS $table;"

  # Read header for column names
  header=$(head -1 "$file")
  IFS=',' read -ra columns <<< "$header"

  # Read 2nd line (first row of data) to guess types
  sample=$(sed -n 2p "$file")
  IFS=',' read -ra values <<< "$sample"

  # Build CREATE TABLE statement
  create_stmt="CREATE TABLE $table ("
  for i in "${!columns[@]}"; do
    col_name=$(echo "${columns[i]}" | tr -d ' ' | tr '[:upper:]' '[:lower:]')
    col_type=$(infer_type "${values[i]}")
    create_stmt+="$col_name $col_type"
    if [ $i -lt $(( ${#columns[@]} - 1 )) ]; then
      create_stmt+=", "
    fi
  done
  create_stmt+=");"

  # Create table
  psql -U $USER -d $DB_NAME -c "$create_stmt"

  # Load data
  psql -U $USER -d $DB_NAME -c "\COPY $table FROM '$file' DELIMITER ',' CSV HEADER;"

  echo " Finished loading table: $table"
done

echo " All CSVs loaded into the $DB_NAME database!"
