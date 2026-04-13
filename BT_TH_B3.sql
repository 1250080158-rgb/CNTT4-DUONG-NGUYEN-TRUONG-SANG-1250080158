CREATE TABLE COURSE (
    CourseNo NUMBER(8, 0) NOT NULL PRIMARY KEY,
    Description VARCHAR2(50) NULL,
    Cost NUMBER(9, 2) NULL,
    Prerequisite NUMBER(8, 0) NULL,
    CreatedBy VARCHAR2(30) NOT NULL,
    CreatedDate DATE NOT NULL,
    ModifiedBy VARCHAR2(30) NOT NULL,
    ModifiedDate DATE NOT NULL
);

CREATE TABLE INSTRUCTOR (
    InstructorID NUMBER(8) NOT NULL PRIMARY KEY,
    Salutation VARCHAR2(5) NULL,
    FirstName VARCHAR2(25) NULL,
    LastName VARCHAR2(25) NULL,
    Address VARCHAR2(50) NULL,
    Phone VARCHAR2(15) NULL,
    CreatedBy VARCHAR2(30) NOT NULL,
    CreatedDate DATE NOT NULL,
    ModifiedBy VARCHAR2(30) NOT NULL,
    ModifiedDate DATE NOT NULL
);

CREATE TABLE CLASS (
    ClassID NUMBER(8, 0) NOT NULL PRIMARY KEY,
    CourseNo NUMBER(8, 0) NOT NULL,
    ClassNo NUMBER(3) NOT NULL,
    StartDateTime DATE NULL,
    Location VARCHAR2(50) NULL,
    InstructorID NUMBER(8, 0) NOT NULL,
    Capacity NUMBER(3, 0) NULL,
    CreatedBy VARCHAR2(30) NOT NULL,
    CreatedDate DATE NOT NULL,
    ModifiedBy VARCHAR2(30) NOT NULL,
    ModifiedDate DATE NOT NULL
);

CREATE TABLE STUDENT (
    StudentID NUMBER(8, 0) NOT NULL PRIMARY KEY,
    Salutation VARCHAR2(5) NULL,
    FirstName VARCHAR2(25) NULL,
    LastName VARCHAR2(25) NOT NULL,
    Address VARCHAR2(50) NULL,
    Phone VARCHAR2(15) NULL,
    Employer VARCHAR2(50) NULL,
    RegistrationDate DATE NOT NULL,
    CreatedBy VARCHAR2(30) NOT NULL,
    CreatedDate DATE NOT NULL,
    ModifiedBy VARCHAR2(30) NOT NULL,
    ModifiedDate DATE NOT NULL
);

CREATE TABLE ENROLLMENT (
    StudentID NUMBER(8, 0) NOT NULL,
    ClassID NUMBER(8, 0) NOT NULL,
    EnrollDate DATE NOT NULL,
    FinalGrade NUMBER(3, 0) NULL,
    RegistrationDate DATE NOT NULL,
    CreatedBy VARCHAR2(30) NOT NULL,
    CreatedDate DATE NOT NULL,
    ModifiedBy VARCHAR2(30) NOT NULL,
    ModifiedDate DATE NOT NULL,
    PRIMARY KEY (StudentID, ClassID)
);

CREATE TABLE GRADE (
    StudentID NUMBER(8) NOT NULL,
    ClassID NUMBER(8) NOT NULL,
    Grade NUMBER(3) NOT NULL,
    Comments VARCHAR2(2000) NULL,
    CreatedBy VARCHAR2(30) NOT NULL,
    CreatedDate DATE NOT NULL,
    ModifiedBy VARCHAR2(30) NOT NULL,
    ModifiedDate DATE NOT NULL
);


INSERT INTO COURSE VALUES (101, 'Introduction to Programming', 1500.00, NULL, 'admin', TO_DATE('2025-01-01', 'YYYY-MM-DD'), 'admin', TO_DATE('2025-01-01', 'YYYY-MM-DD'));
INSERT INTO COURSE VALUES (102, 'Data Structures', 1800.00, 101, 'admin', TO_DATE('2025-01-02', 'YYYY-MM-DD'), 'admin', TO_DATE('2025-01-02', 'YYYY-MM-DD'));
INSERT INTO COURSE VALUES (103, 'Database Systems', 2000.00, 102, 'admin', TO_DATE('2025-01-03', 'YYYY-MM-DD'), 'admin', TO_DATE('2025-01-03', 'YYYY-MM-DD'));
INSERT INTO COURSE VALUES (104, 'Web Development', 1700.00, 101, 'admin', TO_DATE('2025-01-04', 'YYYY-MM-DD'), 'admin', TO_DATE('2025-01-04', 'YYYY-MM-DD'));

