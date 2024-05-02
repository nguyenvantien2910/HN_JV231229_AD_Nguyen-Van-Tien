SET SQL_SAFE_UPDATES = 0;
CREATE DATABASE QUANLYBANHANG;

USE QUANLYBANHANG;

#Bài 1: Tạo CSDL [20 điểm]:
CREATE TABLE CUSTOMERS
(
    customer_id varchar(4)   not null,
    name        varchar(100) not null,
    email       varchar(100) not null unique,
    phone       varchar(25)  not null unique,
    address     varchar(255) not null,

    PRIMARY KEY (customer_id)
);

CREATE TABLE ORDERS
(
    order_id     varchar(4) not null,
    customer_id  varchar(4) not null,
    order_date   date       not null,
    total_amount double     not null,

    PRIMARY KEY (order_id)
);

CREATE TABLE PRODUCTS
(
    product_id  varchar(4)   not null,
    name        varchar(255) not null,
    description text,
    price       double       not null,
    status      bit(1)       not null,

    PRIMARY KEY (product_id)
);

CREATE TABLE ORDERS_DETAILS
(
    order_id   varchar(4) not null,
    product_id varchar(4) not null,
    quantity   int(11)    not null,
    price      double     not null,

    PRIMARY KEY (order_id, product_id)
);

ALTER TABLE ORDERS
    ADD CONSTRAINT order_cutomer_pk FOREIGN KEY (customer_id) REFERENCES CUSTOMERS (customer_id);

ALTER TABLE ORDERS_DETAILS
    ADD CONSTRAINT order_detail_order_pk FOREIGN KEY (order_id) REFERENCES ORDERS (order_id),
    ADD CONSTRAINT order_detail_product_pk FOREIGN KEY (product_id) REFERENCES PRODUCTS (product_id);


# Bài 2: Thêm dữ liệu [20 điểm]:
# Thêm dữ liệu vào các bảng như sau :
# - Bảng CUSTOMERS [5 điểm] :
INSERT INTO CUSTOMERS(customer_id, name, email, phone, address)
VALUES ('C001', 'Nguyễn Trung Mạnh', 'manhnt@gmail.com', '984756322', 'Cầu Giấy, Hà Nội'),
       ('C002', 'Hồ Hải Nam', 'namhh@gmail.com', '984875926', 'Ba Vì, Hà Nội'),
       ('C003', 'Tô Ngọc Vũ', 'vutn@gmail.com', '904725784', 'Mộc Châu, Sơn La'),
       ('C004', 'Phạm Ngọc Anh', 'anhon@gmail.com', '984635365', 'Vinh, Nghệ An'),
       ('C005', 'Trương Minh Cường', 'cuongtm@gmail.com', '989735624', 'Hai Bà Trung, Hà Nội');

# - Bảng PRODUCTS [5 điểm]:
INSERT INTO PRODUCTS(PRODUCT_ID, NAME, DESCRIPTION, PRICE, STATUS)
VALUES ('P001', 'Iphone 13 ProMax', 'Bản 512 GB, xanh lá', 22999999, 1),
       ('P002', 'Dell Vostro V3510', 'Core i5, RAM 8GB', 14999999, 1),
       ('P003', 'Macbook Pro M2', '8 CPU, 10GPU, 8GB, 256 GB', 28999999, 1),
       ('P004', 'Apple Watch Ultra', 'Titanium Alpine Loop Small ', 18999999, 1),
       ('P005', 'Air Pods 2 2022', 'Spatial Audio', 4090000, 1);

# - Thực hiện thêm hoá đơn và chi tiết hoá đơn theo yêu cầu sau:
# + bảng ORDERS [5 điểm]:
INSERT INTO ORDERS(ORDER_ID, CUSTOMER_ID, TOTAL_AMOUNT, ORDER_DATE)
VALUES ('H001', 'C001', 52999997, '2023-02-22'),
       ('H002', 'C001', 80999997, '2023-03-11'),
       ('H003', 'C002', 54359998, '2023-01-22'),
       ('H004', 'C003', 102999995, '2023-03-14'),
       ('H005', 'C003', 80999997, '2023-03-12'),
       ('H006', 'C004', 110449994, '2023-02-01'),
       ('H007', 'C004', 79999996, '2023-03-29'),
       ('H008', 'C005', 29999998, '2023-02-14'),
       ('H009', 'C005', 28999999, '2023-01-10'),
       ('H010', 'C005', 149999994, '2023-04-01');

