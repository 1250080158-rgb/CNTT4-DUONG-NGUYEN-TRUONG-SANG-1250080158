SELECT
table_name FROM user_tables

--Câu 1: Liệt kê last_name và salary của nhân viên có salary > 12.000$
SELECT last_name, salary
FROM   employees
WHERE  salary > 12000;

--Câu 2: Nhân viên có salary < 5.000$ HOẶC > 12.000$
--Cách 1 - Dùng OR:
SELECT last_name, salary
FROM   employees
WHERE  salary < 5000 OR salary > 12000;
--Cách 2 - Dùng NOT BETWEEN (tương đương):
SELECT last_name, salary
FROM   employees
WHERE  salary NOT BETWEEN 5000 AND 12000;

--Câu 3: last_name, job_id, hire_date từ 20/02/1998 đến 01/05/1998, sắp tăng dần theo ngày
SELECT last_name, job_id, hire_date
FROM   employees
WHERE  hire_date BETWEEN TO_DATE('20/02/2000','DD/MM/YYYY')
                  AND TO_DATE('01/05/2006','DD/MM/YYYY')
ORDER BY hire_date ASC;

--Câu 4: Nhân viên phòng 20 và 50: last_name, department_id, sắp xếp theo tên
SELECT last_name, department_id
FROM employees
WHERE department_id IN (20, 50)
ORDER BY last_name ASC;

--Câu 5: Nhân viên được tuyển trong năm 1994
--Cách 1: TO_CHAR (khuyên dùng):
SELECT last_name, hire_date
FROM   employees
WHERE  TO_CHAR(hire_date, 'YYYY') = '2003';
--Cách 2: BETWEEN:
SELECT last_name, hire_date
FROM   employees
WHERE  hire_date BETWEEN TO_DATE('01/01/2003','DD/MM/YYYY')
                  AND TO_DATE('31/12/2003','DD/MM/YYYY');

--Câu 6: Nhân viên không có người quản lý (manager_id là NULL)
SELECT last_name, job_id
FROM employees
WHERE manager_id IS NULL;

--Câu 7: Nhân viên được hưởng hoa hồng (commission_pct), sắp xếp giảm dần theo lương và hoa hồng
SELECT last_name, salary, commission_pct
FROM employees
WHERE commission_pct IS NOT NULL
ORDER BY salary DESC, commission_pct DESC;

--Câu 8: Nhân viên có ký tự thứ 3 trong last_name là 'a'
SELECT last_name
FROM employees
WHERE last_name LIKE '__a%';

--Câu 9: Nhân viên mà last_name chứa cả chữ 'a' và chữ 'e'
SELECT last_name
FROM employees
WHERE last_name LIKE '%a%'
AND last_name LIKE '%e%';

--Câu 10: Nhân viên làm 'Sales Representative' HOẶC 'Stock Clerk' và có mức lương KHÔNG PHẢI 2.500$, 3.500$, 7.000$
SELECT last_name, job_id, salary
FROM   employees
WHERE  job_id IN ('SA_REP', 'ST_CLERK')
  AND  salary NOT IN (2500, 3500, 7000);
  
--Câu 11: employee_id, last_name, lương tăng 15% (làm tròn hàng đơn vị), đặt alias 'New Salary'
SELECT employee_id, 
       last_name, 
       ROUND(salary * 1.15, 0) AS "New Salary"
FROM   employees;

--Câu 12: Tên nhân viên + chiều dài tên, bắt đầu bằng J/A/L/M, dùng INITCAP, sắp tăng dần theo tên
SELECT INITCAP(last_name) AS "Ten Nhan Vien",
       LENGTH(last_name)  AS "Chieu Dai"
FROM   employees
WHERE  SUBSTR(last_name, 1, 1) IN ('J', 'A', 'L', 'M')
ORDER BY last_name ASC;

--Câu 13: Thời gian làm việc tính theo tháng (MONTHS_BETWEEN), sắp tăng dần
SELECT last_name,
       TRUNC(MONTHS_BETWEEN(SYSDATE, hire_date)) AS "So Thang Lam Viec"
FROM   employees
ORDER BY MONTHS_BETWEEN(SYSDATE, hire_date) ASC;

--Câu 14: Định dạng kết quả: '<last_name> earns  monthly but wants <3xsalary>'
SELECT last_name || ' earns '
       || TO_CHAR(salary, '$99,999') || ' monthly but wants '
       || TO_CHAR(salary*3, '$99,999') AS "Dream Salaries"
FROM   employees;