INSERT INTO INSTRUCTOR VALUES (1, 'Dr.', 'John', 'Smith', '123 University Ave', '0901234567', 'admin', TO_DATE('2025-01-01', 'YYYY-MM-DD'), 'admin', TO_DATE('2025-01-01', 'YYYY-MM-DD'));
INSERT INTO INSTRUCTOR VALUES (2, 'Ms.', 'Jane', 'Doe', '456 College Blvd', '0902345678', 'admin', TO_DATE('2025-01-02', 'YYYY-MM-DD'), 'admin', TO_DATE('2025-01-02', 'YYYY-MM-DD'));
INSERT INTO INSTRUCTOR VALUES (3, 'Mr.', 'Robert', 'Brown', '789 Tech Lane', '0903456789', 'admin', TO_DATE('2025-01-03', 'YYYY-MM-DD'), 'admin', TO_DATE('2025-01-03', 'YYYY-MM-DD'));

INSERT INTO CLASS VALUES (1001, 101, 1, TO_DATE('2026-09-01 08:00', 'YYYY-MM-DD HH24:MI'), 'Room A101', 1, 30, 'admin', TO_DATE('2026-01-10', 'YYYY-MM-DD'), 'admin', TO_DATE('2026-01-10', 'YYYY-MM-DD'));
INSERT INTO CLASS VALUES (1002, 102, 1, TO_DATE('2026-09-02 10:00', 'YYYY-MM-DD HH24:MI'), 'Room B202', 2, 25, 'admin', TO_DATE('2026-01-11', 'YYYY-MM-DD'), 'admin', TO_DATE('2026-01-11', 'YYYY-MM-DD'));
INSERT INTO CLASS VALUES (1003, 103, 2, TO_DATE('2026-09-03 13:00', 'YYYY-MM-DD HH24:MI'), 'Lab C303', 3, 20, 'admin', TO_DATE('2026-01-12', 'YYYY-MM-DD'), 'admin', TO_DATE('2026-01-12', 'YYYY-MM-DD'));
INSERT INTO CLASS VALUES (1004, 104, 1, TO_DATE('2026-09-04 15:00', 'YYYY-MM-DD HH24:MI'), 'Lab D404', 1, 20, 'admin', TO_DATE('2026-01-13', 'YYYY-MM-DD'), 'admin', TO_DATE('2026-01-13', 'YYYY-MM-DD'));

INSERT INTO STUDENT VALUES (2026001, 'Mr.', 'Tuan', 'Nguyen', '10 Le Loi, Q1', '0911222333', 'ABC Corp', TO_DATE('2026-08-15', 'YYYY-MM-DD'), 'admin', TO_DATE('2026-08-15', 'YYYY-MM-DD'), 'admin', TO_DATE('2026-08-15', 'YYYY-MM-DD'));
INSERT INTO STUDENT VALUES (2026002, 'Ms.', 'Hoa', 'Tran', '20 Nguyen Hue, Q1', '0922333444', NULL, TO_DATE('2026-08-16', 'YYYY-MM-DD'), 'admin', TO_DATE('2026-08-16', 'YYYY-MM-DD'), 'admin', TO_DATE('2026-08-16', 'YYYY-MM-DD'));
INSERT INTO STUDENT VALUES (2026003, 'Mr.', 'Hai', 'Le', '30 Tran Hung Dao, Q5', '0933444555', 'XYZ Inc', TO_DATE('2026-08-17', 'YYYY-MM-DD'), 'admin', TO_DATE('2026-08-17', 'YYYY-MM-DD'), 'admin', TO_DATE('2026-08-17', 'YYYY-MM-DD'));
INSERT INTO STUDENT VALUES (2026004, 'Ms.', 'Lan', 'Pham', '40 Vo Van Tan, Q3', '0944555666', NULL, TO_DATE('2026-08-18', 'YYYY-MM-DD'), 'admin', TO_DATE('2026-08-18', 'YYYY-MM-DD'), 'admin', TO_DATE('2026-08-18', 'YYYY-MM-DD'));

