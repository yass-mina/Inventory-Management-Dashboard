# Inventory Management Dashboard

## 1. Project Overview

The **Inventory Management Dashboard** is a Business Intelligence project developed during a BI internship.

The objective of the project is to provide a clear and interactive view of inventory information using **PostgreSQL, SQL and Grafana**.

The dashboard helps monitor stock levels, identify products requiring reorder, analyze supplier lead times and visualize purchasing activity.

## 2. Technologies Used

* Python
* Pandas
* Jupyter Notebook
* PostgreSQL
* SQL
* pgAdmin
* Grafana
* Git & GitHub

## 3. Project Architecture

The project follows the following data pipeline:

```text
Raw Dataset
     ↓
Data Cleaning / Preparation
     ↓
Cleaned CSV Dataset
     ↓
PostgreSQL Database
     ↓
SQL Queries
     ↓
Grafana
     ↓
Inventory Management Dashboard
```

## 4. Project Structure

```text
Inventory-Management-Dashboard/
│
├── data/
│   └── inventory_cleaned.csv
│
├── database/
│   ├── 01_create_tables.sql
│   └── 02_load_data.sql
│
├── docs/
│   ├── data_quality_report.md
│   ├── database_schema.md
│   └── testing_results.md
│
├── grafana/
│   └── dashboard_queries.sql
│
└── README.md
```

## 5. Database

The project uses PostgreSQL with the database:

`inventory_db`

The main schemas are:

* `staging`
* `inventory`

Main tables:

* `products`
* `suppliers`
* `inventory`
* `inventory_movements`
* `purchases`

## 6. Dashboard Features

The Grafana dashboard provides:

### KPIs

* Total Products
* Total Units
* Low-Stock Products
* Out-of-Stock Products

### Inventory Analysis

* Low-stock products
* Inventory status
* Reorder required products
* Current stock information
* Stock by category

### Purchasing Analysis

* Purchases over time
* Supplier lead time

### Filters

The dashboard includes:

* Product filter
* Stock Status filter

## 7. Stock Status Rules

The dashboard uses the following business rules:

| Condition                            | Status       |
| ------------------------------------ | ------------ |
| `current_stock > reorder_point`      | In Stock     |
| `0 < current_stock <= reorder_point` | Low Stock    |
| `current_stock = 0`                  | Out of Stock |

A product is considered to require reorder when:

```text
current_stock <= reorder_point
```

## 8. Data Limitations

The provided dataset does not contain inventory movement records.

The `inventory.inventory_movements` table was therefore created but remains empty.

No artificial movement data was added.

Supplier lead time and purchasing analysis are based on the available order and delivery dates.

## 9. Testing

The dashboard and database were tested for:

* Product count
* Total inventory units
* Low-stock detection
* Out-of-stock detection
* Stock status classification
* Reorder detection
* Product filtering
* Stock status filtering
* Supplier lead time
* Purchasing analysis

Detailed testing results are available in:

`docs/testing_results.md`

## 10. Documentation

Additional technical documentation is available in the `docs` directory:

* `data_quality_report.md`
* `database_schema.md`
* `testing_results.md`

Grafana SQL queries are available in:

`grafana/dashboard_queries.sql`

## 11. Conclusion

The project provides a functional Inventory Management Dashboard using PostgreSQL, SQL and Grafana.

It allows users to monitor current inventory, identify low-stock and out-of-stock products, determine reorder requirements and analyze purchasing and supplier information.
