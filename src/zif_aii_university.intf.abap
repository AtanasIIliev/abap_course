INTERFACE zif_aii_university
  PUBLIC.

  TYPES lt_students TYPE TABLE OF zaii_student.

  "! <p class="shorttext synchronized"></p>
  "! <strong>Method Create University</strong>
  "! <br/>
  "! <em>Implement method <strong>zif_aii_university~create_university</strong> which receives name and location as input and returns a unique university id.
  "! <br/>
  "! @parameter iv_university_name      | <p class="shorttext synchronized"></p>
  "! @parameter iv_university_location  | <p class="shorttext synchronized"></p>
  "! @parameter rv_university_id        | <p class="shorttext synchronized"></p>
  METHODS create_university
    EXPORTING iv_university_name      TYPE zaiid_university_name
              iv_university_location  TYPE zaiid_location
    RETURNING VALUE(rv_university_id) TYPE zaiid_university_id
    RAISING cx_uuid_error
            zcx_aii_university.

  "! <p class="shorttext synchronized"></p>
  "! <strong>Method Add Student</strong>
  "! <br/>
  "! <em>Implement method <strong>zif_aii_university~add_student</strong> which receives student ID and university ID as input and adds a student to the university.
  "! <br/>
  "! @parameter iv_student_id    | <p class="shorttext synchronized"></p>
  "! @parameter iv_university_id | <p class="shorttext synchronized"></p>
  METHODS add_student
    IMPORTING iv_student_id    TYPE zaiid_student_id
              iv_university_id TYPE zaiid_university_id
    RAISING zcx_aii_university.
  "! <p class="shorttext synchronized"></p>
  "! <strong>Method Delete Student </strong>
  "! <br/>
  "! <em>Implement method <strong>zif_aii_university~delete_student</strong> which receives student ID as input and clear the corresponding university ID.
  "! <br/>
  "! @parameter iv_student_id    | <p class="shorttext synchronized"></p>
  METHODS delete_student
    IMPORTING iv_student_id TYPE zaiid_student_id
    RAISING   zcx_aii_university.

  "! <p class="shorttext synchronized"></p>
 "! <strong>Method List Students</strong>
 "! <br/>
 "! <em>Implement method <strong>zif_aii_university~list_student</strong> which list students in the specific university.
 "! <br/>
 "! @parameter iv_university_id  | <p class="shorttext synchronized"></p>
 "! @parameter et_students       | <p class="shorttext synchronized"></p>
 METHODS list_students
   IMPORTING iv_university_id TYPE zaiid_university_id
   EXPORTING et_students      TYPE lt_students
   RAISING   zcx_aii_university.

ENDINTERFACE.