--Câu 15: Tên nhân viên và mức hoa hồng; nếu không có hiển thị &#39;No commission&#39;
--Cách 1: Dùng CASE (an toàn nhất):
SELECT last_name,
       CASE WHEN commission_pct IS NULL THEN 'No commission'
            ELSE TO_CHAR(commission_pct)
       END AS "Commission"
FROM   employees;
--Cách 2: Dùng NVL kết hợp TO_CHAR:
SELECT last_name,
       NVL(TO_CHAR(commission_pct), 'No commission') AS "Commission"
FROM   employees;

--Câu 16: Hiển thị job_id và GRADE: AD_PRES=A, ST_MAN=B, IT_PROG=C, SA_REP=D, ST_CLERK=E, còn lại=0
--Cách 1: DECODE (ngắn gọn hơn):
SELECT job_id,
       DECODE(job_id,
              'AD_PRES', 'A',
              'ST_MAN',  'B',
              'IT_PROG', 'C',
              'SA_REP',  'D',
              'ST_CLERK','E',
              '0') AS "GRADE"
FROM   employees;
--Cách 2: CASE WHEN (rõ ràng hơn):
SELECT job_id,
       CASE job_id
            WHEN 'AD_PRES'  THEN 'A'
            WHEN 'ST_MAN'   THEN 'B'
            WHEN 'IT_PROG'  THEN 'C'
            WHEN 'SA_REP'   THEN 'D'
            WHEN 'ST_CLERK' THEN 'E'
            ELSE '0'
       END AS "GRADE"
FROM   employees;

--Câu 17: Tên nhân viên, mã phòng, tên phòng của nhân viên làm tại thành phố Toronto
SELECT e.last_name, e.department_id, d.department_name
FROM   employees e, departments d, locations l
WHERE  e.department_id = d.department_id
  AND  d.location_id   = l.location_id
  AND  UPPER(l.city)   = 'TORONTO';
  
--Câu 18: Mã NV, tên NV, mã quản lý, tên quản lý — Self Join
SELECT e.employee_id AS "Ma NV",
       e.last_name   AS "Ten NV",
       m.employee_id AS "Ma Quan Ly",
       m.last_name   AS "Ten Quan Ly"
FROM   employees e, employees m
WHERE  e.manager_id = m.employee_id;

--Câu 19: Danh sách nhân viên làm việc cùng phòng ban
SELECT e1.last_name AS "Nhan Vien 1",
       e2.last_name AS "Nhan Vien 2",
       e1.department_id AS "Phong Ban"
FROM   employees e1, employees e2
WHERE  e1.department_id = e2.department_id
  AND  e1.employee_id < e2.employee_id
ORDER BY e1.department_id, e1.last_name;

--Câu 20: Nhân viên được tuyển dụng SAU nhân viên 'Davies'
SELECT last_name, hire_date
FROM   employees
WHERE  hire_date > (SELECT hire_date
                    FROM   employees
                    WHERE  last_name = 'Davies');
                    
--Câu 21: Nhân viên được tuyển TRƯỚC người quản lý của họ
SELECT e.last_name AS "Nhan Vien",
       e.hire_date AS "Ngay Vao",
       m.last_name AS "Quan Ly",
       m.hire_date AS "Quan Ly Vao"
FROM   employees e, employees m
WHERE  e.manager_id = m.employee_id
  AND  e.hire_date < m.hire_date;

--Câu 22: Lương thấp nhất, cao nhất, trung bình, tổng lương của từng loại công việc
SELECT job_id,
       MIN(salary)          AS "Luong Thap Nhat",
       MAX(salary)          AS "Luong Cao Nhat",
       ROUND(AVG(salary),2) AS "Luong Trung Binh",
       SUM(salary)          AS "Tong Luong"
FROM   employees
GROUP BY job_id
ORDER BY job_id;

--Câu 23: Mã phòng, tên phòng, số lượng nhân viên từng phòng + thống kê tuyển dụng theo năm 1995–1998
--Phần A: Số lượng nhân viên từng phòng:
SELECT d.department_id,
       d.department_name,
       COUNT(e.employee_id) AS "So Nhan Vien"
FROM   departments d LEFT JOIN employees e
  ON   d.department_id = e.department_id
