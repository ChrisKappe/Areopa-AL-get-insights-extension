
##Stage 0. Pre configure your system

## Install python 
## Install python extension
## Add python to the Path : cmd > set path=%path%; C:\Users\vmadmin\AppData\Roaming\Python\Python37; C:\Users\vmadmin\AppData\Roaming\Python\Python37\Scripts
## Select Interpeter
## Reboot your system
## Install needed packages: py -m pip install pandas

## Stage 1. Import Packages
import pandas as pd
import time

# Start process time measure
start = time.time()

## Stage 2. Get Data
url = 'https://dkatsonpublicdatasource.blob.core.windows.net/machinelearning/AML-restaurant-sales-by-menu-item.json'
sales = pd.read_json(url)

# Stop mesure time
csv_download_time = round(time.time() - start,2)
# Start process time measure
start = time.time()

## Stage 3. Get Insights
# Get TOP 10 best selling days 
top_days = sales.groupby(['date'])['orders'].sum().nlargest(10).reset_index()

# Filter Sales by these days
sales_top_days = sales[sales.date.isin(top_days.date)]

# Get TOP 10 Items best selling in these days
sales_top_items = sales_top_days.groupby(['menu_item'])['orders'].sum().nlargest(10).reset_index()

# Stop mesure time
get_insights_time = round(time.time() - start,2)

# Print results
print("\nTOP 10 best selling items\n")
print(sales_top_items)

print("\nIt took ",csv_download_time, " sec to upload sales data") 
print("\nIt took ",get_insights_time, " sec to get these insights")
