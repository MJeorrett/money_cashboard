-- psql -d money_cashboard -f db/sql/money_cashboard.sql

DROP TABLE IF EXISTS transactions_tags;
DROP TABLE IF EXISTS transactions;
DROP TABLE IF EXISTS merchants;
DROP TABLE IF EXISTS tags;

CREATE TABLE tags (
  id SERIAL4 primary key,
  name VARCHAR(100),
  catagory VARCHAR(100)
);

CREATE TABLE merchants (
  id SERIAL4 primary key,
  name VARCHAR(100)
);

CREATE TABLE transactions (
  id SERIAL8 primary key,
  merchant_id INT4 references merchants(id),
  payment_date DATE,
  notes VARCHAR(255)
);

CREATE TABLE transactions_tags (
  transaction_id INT8 references transactions(id),
  tag_id INT4 references tags(id)
)