GROUP BY d.department_id, d.department_name
ORDER BY d.department_id;
--Phần B: Thống kê tuyển dụng theo từng năm:
SELECT COUNT(*) AS "Tong NV",
       SUM(CASE WHEN TO_CHAR(hire_date,'YYYY')='2005' THEN 1 ELSE 0 END) AS "Nam 2005",
       SUM(CASE WHEN TO_CHAR(hire_date,'YYYY')='2006' THEN 1 ELSE 0 END) AS "Nam 2006",
       SUM(CASE WHEN TO_CHAR(hire_date,'YYYY')='2007' THEN 1 ELSE 0 END) AS "Nam 2007",
       SUM(CASE WHEN TO_CHAR(hire_date,'YYYY')='2008' THEN 1 ELSE 0 END) AS "Nam 2008"
FROM   employees;

--Câu 25: Tên và hire_date của nhân viên làm việc cùng phòng với 'Zlotkey';
SELECT last_name, hire_date
FROM   employees
WHERE  department_id = (SELECT department_id
                        FROM   employees
                        WHERE  last_name = 'Zlotkey')
  AND  last_name <> 'Zlotkey';

--Câu 26: Tên, mã phòng, mã công việc của nhân viên thuộc phòng ở location_id = 1700
SELECT last_name, department_id, job_id
FROM   employees
WHERE  department_id IN (SELECT department_id
                         FROM   departments
                         WHERE  location_id = 1700);
                         
--Câu 27: Danh sách nhân viên có người quản lý tên 'King'
SELECT last_name, manager_id
FROM   employees
WHERE  manager_id IN (SELECT employee_id
                      FROM   employees
                      WHERE  last_name = 'King');
                      
--Câu 28: Nhân viên có salary > mức trung bình VÀ làm cùng phòng với nhân viên có last_name kết thúc bằng 'n'
SELECT last_name, salary, department_id
FROM   employees
WHERE  salary > (SELECT AVG(salary) FROM employees)
  AND  department_id IN (SELECT department_id
                         FROM   employees
                         WHERE  last_name LIKE '%n');

--Câu 29: Tên, mã phòng, mã công việc của nhân viên thuộc phòng ở thành phố có chữ 't'
--Cách 1: Correlated Subquery
SELECT department_id, department_name
FROM   departments d
WHERE  (SELECT COUNT(*) FROM employees e
        WHERE e.department_id = d.department_id) < 3
ORDER BY department_id;
--Cách 2: GROUP BY / HAVING:
SELECT d.department_id, d.department_name, COUNT(e.employee_id) AS "So NV"
FROM   departments d LEFT JOIN employees e
       ON d.department_id = e.department_id
GROUP BY d.department_id, d.department_name
HAVING COUNT(e.employee_id) < 3
ORDER BY d.department_id;
                                                
--Câu 30: Phòng ban đông nhân viên nhất và ít nhân viên nhất
SELECT department_id, COUNT(*) AS "So Nhan Vien", 'Dong nhat' AS "Loai"
FROM   employees
GROUP BY department_id
HAVING COUNT(*) = (SELECT MAX(COUNT(*)) FROM employees GROUP BY department_id)
UNION ALL
SELECT department_id, COUNT(*), 'It nhat'
FROM   employees
GROUP BY department_id
HAVING COUNT(*) = (SELECT MIN(COUNT(*)) FROM employees GROUP BY department_id);

--Câu 31: Nhân viên được tuyển vào ngày trong tuần có số lượng thuê đông nhất
SELECT last_name, hire_date,
       TO_CHAR(hire_date, 'Day') AS "Thu trong tuan"
FROM   employees
WHERE  TO_CHAR(hire_date, 'Day') IN (
       SELECT TO_CHAR(hire_date, 'Day')
       FROM   employees
       GROUP BY TO_CHAR(hire_date, 'Day')
       HAVING COUNT(*) = (
              SELECT MAX(COUNT(*))
              FROM   employees
              GROUP BY TO_CHAR(hire_date, 'Day')
       )
);
--Câu 32: 3 nhân viên có lương cao nhất
SELECT last_name, salary
FROM (
    SELECT last_name, salary
    FROM   employees
    ORDER BY salary DESC
)
WHERE ROWNUM <= 3;

--Câu 33: Nhân viên đang làm việc ở tiểu bang 'California'
SELECT e.last_name, e.department_id
FROM   employees e,
       departments d,
       locations l
WHERE  e.department_id = d.department_id
  AND  d.location_id = l.location_id
  AND  UPPER(l.state_province) = 'CALIFORNIA';
                 
--Câu 34: Cập nhật last_name của nhân viên có employee_id = 3 thành 'Drexler'
-- Kiem tra truoc
SELECT employee_id, last_name FROM employees WHERE employee_id = 3;