INSERT INTO ENROLLMENT VALUES (2026001, 1001, TO_DATE('2026-08-20', 'YYYY-MM-DD'), 85, TO_DATE('2026-08-20', 'YYYY-MM-DD'), 'admin', TO_DATE('2026-08-20', 'YYYY-MM-DD'), 'admin', TO_DATE('2026-08-20', 'YYYY-MM-DD'));
INSERT INTO ENROLLMENT VALUES (2026001, 1002, TO_DATE('2026-08-20', 'YYYY-MM-DD'), 78, TO_DATE('2026-08-20', 'YYYY-MM-DD'), 'admin', TO_DATE('2026-08-20', 'YYYY-MM-DD'), 'admin', TO_DATE('2026-08-20', 'YYYY-MM-DD'));
INSERT INTO ENROLLMENT VALUES (2026002, 1001, TO_DATE('2026-08-21', 'YYYY-MM-DD'), 92, TO_DATE('2026-08-21', 'YYYY-MM-DD'), 'admin', TO_DATE('2026-08-21', 'YYYY-MM-DD'), 'admin', TO_DATE('2026-08-21', 'YYYY-MM-DD'));
INSERT INTO ENROLLMENT VALUES (2026003, 1003, TO_DATE('2026-08-22', 'YYYY-MM-DD'), 65, TO_DATE('2026-08-22', 'YYYY-MM-DD'), 'admin', TO_DATE('2026-08-22', 'YYYY-MM-DD'), 'admin', TO_DATE('2026-08-22', 'YYYY-MM-DD'));
INSERT INTO ENROLLMENT VALUES (2026004, 1004, TO_DATE('2026-08-23', 'YYYY-MM-DD'), NULL, TO_DATE('2026-08-23', 'YYYY-MM-DD'), 'admin', TO_DATE('2026-08-23', 'YYYY-MM-DD'), 'admin', TO_DATE('2026-08-23', 'YYYY-MM-DD'));

INSERT INTO GRADE VALUES (2026001, 1001, 85, 'Good performance', 'admin', TO_DATE('2026-12-15', 'YYYY-MM-DD'), 'admin', TO_DATE('2026-12-15', 'YYYY-MM-DD'));
INSERT INTO GRADE VALUES (2026001, 1002, 78, 'Satisfactory', 'admin', TO_DATE('2026-12-16', 'YYYY-MM-DD'), 'admin', TO_DATE('2026-12-16', 'YYYY-MM-DD'));
INSERT INTO GRADE VALUES (2026002, 1001, 92, 'Excellent work', 'admin', TO_DATE('2026-12-15', 'YYYY-MM-DD'), 'admin', TO_DATE('2026-12-15', 'YYYY-MM-DD'));
INSERT INTO GRADE VALUES (2026003, 1003, 65, 'Needs improvement', 'admin', TO_DATE('2026-12-17', 'YYYY-MM-DD'), 'admin', TO_DATE('2026-12-17', 'YYYY-MM-DD'));

-- Câu 1a
CREATE TABLE Cau1 (
    ID NUMBER,
    NAME VARCHAR2(20)
);

-- Câu 1b
CREATE SEQUENCE Cau1Seq
    START WITH 5
    INCREMENT BY 5;
-- Câu 1c-1j
SET SERVEROUTPUT ON;

DECLARE
    v_name  VARCHAR2(50);
    v_id    NUMBER;
