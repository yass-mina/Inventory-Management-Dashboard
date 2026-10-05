# Testing Results

## 1. Testing Objective

The objective of testing was to verify that the Inventory Management Dashboard correctly displays inventory information and applies the defined business rules.

## 2. Database Tests

### Test 1 — Total Products

SQL query:

```sql
SELECT COUNT(*) AS total_products
FROM inventory.products;
```

Expected result:

**989 products**

Result: **Passed**

---

### Test 2 — Total Inventory Records

SQL query:

```sql
SELECT COUNT(*) AS total_inventory
FROM inventory.inventory;
```

Expected result:

**989 inventory records**

Result: **Passed**

---

### Test 3 — Total Units

SQL query:

```sql
SELECT COALESCE(SUM(current_stock), 0) AS total_units
FROM inventory.inventory;
```

The result is displayed in the **Total Units** KPI in Grafana.

Result: **Passed**

---

### Test 4 — Low-Stock Products

SQL query:

```sql
SELECT COUNT(*) AS low_stock
FROM inventory.inventory
WHERE current_stock <= reorder_point;
```

Expected result:

**465 low-stock products**

Result: **Passed**

---

### Test 5 — Out-of-Stock Products

SQL query:

```sql
SELECT COUNT(*) AS out_of_stock
FROM inventory.inventory
WHERE current_stock = 0;
```

The result is displayed in the **Out-of-Stock Products** KPI.

Result: **Passed**

## 3. Stock Status Tests

The dashboard uses the following rules:

| Condition                  | Expected Status |
| -------------------------- | --------------- |
| Stock > Reorder Point      | In Stock        |
| 0 < Stock <= Reorder Point | Low Stock       |
| Stock = 0                  | Out of Stock    |

These rules were tested using the inventory data.

Result: **Passed**

## 4. Reorder Test

Products where:

```text
current_stock <= reorder_point
```

are displayed in the **Reorder Required** table.

Result: **Passed**

## 5. Product Filter Test

The Product filter was tested by selecting individual products and the **All** option.

The Inventory Table updates according to the selected product.

Result: **Passed**

## 6. Stock Status Filter Test

The Stock Status filter was tested with:

* All
* In Stock
* Low Stock
* Out of Stock

The Inventory Table updates according to the selected status.

Result: **Passed**

## 7. Supplier Lead Time Test

Supplier lead time is calculated using:

```text
delivery_date - order_date
```

The result is displayed by supplier in the **Supplier Lead Time** table.

Result: **Passed**

## 8. Purchases Test

Purchasing records were analyzed using the `order_date` field.

Purchases are grouped by month and displayed in the **Purchases Over Time** visualization.

Result: **Passed**

## 9. Inventory Movements Test

The `inventory.inventory_movements` table was checked.

The table contains no movement records in the provided dataset.

Therefore, no artificial data was added.

Result: **Not Applicable — No movement data available**

## 10. Overall Testing Result

The main Inventory Management Dashboard features were successfully tested.

The following features are operational:

* Inventory KPIs
* Total products
* Total units
* Low-stock detection
* Out-of-stock detection
* Stock status classification
* Reorder detection
* Product filter
* Stock status filter
* Supplier lead time
* Purchasing analysis

The only unavailable feature is inventory movement visualization because the provided dataset contains no movement records.
