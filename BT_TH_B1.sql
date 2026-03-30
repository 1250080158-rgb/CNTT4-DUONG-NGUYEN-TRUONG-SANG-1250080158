--Bài 1
--BƯỚC 1
SHOW USER;
--BƯỚC 2
--Tạo bảng region
CREATE TABLE s_region (
id NUMBER(7) CONSTRAINT s_region_id_pk PRIMARY KEY,
name VARCHAR2(50) NOT NULL
);

--Tạo bảng dept
CREATE TABLE s_dept (
id NUMBER(7) CONSTRAINT s_dept_id_pk PRIMARY KEY,
name VARCHAR2(25) NOT NULL,
region_id NUMBER(7) CONSTRAINT s_dept_region_id_fk
REFERENCES s_region(id)
);
--Tạo bảng title
CREATE TABLE s_title (
    title VARCHAR2(50) CONSTRAINT s_title_pk PRIMARY KEY
);
--Tạo bảng emp
CREATE TABLE s_emp (
    id NUMBER PRIMARY KEY,
    last_name VARCHAR2(50) NOT NULL,
    first_name VARCHAR2(50),
    userid VARCHAR2(20) UNIQUE,
    start_date DATE,
    comments VARCHAR2(255),
    manager_id NUMBER REFERENCES s_emp(id),
    title VARCHAR2(50) REFERENCES s_title(title),
    dept_id NUMBER REFERENCES s_dept(id),
    salary NUMBER(11, 2),
    commission_pct NUMBER(4, 2)
);

--Tạo bảng customer
CREATE TABLE s_customer (
    id NUMBER PRIMARY KEY,
    name VARCHAR2(100) NOT NULL,
    phone VARCHAR2(20),
    address VARCHAR2(255),
    city VARCHAR2(50),
    state VARCHAR2(50),
    country VARCHAR2(50),
    zip_code VARCHAR2(20),
    credit_rating VARCHAR2(20),
    sales_rep_id NUMBER REFERENCES s_emp(id),
    region_id NUMBER REFERENCES s_region(id),
    comments VARCHAR2(255)
);

--Tạo bảng image 
CREATE TABLE s_image (
    id NUMBER PRIMARY KEY,
    format VARCHAR2(10),
    use_filename VARCHAR2(1),
    filename VARCHAR2(100),
    image BLOB
);

--Tạo bảng longtext 
CREATE TABLE s_longtext (
    id NUMBER PRIMARY KEY,
    use_filename VARCHAR2(1),
    filename VARCHAR2(100),
    text CLOB
);

--Tạo bảng product
CREATE TABLE s_product (
    id NUMBER PRIMARY KEY,
    name VARCHAR2(100) NOT NULL,
    short_desc VARCHAR2(255),
    longtext_id NUMBER REFERENCES s_longtext(id),
    image_id NUMBER REFERENCES s_image(id),
    suggested_whlsl_price NUMBER(11, 2),
    whlsl_units VARCHAR2(20)
);

--Tạo bảng ord
CREATE TABLE s_ord (
    id NUMBER PRIMARY KEY,
    customer_id NUMBER REFERENCES s_customer(id),
    date_ordered DATE,
    date_shipped DATE,
    sales_rep_id NUMBER REFERENCES s_emp(id),
    total NUMBER(11, 2),
    payment_type VARCHAR2(20),
    order_filled VARCHAR2(1)
);

--Tạo bảng item
CREATE TABLE s_item (
    ord_id NUMBER REFERENCES s_ord(id),
    item_id NUMBER,
    product_id NUMBER REFERENCES s_product(id),
    price NUMBER(11, 2),
    quantity NUMBER,
    quantity_shipped NUMBER,
    PRIMARY KEY (ord_id, item_id)
);

--Tạo bảng inventory
CREATE TABLE s_inventory (
    product_id NUMBER REFERENCES s_product(id),
    warehouse_id NUMBER REFERENCES s_warehouse(id),
    amount_in_stock NUMBER,
    reorder_point NUMBER,
    max_in_stock NUMBER,
    out_of_stock_explanation VARCHAR2(255),
    restock_date DATE,
    PRIMARY KEY (product_id, warehouse_id)
);