BEGIN
    -- [d] Them sinh vien dang ki nhieu mon nhat
    SELECT firstname || ' ' || lastname
    INTO   v_name
    FROM   student
    WHERE  studentid = (
        SELECT studentid FROM enrollment
        GROUP BY studentid
        HAVING COUNT(*) = (SELECT MAX(COUNT(*)) FROM enrollment GROUP BY studentid)
        FETCH FIRST 1 ROWS ONLY
    );

    INSERT INTO Cau1 (ID, NAME)
    VALUES (Cau1Seq.NEXTVAL, v_name);
    SAVEPOINT sp_a;   

    -- [e] Them sinh vien dang ki it mon nhat
    SELECT firstname || ' ' || lastname
    INTO   v_name
    FROM   student
    WHERE  studentid = (
        SELECT studentid FROM enrollment
        GROUP BY studentid
        HAVING COUNT(*) = (SELECT MIN(COUNT(*)) FROM enrollment GROUP BY studentid)
        FETCH FIRST 1 ROWS ONLY
    );

    INSERT INTO Cau1 (ID, NAME)
    VALUES (Cau1Seq.NEXTVAL, v_name);
    SAVEPOINT sp_b;    -- Savepoint B

    -- [f] Them giao vien day nhieu lop nhat
    SELECT i.firstname || ' ' || i.lastname
    INTO   v_name
    FROM   instructor i
    WHERE  i.instructorid = (
        SELECT instructorid FROM class
        GROUP BY instructorid
        HAVING COUNT(*) = (SELECT MAX(COUNT(*)) FROM class GROUP BY instructorid)
        FETCH FIRST 1 ROWS ONLY
    );

    INSERT INTO Cau1 (ID, NAME)
    VALUES (Cau1Seq.NEXTVAL, v_name);
    SAVEPOINT sp_c;    -- Savepoint C

    -- [g] SELECT INTO: lay ID cua giao vien vua them vao bien v_id
    SELECT ID INTO v_id
    FROM   Cau1
    WHERE  NAME = v_name;

    DBMS_OUTPUT.PUT_LINE('ID giao vien nhieu lop: ' || v_id);

    -- [h] Rollback giao vien nhieu lop (ve Savepoint B)
    ROLLBACK TO sp_b;

    -- [i] Them giao vien it lop nhat, dung v_id da luu
    SELECT i.firstname || ' ' || i.lastname
    INTO   v_name
    FROM   instructor i
    WHERE  i.instructorid = (
        SELECT instructorid FROM class
        GROUP BY instructorid
        HAVING COUNT(*) = (SELECT MIN(COUNT(*)) FROM class GROUP BY instructorid)
        FETCH FIRST 1 ROWS ONLY
    );

    INSERT INTO Cau1 (ID, NAME)
    VALUES (v_id, v_name);  -- Dung v_id (khong phai sequence)

    -- [j] Them lai giao vien nhieu lop, dung sequence
    SELECT i.firstname || ' ' || i.lastname
    INTO   v_name
    FROM   instructor i
    WHERE  i.instructorid = (
        SELECT instructorid FROM class
        GROUP BY instructorid
        HAVING COUNT(*) = (SELECT MAX(COUNT(*)) FROM class GROUP BY instructorid)
        FETCH FIRST 1 ROWS ONLY
    );

    INSERT INTO Cau1 (ID, NAME)
    VALUES (Cau1Seq.NEXTVAL, v_name);  -- Dung sequence

    COMMIT;
    DBMS_OUTPUT.PUT_LINE('Hoan tat! Kiem tra: SELECT * FROM Cau1;');

EXCEPTION
    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('Loi: Khong tim thay du lieu!');
        ROLLBACK;
        WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Loi: ' || SQLERRM);
        ROLLBACK;
END;
/

--Câu 2
SET SERVEROUTPUT ON;

DECLARE
    v_sid     NUMBER        := &ma_sinh_vien;
    v_fname   VARCHAR2(25)  := '&ho_sinh_vien';
    v_lname   VARCHAR2(25)  := '&ten_sinh_vien';
    v_addr    VARCHAR2(50)  := '&dia_chi';
    v_found   VARCHAR2(50);
    v_classes NUMBER;
BEGIN
    -- Thu tim sinh vien theo ma vua nhap
    SELECT firstname || ' ' || lastname
    INTO   v_found
    FROM   student
    WHERE  studentid = v_sid;

    -- Neu tim thay: dem so lop dang hoc
    SELECT COUNT(*)
    INTO   v_classes
    FROM   enrollment
    WHERE  studentid = v_sid;

    DBMS_OUTPUT.PUT_LINE('Ho ten: ' || v_found);
    DBMS_OUTPUT.PUT_LINE('So lop dang hoc: ' || v_classes);

