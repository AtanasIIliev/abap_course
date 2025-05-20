CLASS zcl_aii_student DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    INTERFACES zif_aii_student.

    DATA:
      lv_student_id     TYPE zaiid_student_id,
      lv_university_id  TYPE zaiid_student_id,
      lv_student_name   TYPE zaiid_student_name,
      lv_student_age    TYPE zaiid_student_age,
      lv_major          TYPE zaiid_student_major,
      lv_email          TYPE zaiid_student_email.

  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS ZCL_AII_STUDENT IMPLEMENTATION.


  METHOD zif_aii_student~create_student.
    " The other way is to declare it in the public section
    " Create a new student structure with a unique ID and input values for name, age, major and email
    DATA(ls_student) = VALUE zaii_student(
                               student_id = cl_system_uuid=>create_uuid_x16_static(  )
                               name       = iv_student_name
                               age        = iv_student_age
                               major      = iv_major
                               email      = iv_email ).

    " Insert the newly created student record into the database table
    INSERT zaii_student FROM @ls_student.

    " Check if the insert operation failed
    IF sy-subrc <> 0.
      RAISE EXCEPTION TYPE zcx_aii_student
        EXPORTING
          textid        = zcx_aii_student=>student_creation_insert_err
          lv_student_id = ls_student-student_id.
    ENDIF.

    " Commit the changes to the database and ensure all work is finalized
    COMMIT WORK AND WAIT.

    " Check if the commit operation failed
    IF sy-subrc <> 0.
      RAISE EXCEPTION TYPE zcx_aii_student
        EXPORTING
          textid = zcx_aii_student=>student_commit_error.
    ENDIF.

    " Return the generated university ID as the output of the method
    rv_student_id = ls_student-student_id.

  ENDMETHOD.


  METHOD zif_aii_student~get_student.

    " Check if the student exists in the database
    SELECT SINGLE
         FROM zaii_student
          FIELDS *
         WHERE student_id = @iv_student_id
          INTO @rs_student.

    " Student not found
    IF sy-subrc <> 0.
      RAISE EXCEPTION TYPE zcx_aii_student
        EXPORTING
          textid        = zcx_aii_student=>student_not_found
          lv_student_id = iv_student_id.
    ENDIF.

  ENDMETHOD.


  METHOD zif_aii_student~update_student.

    " Check if the student exists in the database
    SELECT SINGLE
        FROM zaii_student
         FIELDS *
        WHERE student_id = @iv_student_id
         INTO @DATA(ls_student).

    " Student not found
    IF sy-subrc <> 0.
      RAISE EXCEPTION TYPE zcx_aii_student
        EXPORTING
          textid        = zcx_aii_student=>student_not_found
          lv_student_id = iv_student_id.
    ENDIF.

    " Update the student record with new values
    UPDATE zaii_student FROM @(
                            VALUE #(
                               student_id    = iv_student_id
                               name          = iv_student_name
                               age           = iv_student_age
                               major         = iv_major
                               email         = iv_email
                               university_id = ls_student-university_id )  ).

    " Check if the update operation failed
    IF sy-subrc <> 0.
      RAISE EXCEPTION TYPE zcx_aii_student
        EXPORTING
          textid        = zcx_aii_student=>student_update_error
          lv_student_id = iv_student_id.
    ENDIF.

    " Commit the changes to the database and ensure all work is finalized
    COMMIT WORK AND WAIT.

    " Check if the commit operation failed
    IF sy-subrc <> 0.
      RAISE EXCEPTION TYPE zcx_aii_student
        EXPORTING
          textid = zcx_aii_student=>student_commit_error.
    ENDIF.

  ENDMETHOD.
ENDCLASS.