--Tạo bảng warehouse
CREATE TABLE s_warehouse (
    id NUMBER PRIMARY KEY,
    region_id NUMBER REFERENCES s_region(id),
    address VARCHAR2(255),
    city VARCHAR2(50),
    state VARCHAR2(50),
    country VARCHAR2(50),
    zip_code VARCHAR2(20),
    phone VARCHAR2(20),
    manager_id NUMBER REFERENCES s_emp(id)
);
--BƯỚC 3
--Kiểm tra các table đã tạo 
DESC s_emp;
DESC s_dept;

SELECT table_name FROM user_tables ORDER BY table_name;
--BƯỚC 4
--Tạo các database
-- Dữ liệu Khu vực
INSERT INTO s_region (id, name) VALUES (1, 'North America');
INSERT INTO s_region (id, name) VALUES (2, 'Asia');

INSERT INTO s_emp (id, last_name, first_name, userid, start_date, title, dept_id, salary)
VALUES (10, 'Magee', 'Colin', 'cmagee', TO_DATE('14-05-1990', 'DD-MM-YYYY'), 'Sales Representative', 31, 1400);

INSERT INTO s_emp (id, last_name, first_name, userid, start_date, title, dept_id, salary)
VALUES (11, 'Gilson', 'Sam', 'sgilson', TO_DATE('18-01-1991', 'DD-MM-YYYY'), 'Sales Representative', 31, 1500);

INSERT INTO s_emp (id, last_name, first_name, userid, start_date, title, dept_id, salary)
VALUES (12, 'Smith', 'John', 'jsmith', TO_DATE('01-06-1991', 'DD-MM-YYYY'), 'Developer', 10, 2000);

-- Dữ liệu Chức danh
INSERT INTO s_title (title) VALUES ('President');
INSERT INTO s_title (title) VALUES ('VP, Operations');
INSERT INTO s_title (title) VALUES ('Sales Representative');
INSERT INTO s_title (title) VALUES ('Warehouse Manager');

-- Dữ liệu Hình ảnh & Văn bản (Bổ trợ cho sản phẩm)
INSERT INTO s_image (id, format, filename) VALUES (1, 'png', 'bicycle_01.png');
INSERT INTO s_longtext (id, text) VALUES (1, 'Professional mountain bike with 21 speeds.');

-- Dữ liệu Phòng ban
INSERT INTO s_dept (id, name, region_id) VALUES (10, 'Administration', 1);
INSERT INTO s_dept (id, name, region_id) VALUES (31, 'Sales', 2);

-- Dữ liệu Nhân viên 
INSERT INTO s_emp (id, last_name, first_name, userid, start_date, title, dept_id, salary) 
VALUES (1, 'Velasquez', 'Carmen', 'cvelasqu', TO_DATE('1990-03-03', 'YYYY-MM-DD'), 'President', 10, 2500);

INSERT INTO s_emp (id, last_name, first_name, userid, start_date, title, dept_id, salary, manager_id) 
VALUES (2, 'Nga', 'Nguyen', 'nnguyen', TO_DATE('2020-01-15', 'YYYY-MM-DD'), 'Warehouse Manager', 31, 1500, 1);

INSERT INTO s_region (id, name) VALUES (1, 'Vietnam');
INSERT INTO s_dept (id, name, region_id) VALUES (10, 'Sales', 1);
INSERT INTO s_title (title) VALUES ('Manager');
INSERT INTO s_title (title) VALUES ('Staff');

INSERT INTO s_emp (id, last_name, first_name, userid, start_date, title, dept_id, salary)
VALUES (3, 'Nguyen', 'Boss', 'boss1', SYSDATE, 'Manager', 10, 5000);

-- Dữ liệu Kho hàng (Cần s_region và s_emp quản lý)
INSERT INTO s_warehouse (id, region_id, city, manager_id) 
VALUES (1, 1, 'New York', 2);

-- Dữ liệu Khách hàng (Cần s_emp bán hàng và s_region)
INSERT INTO s_customer (id, name, phone, sales_rep_id, region_id, credit_rating) 
VALUES (1, 'An Binh Co.', '0901234567', 1, 2, 'Good');

-- Dữ liệu Sản phẩm
INSERT INTO s_product (id, name, short_desc, longtext_id, image_id, suggested_whlsl_price) 
VALUES (1, 'Mountain Bike', 'High quality bike', 1, 1, 500);

-- Dữ liệu Tồn kho
INSERT INTO s_inventory (product_id, warehouse_id, amount_in_stock, reorder_point) 
VALUES (1, 1, 100, 20);