-- Cap nhat
UPDATE employees
SET    last_name = 'Drexler'
WHERE  employee_id = 3;

COMMIT;

-- Xac nhan sau khi cap nhat
SELECT employee_id, last_name FROM employees WHERE employee_id = 3;

--Câu 35: Nhân viên không phải là người quản lý (không có ai báo cáo cho họ)
SELECT e1.last_name, e1.salary, e1.department_id
FROM   employees e1
WHERE  e1.salary < (SELECT AVG(e2.salary)
                    FROM   employees e2
                    WHERE  e2.department_id = e1.department_id)
ORDER BY e1.department_id;
                           
--Câu 36: Tăng thêm 100$ cho nhân viên có salary < 900$                      
-- Kiem tra truoc: xem ai bi anh huong
SELECT employee_id, last_name, salary
FROM   employees
WHERE  salary < 3000;

-- Tang luong
UPDATE employees
SET    salary = salary + 100
WHERE  salary < 3000;

COMMIT; 

--Câu 37: Xóa phòng ban có department_id = 500
-- Kiem tra: co nhan vien trong phong 500 khong?
SELECT COUNT(*) FROM employees WHERE department_id = 100;

-- Truong hop 1: Phong trong (khong co nhan vien)
DELETE FROM departments WHERE department_id = 100;
COMMIT;

-- Truong hop 2: Phong co nhan vien -> phai xu ly truoc
UPDATE employees SET department_id = NULL WHERE department_id = 100;
DELETE FROM departments WHERE department_id = 100;
COMMIT;

--Câu 38: Xóa các phòng ban chưa có nhân viên nào
--Cách 1
-- Kiem tra truoc
SELECT department_id, department_name FROM departments
WHERE  department_id NOT IN (
       SELECT DISTINCT department_id FROM employees
       WHERE  department_id IS NOT NULL
);

-- Thuc hien xoa
DELETE FROM departments
WHERE  department_id NOT IN (
       SELECT DISTINCT department_id FROM employees
       WHERE  department_id IS NOT NULL
);
COMMIT;
--Cách 2
DELETE FROM departments d
WHERE NOT EXISTS (
      SELECT 1 FROM employees e
      WHERE e.department_id = d.department_id
);

COMMIT;

--Phần 3:
--Tạo bảng Danh mục Khoa
CREATE TABLE DMKHOA (
    MAKHOA CHAR(2) PRIMARY KEY,
    TENKHOA NVARCHAR2(30)
);

--Tạo bảng Danh mục Môn học
CREATE TABLE DMMH (
    MAMH CHAR(2) PRIMARY KEY,
    TENMH NVARCHAR2(35),
    SOTIET NUMBER(3)
);

--Tạo bảng Danh mục Sinh viên
CREATE TABLE DMSV (
    MASV CHAR(3) PRIMARY KEY,
    HOSV NVARCHAR2(30),
    TENSV NVARCHAR2(10),
    PHAI NVARCHAR2(3),
    NGAYSINH DATE,
    NOISINH NVARCHAR2(25),
    MAKH CHAR(2),
    HOCBONG NUMBER(10,0),
    CONSTRAINT FK_DMSV_DMKHOA FOREIGN KEY (MAKH) REFERENCES DMKHOA(MAKHOA)
);

