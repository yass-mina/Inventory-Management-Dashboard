# Database Schema Documentation

## 1. Database Overview

The Inventory Management Dashboard uses PostgreSQL as the relational database management system.

**Database name:** `inventory_db`

The database is organized into two schemas:

* `staging`
* `inventory`

The `staging` schema is used for raw imported data, while the `inventory` schema contains the structured tables used by Grafana.

## 2. Staging Schema

### `staging.inventory_raw`

This table stores the cleaned inventory dataset before transformation into the final relational structure.

Main columns include:

* `product_id`
* `product_name`
* `category`
* `supplier_id`
* `supplier_name`
* `stock_quantity`
* `reorder_level`
* `reorder_quantity`
* `unit_price`
* `date_received`
* `last_order_date`
* `expiration_date`
* `warehouse_location`
* `sales_volume`
* `inventory_turnover_rate`
* `status`

## 3. Inventory Schema

### `inventory.products`

Stores information about products.

Main attributes:

* `product_id` — Primary Key
* `product_name`
* `category`
* `unit_price`
* `sku`
* `supplier_id`

### `inventory.suppliers`

Stores supplier information.

Main attributes include:

* `supplier_id` — Primary Key
* `supplier_name`

### `inventory.inventory`

Stores the current inventory status of each product.

Main attributes:

* `product_id` — Primary Key and Foreign Key
* `current_stock`
* `reorder_point`

The `current_stock` value represents the current quantity available for each product.

The `reorder_point` represents the quantity at which the product should be considered for reordering.

### `inventory.inventory_movements`

Stores inventory movement records.

Main attributes:

* `movement_id` — Primary Key
* `product_id` — Foreign Key
* `date`
* `movement_type`
* `quantity`

The table was created to support inventory movement analysis. However, the provided dataset does not contain movement records.

### `inventory.purchases`

Stores purchasing information.

Main attributes:

* `purchase_id`
* `supplier_id`
* `order_date`
* `delivery_date`

These dates are used to calculate supplier lead time.

## 4. Relationships

The main relationships are:

* A supplier can be associated with multiple products.
* A product is associated with an inventory record.
* A product can have multiple inventory movements.
* A supplier can have multiple purchase records.

Simplified relationship structure:

```text
suppliers
    │
    ├── products
    │       │
    │       ├── inventory
    │       │
    │       └── inventory_movements
    │
    └── purchases
```

## 5. Business Rules

The dashboard uses the following stock-status rules:

* `current_stock = 0` → **Out of Stock**
* `current_stock > 0 AND current_stock <= reorder_point` → **Low Stock**
* `current_stock > reorder_point` → **In Stock**

Products with:

`current_stock <= reorder_point`

are considered products requiring reorder.

## 6. Database Usage in Grafana

Grafana connects directly to the PostgreSQL database.

SQL queries are used to calculate:

* Total Products
* Total Units
* Low-Stock Products
* Out-of-Stock Products
* Current stock by product
* Reorder requirements
* Supplier lead time
* Purchasing trends
* Inventory status

This database structure provides the foundation for the Inventory Management Dashboard.