# + bảng Orders_details [5 điểm]:
INSERT INTO ORDERS_DETAILS(ORDER_ID, PRODUCT_ID, PRICE, QUANTITY)
VALUES ('H001', 'P002', 14999999, 1),
       ('H001', 'P004', 18999999, 2),
       ('H002', 'P001', 22999999, 1),
       ('H002', 'P003', 28999999, 2),
       ('H003', 'P004', 18999999, 2),
       ('H003', 'P005', 4090000, 4),
       ('H004', 'P002', 14999999, 3),
       ('H004', 'P003', 28999999, 2),
       ('H005', 'P001', 22999999, 1),
       ('H005', 'P003', 28999999, 2),
       ('H006', 'P005', 4090000, 5),
       ('H006', 'P002', 14999999, 6),
       ('H007', 'P004', 18999999, 3),
       ('H007', 'P001', 22999999, 1),
       ('H008', 'P002', 14999999, 2),
       ('H009', 'P003', 28999999, 1),
       ('H010', 'P003', 28999999, 2),
       ('H010', 'P001', 22999999, 4);

# Bài 3: Truy vấn dữ liệu [30 điểm]:
# 1. Lấy ra tất cả thông tin gồm: tên, email, số điện thoại và địa chỉ trong bảng Customers .[4 điểm]
SELECT name AS 'Tên', email AS 'Email', phone AS 'Số Điện Thoại', address AS 'Địa Chỉ'
FROM CUSTOMERS;

# 2. Thống kê những khách hàng mua hàng trong tháng 3/2023 (thông tin bao gồm tên, số điện
# thoại và địa chỉ khách hàng). [4 điểm]
SELECT C.name AS 'Tên', C.phone AS 'Số điện thoại', C.address AS 'Địa chỉ'
FROM ORDERS O
         JOIN CUSTOMERS C on O.customer_id = C.customer_id
WHERE YEAR(order_date) = 2023
  AND MONTH(order_date) = 3;

# 3. Thống kê doanh thua theo từng tháng của cửa hàng trong năm 2023 (thông tin bao gồm
# tháng và tổng doanh thu ). [4 điểm]
SELECT MONTH(order_date) AS 'Tháng', sum(total_amount) AS 'Tổng doanh thu'
FROM ORDERS
WHERE YEAR(order_date) = 2023
GROUP BY MONTH(order_date)
ORDER BY month(order_date);

# 4. Thống kê những người dùng không mua hàng trong tháng 2/2023 (thông tin gồm tên khách
# hàng, địa chỉ , email và số điên thoại). [4 điểm]
SELECT c.name AS 'Tên khách hàng', c.address AS 'Địa chỉ', c.email AS 'Email', c.phone AS 'Số điện thoại'
FROM CUSTOMERS c
WHERE c.customer_id NOT IN (SELECT o.customer_id
                            FROM ORDERS o
                            WHERE YEAR(o.order_date) = 2023
                              AND MONTH(o.order_date) = 2);

# 5. Thống kê số lượng từng sản phẩm được bán ra trong tháng 3/2023 (thông tin bao gồm mã
# sản phẩm, tên sản phẩm và số lượng bán ra). [4 điểm]
SELECT P.product_id AS 'Mã Sản Phẩm', P.name AS 'Tên sản phẩm', OD.quantity AS 'Số lượng bán ra'
FROM (ORDERS_DETAILS OD JOIN PRODUCTS P on OD.product_id = P.product_id)
         JOIN ORDERS O ON OD.order_id = O.order_id
WHERE YEAR(O.order_date) = 2023
  AND MONTH(O.order_date) = 3;