--Tạo bảng Kết quả
CREATE TABLE KETQUA (
    MASV CHAR(3),
    MAMH CHAR(2),
    CONSTRAINT PK_KETQUA PRIMARY KEY (MASV, MAMH),
    CONSTRAINT FK_KETQUA_DMSV FOREIGN KEY (MASV) REFERENCES DMSV(MASV),
    CONSTRAINT FK_KETQUA_DMMH FOREIGN KEY (MAMH) REFERENCES DMMH(MAMH)
);
--Insert dữ liệu 
INSERT INTO DMKHOA (MAKHOA, TENKHOA) VALUES ('AV', N'Anh Văn');
INSERT INTO DMKHOA (MAKHOA, TENKHOA) VALUES ('TH', N'Tin Học');
INSERT INTO DMKHOA (MAKHOA, TENKHOA) VALUES ('VL', N'Vật Lý');
INSERT INTO DMKHOA (MAKHOA, TENKHOA) VALUES ('KT', N'Kế Toán');
INSERT INTO DMKHOA (MAKHOA, TENKHOA) VALUES ('QT', N'Quản Trị');
INSERT INTO DMKHOA (MAKHOA, TENKHOA) VALUES ('DL', N'Du Lịch');
INSERT INTO DMKHOA (MAKHOA, TENKHOA) VALUES ('NN', N'Ngôn Ngữ');
INSERT INTO DMKHOA (MAKHOA, TENKHOA) VALUES ('HH', N'Hóa Học');
INSERT INTO DMKHOA (MAKHOA, TENKHOA) VALUES ('SH', N'Sinh Học');
INSERT INTO DMKHOA (MAKHOA, TENKHOA) VALUES ('GD', N'Giáo Dục');
INSERT INTO DMKHOA (MAKHOA, TENKHOA) VALUES ('LY', N'Tâm Lý');
INSERT INTO DMKHOA (MAKHOA, TENKHOA) VALUES ('LU', N'Luật');
INSERT INTO DMKHOA (MAKHOA, TENKHOA) VALUES ('YK', N'Y Khoa');
INSERT INTO DMKHOA (MAKHOA, TENKHOA) VALUES ('DU', N'Dược');
INSERT INTO DMKHOA (MAKHOA, TENKHOA) VALUES ('CK', N'Cơ Khí');
INSERT INTO DMKHOA (MAKHOA, TENKHOA) VALUES ('DT', N'Điện Tử');
INSERT INTO DMKHOA (MAKHOA, TENKHOA) VALUES ('MK', N'Marketing');
INSERT INTO DMKHOA (MAKHOA, TENKHOA) VALUES ('TC', N'Tài Chính');
INSERT INTO DMKHOA (MAKHOA, TENKHOA) VALUES ('XD', N'Xây Dựng');
INSERT INTO DMKHOA (MAKHOA, TENKHOA) VALUES ('TR', N'Triết Học');

INSERT INTO DMMH (MAMH, TENMH, SOTIET) VALUES ('01', N'Cơ sở dữ liệu', 45);
INSERT INTO DMMH (MAMH, TENMH, SOTIET) VALUES ('02', N'Trí tuệ nhân tạo', 60);
INSERT INTO DMMH (MAMH, TENMH, SOTIET) VALUES ('03', N'Tiếng Anh cơ bản', 30);
INSERT INTO DMMH (MAMH, TENMH, SOTIET) VALUES ('04', N'Lập trình Java', 45);
INSERT INTO DMMH (MAMH, TENMH, SOTIET) VALUES ('05', N'Toán rời rạc', 45);
INSERT INTO DMMH (MAMH, TENMH, SOTIET) VALUES ('06', N'Mạng máy tính', 45);
INSERT INTO DMMH (MAMH, TENMH, SOTIET) VALUES ('07', N'Cấu trúc dữ liệu', 60);
INSERT INTO DMMH (MAMH, TENMH, SOTIET) VALUES ('08', N'Kinh tế vĩ mô', 30);
INSERT INTO DMMH (MAMH, TENMH, SOTIET) VALUES ('09', N'Kế toán doanh nghiệp', 45);
INSERT INTO DMMH (MAMH, TENMH, SOTIET) VALUES ('10', N'Marketing căn bản', 30);
INSERT INTO DMMH (MAMH, TENMH, SOTIET) VALUES ('11', N'Pháp luật đại cương', 30);
INSERT INTO DMMH (MAMH, TENMH, SOTIET) VALUES ('12', N'Tâm lý học', 30);
INSERT INTO DMMH (MAMH, TENMH, SOTIET) VALUES ('13', N'Hóa hữu cơ', 45);
INSERT INTO DMMH (MAMH, TENMH, SOTIET) VALUES ('14', N'Vật lý đại cương', 45);
INSERT INTO DMMH (MAMH, TENMH, SOTIET) VALUES ('15', N'Tiếng Anh chuyên ngành', 45);
INSERT INTO DMMH (MAMH, TENMH, SOTIET) VALUES ('16', N'Quản trị dự án', 45);
INSERT INTO DMMH (MAMH, TENMH, SOTIET) VALUES ('17', N'Lập trình Web', 60);
INSERT INTO DMMH (MAMH, TENMH, SOTIET) VALUES ('18', N'Hệ điều hành', 45);
INSERT INTO DMMH (MAMH, TENMH, SOTIET) VALUES ('19', N'Đại số tuyến tính', 45);
INSERT INTO DMMH (MAMH, TENMH, SOTIET) VALUES ('20', N'Kỹ năng mềm', 20);

