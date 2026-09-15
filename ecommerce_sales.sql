USE ecommerce
select * from ecommerce_sales

Q1. What is the overall sales and profitability performance of the company?

SELECT
    SUM(sales) AS total_sales,
    SUM(profit) AS total_profit,
    SUM(quantity) AS total_quantity,
    COUNT(DISTINCT order_id) AS total_orders,
    COUNT(DISTINCT customer_id) AS total_customers
FROM ecommerce_sales;

Q2. How do sales and profit change over time?

SELECT
    year,
    month,
    month_name,
    SUM(sales) AS total_sales,
    SUM(profit) AS total_profit
FROM ecommerce_sales
GROUP BY
    year,
    month,
    month_name
ORDER BY
    year,
    month;

Q3. Which product categories generate the highest sales and profit?

SELECT
    category,
    SUM(sales) AS total_sales,
    SUM(profit) AS total_profit,
    ROUND(
        100.0 * SUM(profit) / NULLIF(SUM(sales), 0),
        2
    ) AS profit_margin
FROM ecommerce_sales
GROUP BY category
ORDER BY total_sales DESC;

Q4. Which sub-categories are the most and least profitable?

SELECT
    [sub-category],
    SUM(sales) AS total_sales,
    SUM(profit) AS total_profit,
    ROUND(
        100.0 * SUM(profit) / NULLIF(SUM(sales), 0),
        2
    ) AS profit_margin
FROM ecommerce_sales
GROUP BY [sub-category]
ORDER BY total_profit DESC;

Q5. Which customer segment contributes the most to sales and profit?

SELECT
    segment,
    SUM(sales) AS total_sales,
    SUM(profit) AS total_profit,
    COUNT(DISTINCT customer_id) AS total_customers,
    ROUND(
        100.0 * SUM(profit) / NULLIF(SUM(sales), 0),
        2
    ) AS profit_margin
FROM ecommerce_sales
GROUP BY segment
ORDER BY total_sales DESC;

Q6. Which regions are performing best in terms of sales and profitability?

SELECT
    region,
    SUM(sales) AS total_sales,
    SUM(profit) AS total_profit,
    ROUND(
        100.0 * SUM(profit) / NULLIF(SUM(sales), 0),
        2
    ) AS profit_margin
FROM ecommerce_sales
GROUP BY region
ORDER BY total_sales DESC;

Q7. Which sub-categories are generating losses?

SELECT
    [sub-category],
    SUM(sales) AS total_sales,
    SUM(profit) AS total_profit,
    ROUND(
        100.0 * SUM(profit) / NULLIF(SUM(sales), 0),
        2
    ) AS profit_margin
FROM ecommerce_sales
GROUP BY [sub-category]
HAVING SUM(profit) < 0
ORDER BY total_profit ASC;

Q8. Which are the top 10 products by sales?

SELECT TOP 10
    product_name,
    SUM(sales) AS total_sales,
    SUM(profit) AS total_profit
FROM ecommerce_sales
GROUP BY product_name
ORDER BY total_sales DESC;

Q9. Which are the top 10 most profitable products?

SELECT TOP 10
    product_name,
    SUM(profit) AS total_profit,
    SUM(sales) AS total_sales
FROM ecommerce_sales
GROUP BY product_name
ORDER BY total_profit DESC;

Q10. Which products have high sales but relatively low profitability?

SELECT TOP 10
    product_name,
    SUM(sales) AS total_sales,
    SUM(profit) AS total_profit,
    ROUND(
        100.0 * SUM(profit) / NULLIF(SUM(sales), 0),
        2
    ) AS profit_margin
FROM ecommerce_sales
GROUP BY product_name
HAVING SUM(sales) > 1000
ORDER BY total_profit ASC;

Q11. How does the level of discount affect sales and profitability?

SELECT
    discount,
    SUM(sales) AS total_sales,
    SUM(profit) AS total_profit,
    ROUND(
        100.0 * SUM(profit) / NULLIF(SUM(sales), 0),
        2
    ) AS profit_margin
FROM ecommerce_sales
GROUP BY discount
ORDER BY discount;

Q12. Which shipping methods generate the highest sales and profit?

SELECT
    ship_mode,
    COUNT(DISTINCT order_id) AS total_orders,
    SUM(sales) AS total_sales,
    SUM(profit) AS total_profit,
    ROUND(
        100.0 * SUM(profit) / NULLIF(SUM(sales), 0),
        2
    ) AS profit_margin
FROM ecommerce_sales
GROUP BY ship_mode
ORDER BY total_sales DESC;