# 6. Thống kê tổng chi tiêu của từng khách hàng trong năm 2023 sắp xếp giảm dần theo mức chi
# tiêu (thông tin bao gồm mã khách hàng, tên khách hàng và mức chi tiêu). [5 điểm]
SELECT O.customer_id AS 'Mã Khách hàng', C.name AS 'Tên khách hàng', SUM(total_amount) as 'Tổng chi tiêu'
FROM ORDERS O
         JOIN CUSTOMERS C on O.customer_id = C.customer_id
WHERE YEAR(order_date) = 2023
group by O.customer_id, C.name
ORDER BY `Tổng chi tiêu` DESC;

# 7. Thống kê những đơn hàng mà tổng số lượng sản phẩm mua từ 5 trở lên (thông tin bao gồm
# tên người mua, tổng tiền , ngày tạo hoá đơn, tổng số lượng sản phẩm) . [5 điểm]
SELECT C.name           AS 'Tên người mua',
       O.total_amount   AS 'Tổng tiền',
       O.order_date     AS 'Ngày tạo hóa đơn',
       SUM(OD.quantity) AS 'Tổng số lượng sản phẩm'
FROM ORDERS O
         JOIN ORDERS_DETAILS OD ON O.order_id = OD.order_id
         JOIN CUSTOMERS C ON O.customer_id = C.customer_id
GROUP BY O.order_id, C.name, O.total_amount, O.order_date
HAVING SUM(OD.quantity) >= 5
ORDER BY SUM(OD.quantity) DESC;


# Bài 4: Tạo View, Procedure [30 điểm]:
# 1. Tạo VIEW lấy các thông tin hoá đơn bao gồm : Tên khách hàng, số điện thoại, địa chỉ, tổng
# tiền và ngày tạo hoá đơn . [3 điểm]
CREATE VIEW ORDER_VIEW AS
SELECT C.name         AS 'Tên Khách hàng',
       C.phone        AS 'Số điện thoại',
       C.address      AS 'Địa chỉ',
       O.total_amount AS 'Tổng tiên',
       O.order_date   AS 'Ngày tạo hóa đơn'
FROM ORDERS O
         JOIN CUSTOMERS C on O.customer_id = C.customer_id;

SELECT *
FROM ORDER_VIEW;

# 2. Tạo VIEW hiển thị thông tin khách hàng gồm : tên khách hàng, địa chỉ, số điện thoại và tổng
# số đơn đã đặt. [3 điểm]
CREATE VIEW CUSTOMER_INFO_VIEW AS
SELECT C.name            AS 'Tên khách hàng',
       C.address         AS 'Địa chỉ',
       C.phone           AS 'Số điện thoại',
       count(O.order_id) AS 'Tổng số đơn đã đặt'
FROM CUSTOMERS C
         JOIN ORDERS O on C.customer_id = O.customer_id
GROUP BY C.name, C.address, C.phone
ORDER BY count(O.order_id) DESC;

SELECT *
FROM CUSTOMER_INFO_VIEW;

# 3. Tạo VIEW hiển thị thông tin sản phẩm gồm: tên sản phẩm, mô tả, giá và tổng số lượng đã
# bán ra của mỗi sản phẩm.
CREATE VIEW PRODUCT_INFO_VIEW AS
SELECT P.name           AS 'Tên sản phẩm',
       P.description    AS 'Mô tả',
       P.price          AS 'Giá',
       sum(OD.quantity) AS 'Tổng số lượng đã bán ra'
FROM PRODUCTS P
         JOIN ORDERS_DETAILS OD on P.product_id = OD.product_id
group by P.name, P.description, P.price;

SELECT *
FROM PRODUCT_INFO_VIEW;

# 4. Đánh Index cho trường `phone` và `email` của bảng Customer. [3 điểm]
ALTER TABLE CUSTOMERS
    ADD INDEX phone_email_index (phone, email);

# 5. Tạo PROCEDURE lấy tất cả thông tin của 1 khách hàng dựa trên mã số khách hàng.[3 điểm]
DELIMITER $$
CREATE PROCEDURE get_customer_info_by_id(customerId_In varchar(4))
BEGIN
    SELECT *
    FROM CUSTOMERS
    WHERE customer_id = customerId_In;