INSERT INTO DMSV VALUES ('A01', N'Nguyễn Hải', N'An', N'Nam', TO_DATE('2003-01-15', 'YYYY-MM-DD'), N'TP.HCM', 'TH', 1000000);
INSERT INTO DMSV VALUES ('A02', N'Trần Văn', N'Bình', N'Nam', TO_DATE('2002-05-20', 'YYYY-MM-DD'), N'Hà Nội', 'TH', 0);
INSERT INTO DMSV VALUES ('A03', N'Lê Thị', N'Cúc', N'Nữ', TO_DATE('2003-11-02', 'YYYY-MM-DD'), N'Đà Nẵng', 'AV', 500000);
INSERT INTO DMSV VALUES ('A04', N'Phạm Minh', N'Dũng', N'Nam', TO_DATE('2001-12-30', 'YYYY-MM-DD'), N'Cần Thơ', 'VL', 0);
INSERT INTO DMSV VALUES ('A05', N'Hoàng Thị', N'Em', N'Nữ', TO_DATE('2004-02-14', 'YYYY-MM-DD'), N'Hải Phòng', 'KT', 800000);
INSERT INTO DMSV VALUES ('B01', N'Đỗ Quốc', N'Gia', N'Nam', TO_DATE('2003-06-21', 'YYYY-MM-DD'), N'Huế', 'QT', 0);
INSERT INTO DMSV VALUES ('B02', N'Bùi Mỹ', N'Hạnh', N'Nữ', TO_DATE('2002-08-10', 'YYYY-MM-DD'), N'Lâm Đồng', 'DL', 1200000);
INSERT INTO DMSV VALUES ('B03', N'Võ Thành', N'Ý', N'Nam', TO_DATE('2003-04-05', 'YYYY-MM-DD'), N'Nghệ An', 'NN', 0);
INSERT INTO DMSV VALUES ('B04', N'Phan Thu', N'Thảo', N'Nữ', TO_DATE('2004-10-12', 'YYYY-MM-DD'), N'Tiền Giang', 'HH', 600000);
INSERT INTO DMSV VALUES ('B05', N'Lý Huỳnh', N'Đông', N'Nam', TO_DATE('2002-01-25', 'YYYY-MM-DD'), N'Bến Tre', 'SH', 0);
INSERT INTO DMSV VALUES ('C01', N'Ngô Thanh', N'Tùng', N'Nam', TO_DATE('2003-03-30', 'YYYY-MM-DD'), N'Bình Dương', 'GD', 0);
INSERT INTO DMSV VALUES ('C02', N'Trương Mỹ', N'Nhân', N'Nữ', TO_DATE('2004-07-07', 'YYYY-MM-DD'), N'Vĩnh Long', 'LY', 2000000);
INSERT INTO DMSV VALUES ('C03', N'Dương Văn', N'Hùng', N'Nam', TO_DATE('2001-09-15', 'YYYY-MM-DD'), N'Quảng Nam', 'LU', 0);
INSERT INTO DMSV VALUES ('C04', N'Lương Thị', N'Mai', N'Nữ', TO_DATE('2003-12-12', 'YYYY-MM-DD'), N'Hà Tĩnh', 'YK', 1500000);
INSERT INTO DMSV VALUES ('C05', N'Đặng Minh', N'Quân', N'Nam', TO_DATE('2002-04-20', 'YYYY-MM-DD'), N'Đồng Nai', 'DU', 0);
INSERT INTO DMSV VALUES ('D01', N'Nguyễn Thanh', N'Sơn', N'Nam', TO_DATE('2003-05-18', 'YYYY-MM-DD'), N'Long An', 'CK', 0);
INSERT INTO DMSV VALUES ('D02', N'Trần Thu', N'Thủy', N'Nữ', TO_DATE('2004-08-25', 'YYYY-MM-DD'), N'Nam Định', 'DT', 900000);
INSERT INTO DMSV VALUES ('D03', N'Lê Minh', N'Tâm', N'Nam', TO_DATE('2003-02-11', 'YYYY-MM-DD'), N'Thanh Hóa', 'MK', 0);
INSERT INTO DMSV VALUES ('D04', N'Phạm Bảo', N'Trân', N'Nữ', TO_DATE('2002-06-30', 'YYYY-MM-DD'), N'Sóc Trăng', 'TC', 1100000);
INSERT INTO DMSV VALUES ('D05', N'Nguyễn Đức', N'Anh', N'Nam', TO_DATE('2004-09-01', 'YYYY-MM-DD'), N'TP.HCM', 'XD', 0);