INSERT INTO s_product (id, name, short_desc, suggested_whlsl_price)
VALUES (101, 'Pro Mountain Bike', 'Xe đạp địa hình chuyên nghiệp', 500);

INSERT INTO s_product (id, name, short_desc, suggested_whlsl_price)
VALUES (102, 'Pro Helmet', 'Mũ bảo hiểm cao cấp', 50);

INSERT INTO s_product (id, name, short_desc, suggested_whlsl_price)
VALUES (103, 'Pro Gloves', 'Găng tay bảo hộ chuyên dụng', 25);

INSERT INTO s_product (id, name, short_desc, suggested_whlsl_price)
VALUES (104, 'Standard Pump', 'Bơm xe tiêu chuẩn', 15); 

INSERT INTO s_product (id, name, short_desc, suggested_whlsl_price)
VALUES (105, 'Pro Water Bottle', 'Bình nước thể thao Pro', 10);

INSERT INTO s_product (id, name, short_desc, suggested_whlsl_price)
VALUES (201, 'Mountain Bike 2.0', 'A professional mountain bicycle for racing', 600);

INSERT INTO s_product (id, name, short_desc, suggested_whlsl_price)
VALUES (202, 'City Cycle', 'Comfortable city bicycle', 350);

INSERT INTO s_product (id, name, short_desc, suggested_whlsl_price)
VALUES (203, 'Old School', 'Vintage Bicycle model 1980', 200);

INSERT INTO s_product (id, name, short_desc, suggested_whlsl_price)
VALUES (204, 'Fast Bike', 'Very fast motorbike', 1200);

INSERT INTO s_product (id, name, short_desc, suggested_whlsl_price)
VALUES (301, 'Ski pole', 'Dung cu ho tro truot tuyet', 45);

INSERT INTO s_product (id, name, short_desc, suggested_whlsl_price)
VALUES (302, 'SKI BOOTS', 'Giay truot tuyet cao cap', 150);

INSERT INTO s_product (id, name, short_desc, suggested_whlsl_price)
VALUES (303, 'Water Skiing Board', 'Van truot nuoc', 200);

INSERT INTO s_product (id, name, short_desc, suggested_whlsl_price)
VALUES (304, 'Snowboard', 'Van truot tuyet loai don', 120);

INSERT INTO s_customer (id, name, region_id) 
VALUES (501, 'Vip Customer', 1);

INSERT INTO s_ord (id, customer_id, date_ordered, total) 
VALUES (2001, 501, SYSDATE, 120000);

INSERT INTO s_item (ord_id, item_id, product_id, price, quantity) 
VALUES (2001, 1, 1, 600, 200);

INSERT INTO s_ord (id, customer_id, date_ordered, total) 
VALUES (2002, 501, SYSDATE, 500);

INSERT INTO s_item (ord_id, item_id, product_id, price, quantity) 
VALUES (2002, 1, 2, 50, 10);

-- Dữ liệu Đơn hàng
INSERT INTO s_ord (id, customer_id, date_ordered, sales_rep_id, total, payment_type) 
VALUES (101, 1, SYSDATE, 1, 1000, 'CASH');

-- Chi tiết đơn hàng
INSERT INTO s_item (ord_id, item_id, product_id, price, quantity) 
VALUES (101, 1, 1, 500, 2);

