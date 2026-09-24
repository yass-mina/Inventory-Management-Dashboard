CREATE SCHEMA IF NOT EXISTS inventory;

CREATE TABLE IF NOT EXISTS inventory.products (
    product_id VARCHAR(50) PRIMARY KEY,
    product_name VARCHAR(255),
    category VARCHAR(100),
    unit_price NUMERIC(10,2),
    sku VARCHAR(50),
    supplier_id VARCHAR(50)
);

CREATE TABLE IF NOT EXISTS inventory.suppliers (
    supplier_id VARCHAR(50) PRIMARY KEY,
    supplier_name VARCHAR(255)
);

CREATE TABLE IF NOT EXISTS inventory.inventory (
    product_id VARCHAR(50) PRIMARY KEY
        REFERENCES inventory.products(product_id),
    current_stock INT DEFAULT 0,
    reorder_point INT DEFAULT 0
);

CREATE TABLE IF NOT EXISTS inventory.inventory_movements (
    movement_id SERIAL PRIMARY KEY,
    product_id VARCHAR(50)
        REFERENCES inventory.products(product_id),
    date DATE,
    movement_type VARCHAR(50),
    quantity INT
);

CREATE TABLE IF NOT EXISTS inventory.purchases (
    purchase_id SERIAL PRIMARY KEY,
    supplier_id VARCHAR(50)
        REFERENCES inventory.suppliers(supplier_id),
    order_date DATE,
    delivery_date DATE
);