EXCEPTION
    WHEN NO_DATA_FOUND THEN
        -- Sinh vien chua ton tai: them moi
        DBMS_OUTPUT.PUT_LINE('Sinh vien chua ton tai. Dang them moi...');
        INSERT INTO student (studentid, firstname, lastname, address, 
                             registrationdate, createdby, createddate, 
                             modifiedby, modifieddate)
        VALUES (v_sid, v_fname, v_lname, v_addr, 
                SYSDATE, USER, SYSDATE, USER, SYSDATE);
        
        COMMIT;
        DBMS_OUTPUT.PUT_LINE('Da them sinh vien moi: ' || v_fname || ' ' || v_lname);
END;
/

--Bài 2
--Câu 1
SET SERVEROUTPUT ON;

DECLARE
    v_instructor_id  NUMBER := &ma_giao_vien;
    v_so_lop         NUMBER;
BEGIN
    -- Dem so lop giao vien dang day
    SELECT COUNT(*)
    INTO   v_so_lop
    FROM   class
    WHERE  instructorid = v_instructor_id;

    -- Phan nhanh theo ket qua
    IF v_so_lop >= 5 THEN
        DBMS_OUTPUT.PUT_LINE('Giao vien nay nen nghi ngoi!');
    ELSE
        DBMS_OUTPUT.PUT_LINE('So lop giao vien dang day: ' || v_so_lop);
    END IF;

EXCEPTION
    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('Khong tim thay giao vien co ma: ' || v_instructor_id);
END;
/

--Câu 2
SET SERVEROUTPUT ON;

DECLARE
    v_sid    NUMBER := &ma_sinh_vien;
    v_cid    NUMBER := &ma_lop;
    v_score  NUMBER;
    v_grade  VARCHAR2(2);
    v_check  NUMBER;
BEGIN
    -- Kiem tra sinh vien ton tai
    SELECT COUNT(*) INTO v_check
    FROM   student WHERE studentid = v_sid;

    IF v_check = 0 THEN
        DBMS_OUTPUT.PUT_LINE('Loi: Ma sinh vien ' || v_sid || ' khong ton tai!');
        RETURN;
    END IF;

    -- Kiem tra lop ton tai
    SELECT COUNT(*) INTO v_check
    FROM   class WHERE classid = v_cid;

    IF v_check = 0 THEN
        DBMS_OUTPUT.PUT_LINE('Loi: Ma lop ' || v_cid || ' khong ton tai!');
        RETURN;
    END IF;

    -- Lay diem cua sinh vien trong lop
    SELECT finalgrade
    INTO   v_score
    FROM   enrollment
    WHERE  studentid = v_sid AND classid = v_cid;

    -- Quy doi diem so sang diem chu bang CASE
    CASE
        WHEN v_score >= 90 THEN v_grade := 'A';
        WHEN v_score >= 80 THEN v_grade := 'B';
        WHEN v_score >= 70 THEN v_grade := 'C';
        WHEN v_score >= 50 THEN v_grade := 'D';
        ELSE v_grade := 'F';
    END CASE;

    DBMS_OUTPUT.PUT_LINE('Diem so: ' || v_score || ' -> Diem chu: ' || v_grade);

EXCEPTION
    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('Sinh vien chua dang ky lop nay hoac chua co diem!');
END;
/

--Bài 3
SET SERVEROUTPUT ON;

DECLARE
    -- Cursor 1: Duyet tung mon hoc
    CURSOR cur_course IS
        SELECT courseno, description
        FROM   course
        ORDER  BY courseno;

    -- Cursor 2: Lay lop hoc cua mot mon (co doi so)
    CURSOR cur_class (p_courseno NUMBER) IS
        SELECT c.classno,
               COUNT(e.studentid) AS so_sv
        FROM   class c
        LEFT   JOIN enrollment e ON c.classid = e.classid
        WHERE  c.courseno = p_courseno
        GROUP  BY c.classno
        ORDER  BY c.classno;

    v_courseno  course.courseno%TYPE;
    v_desc      course.description%TYPE;
    v_classno   class.classno%TYPE;
    v_count     NUMBER;