COMMIT;
SELECT * FROM s_region;
--Bài 2
--Câu 1
SELECT name AS "Ten khach hang",
id AS "Ma khach hang"
FROM s_customer
ORDER BY id DESC;
--Câu 2: Họ, tên và mã phòng nhân viên phòng 10 và 50 — nối họ tên thành cột 'Employees', sắp theo tên
SELECT first_name || ' ' || last_name AS "Employees",
dept_id
FROM s_emp
WHERE dept_id IN (10, 50)
ORDER BY first_name;
--Câu 3: Hiển thị tất cả nhân viên có tên chứa chữ 'S'
SELECT last_name, first_name
FROM s_emp
WHERE first_name LIKE '%S%'
OR last_name LIKE '%S%';
--Câu 4:Tên truy nhập và ngày bắt đầu làm việc từ 14/5/1990 đến 26/5/1991
SELECT userid, start_date
FROM s_emp
WHERE start_date BETWEEN TO_DATE('14/05/1990','DD/MM/YYYY')
AND TO_DATE('26/05/1991','DD/MM/YYYY');
--Câu 5: Tên và lương nhân viên nhận lương từ 1.000 đến 2.000/tháng
SELECT last_name, salary
FROM s_emp
WHERE salary BETWEEN 1000 AND 2000;
--Câu 6: Nhân viên phòng 31, 42, 50 nhận lương trên 1.350 — đặt alias 'Employee Name' và 'Monthly Salary'
SELECT last_name || ' ' || first_name AS "Employee Name",
salary AS "Monthly Salary"
FROM s_emp
WHERE dept_id IN (31, 42, 50)
AND salary > 1350;
--Câu 7: Tên và ngày bắt đầu làm việc của nhân viên được tuyển trong năm 1991
SELECT last_name, start_date
FROM s_emp
WHERE TO_CHAR(start_date, 'YYYY') = '1991';
--Câu 8: Họ tên tất cả nhân viên KHÔNG phải là người quản lý
SELECT last_name, first_name
FROM s_emp
WHERE id NOT IN (SELECT DISTINCT manager_id
FROM s_emp
WHERE manager_id IS NOT NULL);
--Câu 9: Sản phẩm có tên bắt đầu với từ 'Pro', hiển thị theo thứ tự abc
SELECT name
FROM s_product
WHERE name LIKE 'Pro%'
ORDER BY name ASC;
--Câu 10: Tên và SHORT_DESC của sản phẩm có mô tả chứa từ 'bicycle'
SELECT name, short_desc
FROM s_product
WHERE LOWER(short_desc) LIKE '%bicycle%';
--Câu 11: Hiển thị tất cả SHORT_DESC
SELECT short_desc
FROM s_product;
--Câu 12: Tên nhân viên và chức vụ trong ngoặc đơn — ví dụ: Nguyễn Văn Tâm (Giám đốc)
SELECT last_name || ' ' || first_name || ' (' || title || ')' AS "Nhan vien"
FROM s_emp;
--Bài 3
--Câu 1: Mã nhân viên, tên và mức lương được tăng thêm 15%
SELECT id,
last_name,
ROUND(salary * 1.15, 2) AS "Luong moi"
FROM s_emp;
--Câu 2: Tên nhân viên, ngày tuyển dụng và ngày xét tăng lương (thứ Hai sau 6 tháng làm việc), định dạng 'Eighth of May 1992'
SELECT last_name,
start_date,
TO_CHAR(
NEXT_DAY(ADD_MONTHS(start_date, 6), 'MONDAY'),
'Ddspth "of" Month YYYY'
) AS "Ngay xet tang luong"
FROM s_emp;
--Câu 3: Tên sản phẩm của tất cả sản phẩm có chữ 'ski' (không phân biệt hoa/thường)
SELECT name
FROM s_product
WHERE LOWER(name) LIKE '%ski%';
--Câu 4: Tính số tháng thâm niên của mỗi nhân viên (làm tròn), sắp tăng dần
SELECT last_name,
ROUND(MONTHS_BETWEEN(SYSDATE, start_date)) AS "So thang tham
nien"
FROM s_emp
ORDER BY MONTHS_BETWEEN(SYSDATE, start_date) ASC;
--Câu 5: Có bao nhiêu người quản lý?
SELECT COUNT(DISTINCT manager_id) AS "So nguoi quan ly"
FROM s_emp
WHERE manager_id IS NOT NULL;
--Câu 6: Mức cao nhất và thấp nhất của đơn hàng trong s_ord — đặt alias là 'Highest' và 'Lowest'
SELECT MAX(total) AS "Highest",
MIN(total) AS "Lowest"
FROM s_ord;
--Bài 4
--Câu 1: Tên sản phẩm, mã sản phẩm và số lượng trong đơn hàng mã 101 — cột số lượng đặt tên 'ORDERED'
SELECT p.name,
p.id,
i.quantity AS "ORDERED"
FROM s_product p, s_item i
WHERE p.id = i.product_id
AND i.ord_id = 101;
--Câu 2: Mã khách hàng và mã đơn đặt hàng của TẤT CẢ khách hàng (kể cả chưa đặt hàng), sắp theo mã KH
SELECT c.id AS "Ma khach hang",
o.id AS "Ma don hang"
FROM s_customer c, s_ord o
WHERE c.id = o.customer_id(+)
ORDER BY c.id;
--Câu 3: Mã khách hàng, mã sản phẩm và số lượng đặt hàng của đơn hàng có trị giá trên 100.000
SELECT o.customer_id,
i.product_id,
i.quantity
FROM s_ord o, s_item i
WHERE o.id = i.ord_id
AND o.total > 100000;
--BÀI 5: Các Hàm Gộp Nhóm
--Câu 1: Với từng người quản lý: mã người quản lý và số nhân viên họ quản lý
SELECT manager_id AS "Ma quan ly",
COUNT(id) AS "So nhan vien"
FROM s_emp
WHERE manager_id IS NOT NULL
GROUP BY manager_id
ORDER BY manager_id;
--Câu 2: Người quản lý quản lý từ 20 nhân viên trở lên
SELECT manager_id AS "Ma quan ly",
COUNT(id)  AS "So nhan vien"
FROM s_emp
WHERE manager_id IS NOT NULL
GROUP BY manager_id
HAVING COUNT(id) >= 20;
--Câu 3: Mã vùng, tên vùng và số phòng ban trực thuộc trong mỗi vùng
SELECT r.id AS "Ma vung",
r.name AS "Ten vung",
COUNT(d.id) AS "So phong ban"
FROM s_region r, s_dept d
WHERE r.id = d.region_id
GROUP BY r.id, r.name
ORDER BY r.id;
--Câu 4: Tên khách hàng và số lượng đơn đặt hàng của mỗi khách
SELECT c.name AS "Ten khach hang",
COUNT(o.id) AS "So don dat hang"
FROM s_customer c, s_ord o
WHERE c.id = o.customer_id
GROUP BY c.id, c.name
ORDER BY c.name;
--Câu 5: Khách hàng có số đơn đặt hàng nhiều nhất
SELECT c.name, COUNT(o.id) AS "So don hang"
FROM s_customer c, s_ord o
WHERE c.id = o.customer_id
GROUP BY c.id, c.name
HAVING COUNT(o.id) = (
SELECT MAX(COUNT(id))
FROM s_ord
GROUP BY customer_id
);
--Câu 6: Khách hàng có tổng tiền mua hàng lớn nhất
SELECT c.name, SUM(o.total) AS "Tong tien"
FROM s_customer c, s_ord o
WHERE c.id = o.customer_id
GROUP BY c.id, c.name
HAVING SUM(o.total) = (
SELECT MAX(SUM(total))
FROM s_ord
GROUP BY customer_id
);
--BÀI 6: Truy Vấn Con (Subquery)
--Câu 1: Họ, tên và ngày tuyển dụng của nhân viên cùng phòng với 'Lan'
--Trường hợp chỉ có 1 Lan — dùng = :
SELECT last_name, first_name, start_date
FROM s_emp
WHERE dept_id = (
SELECT dept_id
FROM s_emp
WHERE first_name = 'Lan'
)
AND first_name != 'Lan';
--Trường hợp có nhiều Lan — dùng IN (an toàn hơn):
SELECT last_name, first_name, start_date
FROM s_emp
WHERE dept_id IN (SELECT dept_id FROM s_emp WHERE first_name = 'Lan')
AND first_name != 'Lan';
--Câu 2: Mã nhân viên, họ, tên và mã truy cập của nhân viên có lương trên mức lương trung bình
SELECT id, last_name, first_name, userid
FROM s_emp
WHERE salary > (SELECT AVG(salary) FROM s_emp);
--Câu 3: Mã, họ, tên của nhân viên có lương trên trung bình VÀ tên chứa ký tự 'L'
SELECT id, last_name, first_name
FROM s_emp
WHERE salary > (SELECT AVG(salary) FROM s_emp)
AND (UPPER(first_name) LIKE '%L%'
OR UPPER(last_name) LIKE '%L%');
--Câu 4: Những khách hàng chưa bao giờ đặt hàng
--Cách 1 — NOT IN (chú ý phải lọc NULL):
SELECT name
FROM s_customer
WHERE id NOT IN (
SELECT DISTINCT customer_id
FROM s_ord
WHERE customer_id IS NOT NULL
);
--Cách 2 — NOT EXISTS (hiệu quả hơn, an toàn với NULL):
SELECT c.name
FROM s_customer c
WHERE NOT EXISTS (
SELECT 1
FROM s_ord o
WHERE o.customer_id = c.id
);