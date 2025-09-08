#!/bin/bash

#  Save the URL in a variable

url="https://www.stats.govt.nz/assets/Uploads/Annual-enterprise-survey/Annual-enterprise-survey-2023-financial-year-provisional/Download-data/annual-enterprise-survey-2023-financial-year-provisional.csv"


# create folders for project

mkdir -p raw Transformed Gold

# extract and download file to raw folder

echo "downloading file"
curl -s -o raw/rawdata.csv $url

echo "file saved in raw folder"

# making transformation to file
# select only the following columns: year, Value, Units, variable_code
# Step 4: Transform (Rename column + select only 4 columns)

echo "Transforming file..."
awk -F, 'NR==1 {
  for(i=1;i<=NF;i++){
    if($i=="Variable_code") $i="variable_code";
  }
  print $1","$9","$5","$6
  next
}
{
  print $1","$9","$5","$6
}' raw/rawdata.csv > Transformed/2023_year_finance.csv
echo "Transformed file saved in Transformed folder."

# copy to gold folder

cp Transformed/2023_year_finance.csv Gold/

#  Done
echo "ETL process finished!"



		
 



