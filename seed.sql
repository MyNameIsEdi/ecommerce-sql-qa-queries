-- Clean tables before seeding (Order matters due to Foreign Keys!)
TRUNCATE order_items, orders, products, users RESTART IDENTITY CASCADE;

-- 1. Seed Users (לקוחות לדוגמה)
INSERT INTO users (first_name, last_name, email) VALUES
('Edi', 'Mazor', 'edi.qa.pro@example.com'),
('John', 'Doe', 'john.doe@example.com'),
('Jane', 'Smith', 'jane.smith@example.com'),
('Alex', 'Jones', 'alex.j@example.com'),
('Sarah', 'Miller', 'sarah.m@example.com');

-- 2. Seed Products (מוצרים בקטגוריות שונות)
INSERT INTO products (name, category, price, stock_quantity) VALUES
('iPhone 15 Pro', 'Electronics', 999.99, 15),
('MacBook Air M3', 'Electronics', 1299.00, 8),
('Sony WH-1000XM5', 'Electronics', 349.99, 2),
('Ergonomic Office Chair', 'Furniture', 249.50, 20),
('Wireless Mechanical Keyboard', 'Electronics', 89.99, 45),
('Running Shoes', 'Apparel', 120.00, 50),
('🚨 Out of Stock Item', 'Apparel', 45.00, 0); -- מוצר עם 0 במלאי לצורך בדיקות QA

-- 3. Seed Orders (הזמנות בסטטוסים שונים)
INSERT INTO orders (user_id, status, total_amount) VALUES
(1, 'delivered', 1349.98), -- אדי קנה מקלדת ואייפון (תקין)
(1, 'delivered', 349.99),  -- אדי קנה אוזניות (תקין - הופך אותו ל-Top Spender)
(2, 'shipped', 1299.00),    -- ג'ון קנה מקבוק (תקין)
(3, 'pending', 240.00),     -- ג'יין קנתה שני זוגות נעליים (תקין)
(4, 'cancelled', 999.99),   -- אלכס ביטל הזמנה של אייפון (תקין)
(2, 'pending', 9999.00);    -- 🚨 באג מכוון: סכום הזמנה גבוה ולא תואם לפריטים בפנים!

-- 4. Seed Order Items (החיבור בין ההזמנות למוצרים)
INSERT INTO order_items (order_id, product_id, quantity, unit_price) VALUES
-- פריטים עבור ההזמנה הראשונה של אדי (1349.98)
(1, 1, 1, 999.99), -- iPhone
(1, 5, 1, 89.99),  -- Keyboard
-- פריטים עבור ההזמנה השנייה של אדי
(2, 3, 1, 349.99), -- Headphones
-- פריט עבור ההזמנה של ג'ון
(3, 2, 1, 1299.00), -- MacBook
-- פריט עבור ההזמנה של ג'יין
(4, 6, 2, 120.00),  -- 2x Running Shoes
-- פריט עבור ההזמנה המבוטלת של אלכס
(5, 1, 1, 999.99), -- iPhone
-- 🚨 באג מכוון עבור הזמנה מספר 6:
-- פריט שמחיר היחידה שלו הוא 45$, נקנה בכמות של 1, אבל ההזמנה רשומה על 9,999$! 
-- השאילתה הראשונה שלך ב-qa_queries.sql תתפוס את זה מיד.
(6, 7, 1, 45.00);
