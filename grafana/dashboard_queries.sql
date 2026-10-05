-- ============================================================
-- Inventory Management Dashboard
-- Grafana SQL Queries
-- Database: inventory_db
-- PostgreSQL
-- ============================================================

-- ============================================================
-- 1. TOTAL PRODUCTS
-- Grafana Visualization: Stat
-- ============================================================

SELECT COUNT(*) AS total_products
FROM inventory.products;

-- ============================================================
-- 2. TOTAL UNITS
-- Total current stock
-- Grafana Visualization: Stat
-- ============================================================

SELECT
COALESCE(SUM(current_stock), 0) AS total_units
FROM inventory.inventory;

-- ============================================================
-- 3. LOW-STOCK PRODUCTS
-- Grafana Visualization: Stat
-- ============================================================

SELECT COUNT(*) AS low_stock
FROM inventory.inventory
WHERE current_stock <= reorder_point;

-- ============================================================
-- 4. OUT-OF-STOCK PRODUCTS
-- Grafana Visualization: Stat
-- ============================================================

SELECT COUNT(*) AS out_of_stock
FROM inventory.inventory
WHERE current_stock = 0;

-- ============================================================
-- 5. LOW STOCK PRODUCTS
-- Shows the 10 products with the lowest stock
-- among products requiring reorder
-- Grafana Visualization: Bar Chart
-- ============================================================

SELECT
p.product_name AS product,
i.current_stock AS current_stock
FROM inventory.inventory i
JOIN inventory.products p
ON i.product_id = p.product_id
WHERE i.current_stock <= i.reorder_point
ORDER BY i.current_stock ASC
LIMIT 10;

-- ============================================================
-- 6. INVENTORY TABLE
-- Product, SKU, Stock, Reorder Point, Supplier and Status
-- Grafana Visualization: Table
-- ============================================================

SELECT
p.product_name AS product,
p.sku,
i.current_stock,
i.reorder_point,
s.supplier_name AS supplier,
CASE
WHEN i.current_stock = 0 THEN 'Out of Stock'
WHEN i.current_stock <= i.reorder_point THEN 'Low Stock'
ELSE 'In Stock'
END AS status
FROM inventory.inventory i
JOIN inventory.products p
ON i.product_id = p.product_id
LEFT JOIN inventory.suppliers s
ON p.supplier_id = s.supplier_id
WHERE p.product_name IN (${product:sqlstring})
AND (
'${status}' = 'All'
OR (
'${status}' = 'In Stock'
AND i.current_stock > i.reorder_point
)
OR (
'${status}' = 'Low Stock'
AND i.current_stock > 0
AND i.current_stock <= i.reorder_point
)
OR (
'${status}' = 'Out of Stock'
AND i.current_stock = 0
)
)
ORDER BY i.current_stock ASC;

-- ============================================================
-- 7. REORDER REQUIRED
-- Products that need to be reordered
-- Grafana Visualization: Table
-- ============================================================

SELECT
p.product_name AS product,
i.current_stock AS stock,
i.reorder_point,
CASE
WHEN i.current_stock = 0 THEN 'Out of Stock'
ELSE 'Low Stock'
END AS status
FROM inventory.inventory i
JOIN inventory.products p
ON i.product_id = p.product_id
WHERE i.current_stock <= i.reorder_point
ORDER BY i.current_stock ASC;

-- ============================================================
-- 8. SUPPLIER LEAD TIME
-- Average number of days between order and delivery
-- Grafana Visualization: Table
-- ============================================================

SELECT
s.supplier_name AS supplier,
ROUND(
AVG(p.delivery_date - p.order_date),
2
) AS average_lead_time_days
FROM inventory.purchases p
JOIN inventory.suppliers s
ON p.supplier_id = s.supplier_id
WHERE p.order_date IS NOT NULL
AND p.delivery_date IS NOT NULL
GROUP BY s.supplier_name
ORDER BY average_lead_time_days DESC;

-- ============================================================
-- 9. PURCHASES OVER TIME
-- Number of purchases per month
-- Grafana Visualization: Time Series
-- ============================================================

SELECT
DATE_TRUNC('month', order_date) AS month,
COUNT(*) AS total_purchases
FROM inventory.purchases
GROUP BY month
ORDER BY month;

-- ============================================================
-- 10. TOTAL STOCK BY CATEGORY
-- Additional visualization
-- Grafana Visualization: Bar Chart
-- ============================================================

SELECT
p.category,
SUM(i.current_stock) AS total_stock
FROM inventory.inventory i
JOIN inventory.products p
ON i.product_id = p.product_id
GROUP BY p.category
ORDER BY total_stock DESC;

-- ============================================================
-- 11. LOW STOCK PRODUCTS BY CATEGORY
-- Additional visualization
-- Grafana Visualization: Bar Chart
-- ============================================================

SELECT
p.category,
COUNT(*) AS low_stock_products
FROM inventory.inventory i
JOIN inventory.products p
ON i.product_id = p.product_id
WHERE i.current_stock <= i.reorder_point
GROUP BY p.category
ORDER BY low_stock_products DESC;

-- ============================================================
-- 12. INVENTORY STATUS
-- Additional visualization
-- Grafana Visualization: Pie Chart
-- ============================================================

SELECT
CASE
WHEN current_stock = 0 THEN 'Out of Stock'
WHEN current_stock <= reorder_point THEN 'Low Stock'
ELSE 'In Stock'
END AS status,
COUNT(*) AS product_count
FROM inventory.inventory
GROUP BY status
ORDER BY product_count DESC;

-- ============================================================
-- 13. CURRENT STOCK VS REORDER POINT BY CATEGORY
-- Additional visualization
-- ============================================================

SELECT
p.category,
SUM(i.current_stock) AS current_stock,
SUM(i.reorder_point) AS reorder_point
FROM inventory.inventory i
JOIN inventory.products p
ON i.product_id = p.product_id
GROUP BY p.category
ORDER BY current_stock DESC;

-- ============================================================
-- 14. TOTAL PURCHASES
-- Additional KPI
-- ============================================================

SELECT COUNT(*) AS total_purchases
FROM inventory.purchases;

-- ============================================================
-- NOTE
-- ============================================================
-- inventory.inventory_movements currently contains no records
-- in the provided dataset.