BEGIN
    -- Duyet cursor ngoai: tung mon hoc
    OPEN cur_course;
    LOOP
        FETCH cur_course INTO v_courseno, v_desc;
        EXIT WHEN cur_course%NOTFOUND;

        -- In ten mon hoc
        DBMS_OUTPUT.PUT_LINE(v_courseno || ' ' || v_desc);

        -- Mo cursor trong voi doi so la ma mon hoc hien tai
        OPEN cur_class(v_courseno);
        LOOP
            FETCH cur_class INTO v_classno, v_count;
            EXIT WHEN cur_class%NOTFOUND;

            DBMS_OUTPUT.PUT_LINE('Lop: ' || v_classno || 
                                 ' co so luong sinh vien dang ki: ' || v_count);
        END LOOP;
        CLOSE cur_class;

    END LOOP;
    CLOSE cur_course;

EXCEPTION
    WHEN OTHERS THEN
        IF cur_course%ISOPEN THEN CLOSE cur_course; END IF;
        IF cur_class%ISOPEN  THEN CLOSE cur_class;  END IF;
        DBMS_OUTPUT.PUT_LINE('Co loi xay ra: ' || SQLERRM);
END;
/

--Bài 4
--Câu 1.a
CREATE OR REPLACE PROCEDURE find_sname
    (i_student_id  IN  student.studentid%TYPE,
     o_first_name  OUT student.firstname%TYPE,
     o_last_name   OUT student.lastname%TYPE)
IS
BEGIN
    SELECT firstname, lastname
    INTO   o_first_name, o_last_name
    FROM   student
    WHERE  studentid = i_student_id;

EXCEPTION
    WHEN NO_DATA_FOUND THEN
        o_first_name := NULL;
        o_last_name  := NULL;
        DBMS_OUTPUT.PUT_LINE('Khong tim thay sinh vien ID: ' || i_student_id);
END find_sname;
/

--Câu 1.b
CREATE OR REPLACE PROCEDURE print_student_name
    (i_student_id  IN  student.studentid%TYPE)
IS
    v_first  student.firstname%TYPE;
    v_last   student.lastname%TYPE;
BEGIN
    -- Goi thu tuc find_sname da co san
    find_sname(i_student_id, v_first, v_last);

    IF v_first IS NOT NULL OR v_last IS NOT NULL THEN
        DBMS_OUTPUT.PUT_LINE('Ho ten sinh vien: ' || v_first || ' ' || v_last);
    END IF;
END print_student_name;
/

-- Goi thu tuc de kiem tra:
BEGIN
    print_student_name(101);
END;
/

--Câu 2
CREATE OR REPLACE PROCEDURE Discount
IS
BEGIN
    FOR rec IN (
        SELECT c.courseno, c.description, c.cost
        FROM   course c
        WHERE  (SELECT COUNT(*) FROM enrollment e
                JOIN class cl ON e.classid = cl.classid
                WHERE cl.courseno = c.courseno) > 15
    ) LOOP
        -- Giam gia 5%
        UPDATE course
        SET    cost = cost * 0.95
        WHERE  courseno = rec.courseno;

        DBMS_OUTPUT.PUT_LINE('Da giam gia mon hoc: ' || rec.description
                             || ' | Gia cu: ' || rec.cost
                             || ' | Gia moi: ' || ROUND(rec.cost * 0.95, 2));
    END LOOP;

    COMMIT;
    DBMS_OUTPUT.PUT_LINE('Hoan tat giam gia.');
EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK;
        DBMS_OUTPUT.PUT_LINE('Loi: ' || SQLERRM);
END Discount;
/
-- Goi thu tuc:
BEGIN Discount; END;
/

--Câu 3
CREATE OR REPLACE FUNCTION Total_cost_for_student
    (p_student_id  IN  student.studentid%TYPE)
RETURN NUMBER
IS
    v_total  NUMBER;
    v_check  NUMBER;
BEGIN
    -- Kiem tra sinh vien co ton tai khong
    SELECT COUNT(*) INTO v_check
    FROM student WHERE studentid = p_student_id;

    IF v_check = 0 THEN
        RETURN NULL;  -- Sinh vien khong ton tai
    END IF;

    -- Tinh tong chi phi: sum(cost cua tung mon da dang ky)
    SELECT NVL(SUM(co.cost), 0)
    INTO v_total
    FROM enrollment e
    JOIN class    cl ON e.classid = cl.classid
    JOIN course   co ON cl.courseno = co.courseno
    WHERE e.studentid = p_student_id;

    RETURN v_total;