INSERT INTO KETQUA VALUES ('A01', '01');
INSERT INTO KETQUA VALUES ('A01', '02');
INSERT INTO KETQUA VALUES ('A02', '01');
INSERT INTO KETQUA VALUES ('A02', '04');
INSERT INTO KETQUA VALUES ('A03', '03');
INSERT INTO KETQUA VALUES ('A03', '15');
INSERT INTO KETQUA VALUES ('A04', '14');
INSERT INTO KETQUA VALUES ('A05', '09');
INSERT INTO KETQUA VALUES ('B01', '16');
INSERT INTO KETQUA VALUES ('B02', '03');
INSERT INTO KETQUA VALUES ('B03', '11');
INSERT INTO KETQUA VALUES ('B04', '13');
INSERT INTO KETQUA VALUES ('B05', '05');
INSERT INTO KETQUA VALUES ('C01', '20');
INSERT INTO KETQUA VALUES ('C02', '12');
INSERT INTO KETQUA VALUES ('C03', '11');
INSERT INTO KETQUA VALUES ('C04', '13');
INSERT INTO KETQUA VALUES ('C05', '01');
INSERT INTO KETQUA VALUES ('D01', '14');
INSERT INTO KETQUA VALUES ('D02', '17');
INSERT INTO KETQUA VALUES ('D03', '10');
INSERT INTO KETQUA VALUES ('D04', '08');
INSERT INTO KETQUA VALUES ('D05', '19');

COMMIT;

--Bảng Phòng Ban
CREATE TABLE PHONGBAN (
    MAPHG INT PRIMARY KEY,
    TENPHG NVARCHAR2(50),
    TRPHG CHAR(9), 
    NG_NHANCHUC DATE
);

--Bảng Nhân Viên
CREATE TABLE NHANVIEN (
    MANV CHAR(9) PRIMARY KEY,
    HONV NVARCHAR2(15),
    TENLOT NVARCHAR2(15),
    TENNV NVARCHAR2(15),
    NGSINH DATE,
    DCHI NVARCHAR2(50),
    PHAI NVARCHAR2(3),
    LUONG NUMBER(10,2),
    MA_NQL CHAR(9),
    PHG INT,
    CONSTRAINT FK_NV_NQL FOREIGN KEY (MA_NQL) REFERENCES NHANVIEN(MANV),
    CONSTRAINT FK_NV_PHG FOREIGN KEY (PHG) REFERENCES PHONGBAN(MAPHG)
);
ALTER TABLE PHONGBAN ADD CONSTRAINT FK_PB_NV FOREIGN KEY (TRPHG) REFERENCES NHANVIEN(MANV);

--Bảng Địa điểm Phòng Ban
CREATE TABLE DIADIEM_PHG (
    MAPHG INT,
    DIADIEM NVARCHAR2(50),
    PRIMARY KEY (MAPHG, DIADIEM),
    CONSTRAINT FK_DD_PHG FOREIGN KEY (MAPHG) REFERENCES PHONGBAN(MAPHG)
);

--Bảng Đề Án
CREATE TABLE DEAN (
    MADA INT PRIMARY KEY,
    TENDA NVARCHAR2(50),
    DDIEM_DA NVARCHAR2(50),
    PHONG INT,
    CONSTRAINT FK_DA_PHG FOREIGN KEY (PHONG) REFERENCES PHONGBAN(MAPHG)
);

--Bảng Phân Công
CREATE TABLE PHANCONG (
    MA_NVIEN CHAR(9),
    SODA INT,
    THOIGIAN NUMBER(5,1),
    PRIMARY KEY (MA_NVIEN, SODA),
    CONSTRAINT FK_PC_NV FOREIGN KEY (MA_NVIEN) REFERENCES NHANVIEN(MANV),
    CONSTRAINT FK_PC_DA FOREIGN KEY (SODA) REFERENCES DEAN(MADA)
);

--Bảng Thân Nhân
CREATE TABLE THANNHAN (
    MA_NVIEN CHAR(9),
    TENTN NVARCHAR2(50),
    PHAI NVARCHAR2(3),
    NGSINH DATE,
    QUANHE NVARCHAR2(20),
    PRIMARY KEY (MA_NVIEN, TENTN),
    CONSTRAINT FK_TN_NV FOREIGN KEY (MA_NVIEN) REFERENCES NHANVIEN(MANV)
);

