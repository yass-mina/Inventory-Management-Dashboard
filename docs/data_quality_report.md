# Data Quality Report

## 1. Project

**Project:** Inventory Management Dashboard
**Visualization Tool:** Grafana
**Database:** PostgreSQL
**Project Type:** Standalone MVP

## 2. Dataset Preparation

The inventory and purchasing dataset was inspected and prepared before being imported into PostgreSQL.

The preparation process included:

* Inspection of dataset structure and columns
* Detection of missing values
* Detection of duplicate records
* Validation of data types
* Validation of dates
* Validation of stock quantities
* Validation of reorder points
* Standardization of product and supplier information
* Removal or handling of invalid records where necessary

## 3. Database Import

After cleaning, the prepared dataset was imported into PostgreSQL.

The main database used for the project is:

`inventory_db`

The database contains the following main schemas/tables:

* `inventory.products`
* `inventory.inventory`
* `inventory.inventory_movements`
* `inventory.suppliers`
* `inventory.purchases`
* `staging.inventory_raw`

## 4. Data Quality Results

The cleaned dataset was successfully imported into PostgreSQL.

The products table contains **989 products**.

The inventory table contains **989 inventory records**.

The purchases table contains purchasing records with:

* Purchase ID
* Supplier ID
* Order Date
* Delivery Date

## 5. Inventory Movements Limitation

The `inventory.inventory_movements` table contains no records in the provided dataset.

Therefore, inventory movement visualization could not be populated with real data.

No artificial movement records were created in order to preserve the integrity of the original dataset.

## 6. Conclusion

The dataset was successfully prepared and loaded into the PostgreSQL database.

The available data was sufficient to implement the main Inventory Management Dashboard MVP, including inventory KPIs, stock status, reorder detection, supplier lead time and purchasing analysis.
