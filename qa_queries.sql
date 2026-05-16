/* ==================================================================
   QA DATA VALIDATION QUERIES
   These queries are used to verify data integrity in the backend.
================================================================== */

-- 1. 🚨 BUG HUNTING: Verify Order Totals Match Item Totals
-- A classic QA check to ensure the total_amount in the Orders table 
-- perfectly matches the sum of (quantity * unit_price) from Order_Items.
SELECT 
    o.id AS order_id,
    o.total_amount AS saved_total,
    SUM(oi.quantity * oi.unit_price) AS calculated_total
FROM orders o
JOIN order_items oi ON o.id = oi.order_id
GROUP BY o.id, o.total_amount
HAVING o.total_amount != SUM(oi.quantity * oi.unit_price);
-- Expected result for passing test: 0 rows


-- 2. 🚨 INVENTORY CHECK: Find products ordered that exceed current stock
-- Validates if the system allowed a user to order an out-of-stock item.
SELECT 
    p.id, 
    p.name, 
    p.stock_quantity, 
    SUM(oi.quantity) as total_ordered
FROM products p
JOIN order_items oi ON p.id = oi.product_id
JOIN orders o ON oi.order_id = o.id
WHERE o.status IN ('pending', 'shipped')
GROUP BY p.id, p.name, p.stock_quantity
HAVING SUM(oi.quantity) > p.stock_quantity;


-- 3. 📊 BUSINESS LOGIC: Get the Top 5 most valuable customers
-- Shows ability to use JOINs, GROUP BY, and aggregates.
SELECT 
    u.id, 
    u.first_name, 
    u.last_name, 
    COUNT(o.id) AS total_orders,
    SUM(o.total_amount) AS total_spent
FROM users u
JOIN orders o ON u.id = o.user_id
WHERE o.status = 'delivered'
GROUP BY u.id, u.first_name, u.last_name
ORDER BY total_spent DESC
LIMIT 5;


-- 4. 🔍 ORPHAN DATA CHECK: Find Users with no orders
-- Validates LEFT JOIN functionality to find edge cases.
SELECT 
    u.id, 
    u.email, 
    u.created_at
FROM users u
LEFT JOIN orders o ON u.id = o.user_id
WHERE o.id IS NULL;


-- 5. 📈 REPORTING: Revenue by Product Category
-- Useful for data extraction tasks often requested from QA/Data teams.
SELECT 
    p.category, 
    SUM(oi.quantity) AS total_items_sold,
    SUM(oi.quantity * oi.unit_price) AS total_revenue
FROM products p
JOIN order_items oi ON p.id = oi.product_id
JOIN orders o ON oi.order_id = o.id
WHERE o.status != 'cancelled'
GROUP BY p.category
ORDER BY total_revenue DESC;