EXCEPTION
    WHEN OTHERS THEN
        RETURN NULL;
END Total_cost_for_student;
/

-- Goi ham de kiem tra:
SELECT Total_cost_for_student(101) AS "Tong chi phi" FROM DUAL;

-- Hoac trong PL/SQL:
BEGIN
    DBMS_OUTPUT.PUT_LINE('Tong chi phi: ' || Total_cost_for_student(101));
END;
/
--Bài 5
--Câu 1
-- Trigger mẫu cho bảng COURSE:
CREATE OR REPLACE TRIGGER trg_course_audit
    BEFORE INSERT OR UPDATE ON course
    FOR EACH ROW
BEGIN
    IF INSERTING THEN
        :NEW.created_by   := USER;
        :NEW.created_date := SYSDATE;
    END IF;

    -- Luon cap nhat modified (ca khi INSERT lan UPDATE)
    :NEW.modified_by   := USER;
    :NEW.modified_date := SYSDATE;
END trg_course_audit;
/

-- Trigger tương tự cho bảng CLASS:
CREATE OR REPLACE TRIGGER trg_class_audit
    BEFORE INSERT OR UPDATE ON class
    FOR EACH ROW
BEGIN
    IF INSERTING THEN
        :NEW.created_by   := USER;
        :NEW.created_date := SYSDATE;
    END IF;

    :NEW.modified_by   := USER;
    :NEW.modified_date := SYSDATE;
END trg_class_audit;
/

-- STUDENT
CREATE OR REPLACE TRIGGER trg_student_audit
    BEFORE INSERT OR UPDATE ON student FOR EACH ROW
BEGIN
    IF INSERTING THEN :NEW.created_by:=USER; :NEW.created_date:=SYSDATE; END IF;
    :NEW.modified_by:=USER; :NEW.modified_date:=SYSDATE;
END; /

-- ENROLLMENT
CREATE OR REPLACE TRIGGER trg_enrollment_audit
    BEFORE INSERT OR UPDATE ON enrollment FOR EACH ROW
BEGIN
    IF INSERTING THEN :NEW.created_by:=USER; :NEW.created_date:=SYSDATE; END IF;
    :NEW.modified_by:=USER; :NEW.modified_date:=SYSDATE;
END; /

-- INSTRUCTOR
CREATE OR REPLACE TRIGGER trg_instructor_audit
    BEFORE INSERT OR UPDATE ON instructor FOR EACH ROW
BEGIN
    IF INSERTING THEN :NEW.created_by:=USER; :NEW.created_date:=SYSDATE; END IF;
    :NEW.modified_by:=USER; :NEW.modified_date:=SYSDATE;
END; /

-- GRADE
CREATE OR REPLACE TRIGGER trg_grade_audit
    BEFORE INSERT OR UPDATE ON grade FOR EACH ROW
BEGIN
    IF INSERTING THEN :NEW.created_by:=USER; :NEW.created_date:=SYSDATE; END IF;
    :NEW.modified_by:=USER; :NEW.modified_date:=SYSDATE;
END; /

--Câu 2
CREATE OR REPLACE TRIGGER trg_max_enrollment
    BEFORE INSERT ON enrollment
    FOR EACH ROW
DECLARE
    v_so_lop  NUMBER;
BEGIN
    -- Dem so lop sinh vien nay dang dang ky
    SELECT COUNT(*)
    INTO v_so_lop
    FROM enrollment
    WHERE studentid = :NEW.studentid;

    -- Neu da co 3 lop tro len thi tu choi
    IF v_so_lop >= 3 THEN
        RAISE_APPLICATION_ERROR(
            -20001,
            'Sinh vien ' || :NEW.studentid || 
            ' da dang ky du 3 lop! Khong the dang ky them.'
        );
    END IF;
END trg_max_enrollment;
/

-- Kiem tra trigger:
-- Gia su sinh vien 101 da co 3 lop, thu them lop thu 4:
INSERT INTO enrollment (studentid, classid, enrolldate, createdby, 
    createddate, modifiedby, modifieddate)
VALUES (101, 999, SYSDATE, USER, SYSDATE, USER, SYSDATE);