INTERFACE zif_aii_student
  PUBLIC .

  "! <p class="shorttext synchronized"></p>
  "! <strong>Method Create Student</strong>
  "! <br/>
  "! <em>Implement method <strong>zif_aii_university~create_student</strong> which receives name, age, major and email as input and returns a unique student id.
  "! <br/>
  "! @parameter iv_student_name      | <p class="shorttext synchronized"></p>
  "! @parameter iv_student_age       | <p class="shorttext synchronized"></p>
  "! @parameter iv_major             | <p class="shorttext synchronized"></p>
  "! @parameter iv_email             | <p class="shorttext synchronized"></p>
  "! @parameter rv_student_id        | <p class="shorttext synchronized"></p>
  METHODS create_student
    EXPORTING iv_student_name         TYPE zaiid_student_name
              iv_student_age          TYPE zaiid_student_age
              iv_major                TYPE zaiid_student_major
              iv_email                TYPE zaiid_student_email
    RETURNING VALUE(rv_student_id)    TYPE zaiid_student_id
    RAISING cx_uuid_error
            zcx_aii_student.

  "! <p class="shorttext synchronized"></p>
  "! <strong>Method Get Student</strong>
  "! <br/>
  "! <em>Implement method <strong>zif_aii_university~get_student</strong> which receives student ID and returns all other information about it.
  "! <br/>
  "! @parameter iv_student_id        | <p class="shorttext synchronized"></p>
  "! @parameter rs_student           | <p class="shorttext synchronized"></p>
  METHODS get_student
    IMPORTING       iv_student_id     TYPE zaiid_student_id
    RETURNING VALUE(rs_student)       TYPE zaii_student
    RAISING         zcx_aii_student.

  "! <p class="shorttext synchronized"></p>
  "! <strong>Method Update Student</strong>
  "! <br/>
  "! <em>Implement method <strong>zif_aii_university~update_student</strong> which receives id, name, age, major and email as input and updates the details of an existing student.
  "! <br/>
  "! @parameter iv_student_id        | <p class="shorttext synchronized"></p>
  "! @parameter iv_student_name      | <p class="shorttext synchronized"></p>
  "! @parameter iv_student_age       | <p class="shorttext synchronized"></p>
  "! @parameter iv_major             | <p class="shorttext synchronized"></p>
  "! @parameter iv_email             | <p class="shorttext synchronized"></p>
  METHODS update_student
    IMPORTING iv_student_id   TYPE zaiid_student_id
              iv_student_name TYPE zaiid_student_name
              iv_student_age  TYPE zaiid_student_age
              iv_major        TYPE zaiid_student_major
              iv_email        TYPE zaiid_student_email
    RAISING   zcx_aii_student.

ENDINTERFACE.
