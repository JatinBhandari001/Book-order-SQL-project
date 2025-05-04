create database orders;

create table book
(
book_ID int(3) primary key,
title varchar(100),
author varchar(100),
genre varchar(100),
published_year int(4),
price numeric(10,2),
stock int(2));

create table customer
(
customer_id int(3) primary key,
customer_name varchar(100),
email varchar(100),
phone numeric(15),
city varchar(100),
country varchar(100));

create table orders
(
order_id int(3) primary key,
customer_id int(3) references customer(customer_id),
book_id int(3) references book(book_id),
order_date date,
quantity int(3),
amount numeric(10,2));

select * from book;
select * from customer;
select * from orders;

## retrieve all books in the fiction genre.
select * from book
where genre='fiction';

## Find book published after the year 1950
select * from book
where published_year>1950; 

## List all customer from canada
select * from customer
where country="canada";

## Show order placed in Nov 2023
select * from orders
where order_date between "2023-11-01" and "2023-11-30";

## Retrieve the total stock of book available
select sum(stock) as total_stock
from book;

## Find the detail of the most expensive book
select * from book
order by price desc
limit 1;

## Show all customer who ordered more than 1 quantity of book
select * from orders
where quantity>1;

## Retrieve all order where the total amount exceed $20
select * from orders
where amount>20;

## List all genre available int he book table 
select distinct genre 
from book;

## Find the book with the lowest stock 
select * from book
order by stock 
limit 5;

## calculate the total revenue generated from all order
select sum(amount) as total_revenune
from orders;

## Retrieve the total number of book sold for each genre
select book.genre, sum(orders.quantity)
as Total_book_sold
from orders
join book on orders.book_id = book.book_id
group by genre;

## Find the average price of book in the fantasy genre
select * from book;
select avg(price) as Fantasy_book
from book
where genre="fantasy";

##List customer who have placed atleast 2 orders
select * from orders;
select orders.customer_id, customer.customer_name, count(order_id) as order_count
from orders 
join customer on customer.customer_id = orders.customer_id
group by customer_id
having count(order_id)>=2;  

## Find the most freuently book orderd
Select orders.book_id, book.title, count(orders.order_id) as Book_count
from orders
join book on orders.book_id = book.book_id
group by orders.book_id 
order by Book_count desc
limit 5; 

## Show the top 3 most expensive books of "fantasy" genre
select * from book
where genre ="fantasy"
order by price desc
limit 3;

## Retrieve the total quantity of book sold by each author
select book.author, sum(orders.quantity) as total_quantity 
from orders
join book on orders.book_id = book.book_id
group by book.author;

## List the cities where customer who spent over $30 are located
select distinct customer.city , orders.amount
from orders
join customer on orders.customer_id = customer.customer_id
where orders.amount>30;

# Find the customer who spend the most on the orders
select customer.customer_id, customer.customer_name, sum(orders.amount) as total_spend
from orders
join customer on orders.customer_id = customer.customer_id
group by customer.customer_id, customer.customer_name
order by total_spend desc limit 1;

#Calculate the stock remaining after all the orders
select book.book_id, book.title, coalesce(sum(orders.quantity),0) as order_quantity,
   book.title-coalesce(sum(orders.quantity),0) as Remaining_stock
from book
left join orders on book.book_id=orders.book_id
group by book.book_id
order by book.book_id;

########################################






