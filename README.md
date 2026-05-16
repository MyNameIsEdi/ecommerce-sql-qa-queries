# 🛒 E-commerce Database & QA Queries

![PostgreSQL](https://img.shields.io/badge/PostgreSQL-316192?style=flat-square&logo=postgresql&logoColor=white)
![SQL](https://img.shields.io/badge/SQL-Data_Testing-4479A1?style=flat-square&logo=mysql&logoColor=white)
![QA](https://img.shields.io/badge/QA-Database_Validation-FF4B4B?style=flat-square)

A comprehensive SQL database schema simulating a modern e-commerce platform, designed specifically for **Data Validation** and **QA Automation** purposes. This repository demonstrates relational database design, data seeding, and complex SQL querying for backend testing.

---

## 🗄️ Database Schema (ERD)

The database consists of 4 core tables: `Users`, `Products`, `Orders`, and `Order_Items`.

```mermaid
erDiagram
    USERS ||--o{ ORDERS : places
    ORDERS ||--|{ ORDER_ITEMS : contains
    PRODUCTS ||--o{ ORDER_ITEMS : "is part of"

    USERS {
        int id PK
        string first_name
        string last_name
        string email
        datetime created_at
    }
    PRODUCTS {
        int id PK
        string name
        string category
        decimal price
        int stock_quantity
    }
    ORDERS {
        int id PK
        int user_id FK
        string status
        decimal total_amount
        datetime order_date
    }
    ORDER_ITEMS {
        int id PK
        int order_id FK
        int product_id FK
        int quantity
        decimal unit_price
    }