--Insert dữ liệu
-- Dữ liệu PHONGBAN
INSERT INTO PHONGBAN (MAPHG, TENPHG, NG_NHANCHUC) VALUES (1, N'Quản Lý', TO_DATE('2020-01-01', 'YYYY-MM-DD'));
INSERT INTO PHONGBAN (MAPHG, TENPHG, NG_NHANCHUC) VALUES (4, N'Điều Hành', TO_DATE('2021-05-10', 'YYYY-MM-DD'));
INSERT INTO PHONGBAN (MAPHG, TENPHG, NG_NHANCHUC) VALUES (5, N'Nghiên Cứu', TO_DATE('2019-03-22', 'YYYY-MM-DD'));

-- Dữ liệu NHANVIEN
INSERT INTO NHANVIEN VALUES ('001', N'Vương', N'Ngọc', N'Anh', TO_DATE('1985-01-01', 'YYYY-MM-DD'), N'Hà Nội', N'Nữ', 50000, NULL, 1);
INSERT INTO NHANVIEN VALUES ('002', N'Nguyễn', N'Thanh', N'Tùng', TO_DATE('1990-05-15', 'YYYY-MM-DD'), N'TP.HCM', N'Nam', 40000, '001', 5);
INSERT INTO NHANVIEN VALUES ('003', N'Lê', N'Thị', N'Hồng', TO_DATE('1992-10-20', 'YYYY-MM-DD'), N'Đà Nẵng', N'Nữ', 35000, '002', 5);
INSERT INTO NHANVIEN VALUES ('004', N'Trần', N'Hồng', N'Quang', TO_DATE('1988-03-12', 'YYYY-MM-DD'), N'Cần Thơ', N'Nam', 38000, '002', 4);
INSERT INTO NHANVIEN VALUES ('005', N'Phạm', N'Văn', N'Vinh', TO_DATE('1995-12-30', 'YYYY-MM-DD'), N'Hải Phòng', N'Nam', 30000, '004', 4);

-- Cập nhật Trưởng phòng cho PHONGBAN
UPDATE PHONGBAN SET TRPHG = '001' WHERE MAPHG = 1;
UPDATE PHONGBAN SET TRPHG = '004' WHERE MAPHG = 4;
UPDATE PHONGBAN SET TRPHG = '002' WHERE MAPHG = 5;

-- Dữ liệu DIADIEM_PHG
INSERT INTO DIADIEM_PHG VALUES (1, N'Hà Nội');
INSERT INTO DIADIEM_PHG VALUES (4, N'TP.HCM');
INSERT INTO DIADIEM_PHG VALUES (5, N'Vũng Tàu');
INSERT INTO DIADIEM_PHG VALUES (5, N'Nha Trang');
INSERT INTO DIADIEM_PHG VALUES (5, N'Đà Nẵng');

-- Dữ liệu DEAN
INSERT INTO DEAN VALUES (10, N'Số hóa hồ sơ', N'Hà Nội', 1);
INSERT INTO DEAN VALUES (20, N'Xây dựng App', N'TP.HCM', 4);
INSERT INTO DEAN VALUES (30, N'Nghiên cứu AI', N'Vũng Tàu', 5);
INSERT INTO DEAN VALUES (40, N'Hệ thống ERP', N'Đà Nẵng', 5);
INSERT INTO DEAN VALUES (50, N'Bảo mật mạng', N'TP.HCM', 4);

-- Dữ liệu PHANCONG
INSERT INTO PHANCONG VALUES ('002', 30, 20.0);
INSERT INTO PHANCONG VALUES ('002', 40, 15.0);
INSERT INTO PHANCONG VALUES ('003', 30, 30.5);
INSERT INTO PHANCONG VALUES ('004', 20, 10.0);
INSERT INTO PHANCONG VALUES ('005', 50, 40.0);

-- Dữ liệu THANNHAN
INSERT INTO THANNHAN VALUES ('002', N'Nguyễn Thế Anh', N'Nam', TO_DATE('2015-01-01', 'YYYY-MM-DD'), N'Con');
INSERT INTO THANNHAN VALUES ('003', N'Lê Minh', N'Nam', TO_DATE('2018-05-20', 'YYYY-MM-DD'), N'Con');
INSERT INTO THANNHAN VALUES ('001', N'Trần Hùng', N'Nam', TO_DATE('1980-11-11', 'YYYY-MM-DD'), N'Vợ/Chồng');
INSERT INTO THANNHAN VALUES ('004', N'Trần Thu Hà', N'Nữ', TO_DATE('2012-07-15', 'YYYY-MM-DD'), N'Con');
INSERT INTO THANNHAN VALUES ('002', N'Nguyễn Thị Mai', N'Nữ', TO_DATE('1992-03-03', 'YYYY-MM-DD'), N'Vợ/Chồng');

COMMIT;