END$$
DELIMITER ;

CALL get_customer_info_by_id('C001');

# 6. Tạo PROCEDURE lấy thông tin của tất cả sản phẩm. [3 điểm]
DELIMITER $$
CREATE PROCEDURE get_all_product_info()
BEGIN
    SELECT *
    FROM PRODUCTS;
END$$
DELIMITER ;

CALL get_all_product_info();

# 7. Tạo PROCEDURE hiển thị danh sách hoá đơn dựa trên mã người dùng. [3 điểm]
DELIMITER $$
CREATE PROCEDURE get_all_orders_by_customer_id(customerId_IN varchar(4))
BEGIN
    SELECT *
    FROM ORDERS
    WHERE customer_id = customerId_IN;
END$$
DELIMITER ;

CALL get_all_orders_by_customer_id('C001');

# 8. Tạo PROCEDURE tạo mới một đơn hàng với các tham số là mã khách hàng, tổng
# tiền và ngày tạo hoá đơn, và hiển thị ra mã hoá đơn vừa tạo. [3 điểm]
DELIMITER $$
CREATE PROCEDURE add_new_order(customerId_IN varchar(4), totalAmount_IN double, create_date_IN date)
BEGIN
    DECLARE orderId_IN varchar(4);
    SET orderId_IN = CONCAT('H', LPAD(CONVERT(SUBSTRING((SELECT order_id
                                                         FROM ORDERS
                                                         ORDER BY order_id DESC
                                                         LIMIT 1), 2), UNSIGNED) + 1, 3, '0'));
    INSERT INTO ORDERS(order_id, customer_id, order_date, total_amount)
    VALUES (orderId_IN, customerId_IN, create_date_IN, totalAmount_IN);
    SELECT orderId_IN AS 'Mã hoá đơn vừa tạo';
END $$
DELIMITER ;


CALL add_new_order('C005', 22999990, '2024-05-02');
CALL add_new_order('C005', 24999990, '2024-05-01');

SELECT *
FROM ORDERS
WHERE customer_id = 'C005';

# 9. Tạo PROCEDURE thống kê số lượng bán ra của mỗi sản phẩm trong khoảng
# thời gian cụ thể với 2 tham số là ngày bắt đầu và ngày kết thúc. [3 điểm]
DELIMITER $$
CREATE PROCEDURE get_sale_quantity_of_product_by_range(start_time date, end_time date)
BEGIN
    SELECT P.product_id     AS 'Mã sản phẩm',
           P.name           AS 'Tên sản phẩm',
           O.order_date     AS 'Ngày bán',
           sum(OD.quantity) AS 'Số lượng bán ra'
    FROM (ORDERS O
        JOIN ORDERS_DETAILS OD on O.order_id = OD.order_id)
             JOIN PRODUCTS P ON OD.product_id = P.product_id
    WHERE O.order_date between start_time AND end_time
    GROUP BY P.product_id, P.name, O.order_date;
END$$
DELIMITER ;

CALL get_sale_quantity_of_product_by_range('2023-02-22', '2023-02-23');

# 10. Tạo PROCEDURE thống kê số lượng của mỗi sản phẩm được bán ra theo thứ tự
# giảm dần của tháng đó với tham số vào là tháng và năm cần thống kê. [3 điểm]
DELIMITER $$
CREATE PROCEDURE get_sale_quantity_of_product_by_month_year(month int, year int)
BEGIN
    SELECT P.product_id AS 'Mã sản phẩm', P.name AS 'Tên sản phẩm', SUM(OD.quantity) AS 'Tổng số lượng bán ra'
    FROM PRODUCTS P
             JOIN ORDERS_DETAILS OD on P.product_id = OD.product_id
    GROUP BY P.product_id, P.name
    ORDER BY SUM(OD.quantity);
END$$
DELIMITER ;

CALL get_sale_quantity_of_product_by_month_year(2, 2023);

#drop database quanlybanhang;