CLASS zcl_aii_university_system_run DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.

CLASS zcl_aii_university_system_run IMPLEMENTATION.

  METHOD if_oo_adt_classrun~main.

    DATA(lo_student)    = NEW zcl_aii_student(  ).
    DATA(lo_university) = NEW zcl_aii_university(  ).

    TRY.
        " Create University
        lo_university->lv_university_name = 'UNWE'.
        lo_university->lv_location        = 'Sofia'.
        lo_university->lv_university_id = lo_university->zif_aii_university~create_university(
                                  IMPORTING
                                  iv_university_name     = lo_university->lv_university_name "UNWE
                                  iv_university_location = lo_university->lv_location  ).    "Sofia
        out->write( |==============================================================================================================================================| ).
        out->write( |University Created Successfully!| ).
        out->write( |--------------------------------| ).
        out->write( |University ID : { lo_university->lv_university_id }| ).
        out->write( |Name          : { lo_university->lv_university_name }| ).
        out->write( |Age           : { lo_university->lv_location }| ).
        out->write( |==============================================================================================================================================| ).
******************************************************************************************************************************************
        " Create Student
        lo_student->lv_student_name = 'Georgi'.
        lo_student->lv_student_age = 20.
        lo_student->lv_major = 'Law'.
        lo_student->lv_email = 'georgi@gmail.com'.

        lo_student->lv_student_id = lo_student->zif_aii_student~create_student(
                                 IMPORTING
                                 iv_student_name = lo_student->lv_student_name "Georgi
                                 iv_student_age  = lo_student->lv_student_age  "20
                                 iv_major        = lo_student->lv_major        "Law
                                 iv_email        = lo_student->lv_email ).    "georgi@mail.com

        out->write( |==============================================================================================================================================| ).
        out->write( |Student Created Successfully!| ).
        out->write( |--------------------------------| ).
        out->write( |Student ID   : { lo_student->lv_student_id }| ).
        out->write( |Name         : { lo_student->lv_student_name }| ).
        out->write( |Age          : { lo_student->lv_student_age }| ).
        out->write( |Major        : { lo_student->lv_major }| ).
        out->write( |Email        : { lo_student->lv_email }| ).
        out->write( |==============================================================================================================================================| ).
*******************************************************************************************************************************************
        " Add Student to University
        lo_university->zif_aii_university~add_student(
                       EXPORTING
                       iv_student_id    = lo_student->lv_student_id
                       iv_university_id = lo_university->lv_university_id  ).
        out->write( |==============================================================================================================================================| ).
        out->write( |Student with ID { lo_student->lv_student_id } has been successfully added to the University with ID { lo_university->lv_university_id }.| ).
        out->write( |==============================================================================================================================================| ).
*******************************************************************************************************************************************
        " Get Student
        DATA(ls_student) = lo_student->zif_aii_student~get_student(
                           EXPORTING
                           iv_student_id = lo_student->lv_student_id ).
        out->write( |==============================================================================================================================================| ).
        out->write( |Student Information Retrieved Successfully!| ).
        out->write( |------------------------------------------| ).
        out->write( |Student ID    : { ls_student-student_id }| ).
        out->write( |Name          : { ls_student-name }| ).
        out->write( |Age           : { ls_student-age }| ).
        out->write( |Major         : { ls_student-major }| ).
        out->write( |Email         : { ls_student-email }| ).
        out->write( |University ID : { ls_student-university_id }| ).
        out->write( |==============================================================================================================================================| ).
********************************************************************************************************************************************
        " Update Student
        lo_student->lv_student_name = 'Ivan'.
        lo_student->lv_student_age = 22.
        lo_student->lv_major = 'Finance'.
        lo_student->lv_email = 'ivan@gmail.com'.

        lo_student->zif_aii_student~update_student(
                    EXPORTING
                        iv_student_id   = lo_student->lv_student_id
                        iv_student_name = lo_student->lv_student_name "Ivan
                        iv_student_age  = lo_student->lv_student_age  "22
                        iv_major        = lo_student->lv_major        "Finance
                        iv_email        = lo_student->lv_email ).     "ivan@gmail.com

        out->write( |==============================================================================================================================================| ).
        out->write( |Student Information Updated Successfully!| ).
        out->write( |------------------------------------------| ).
        out->write( |Student ID    : { lo_student->lv_student_id }| ).
        out->write( |Name          : { lo_student->lv_student_name }| ).
        out->write( |Age           : { lo_student->lv_student_age }| ).
        out->write( |Major         : { lo_student->lv_major }| ).
        out->write( |Email         : { lo_student->lv_email }| ).
        out->write( |University ID : { lo_university->lv_university_id }| ).
        out->write( |==============================================================================================================================================| ).
*******************************************************************************************************************************************
        " List Students
        lo_university->zif_aii_university~list_students(
                            EXPORTING
                              iv_university_id = lo_university->lv_university_id
                            IMPORTING
                              et_students      = DATA(lt_students) ).

        out->write( |==============================================================================================================================================| ).
        out->write( |Student Information Listed Successfully!| ).
        " No need to check if there is more than 1 student, just loop over the table to be on save side
        LOOP AT lt_students ASSIGNING FIELD-SYMBOL(<fs_students>).
          out->write( |---------------- Student : { sy-tabix } ----------------| ).
          out->write( |Student ID    : { <fs_students>-student_id }| ).
          out->write( |Name          : { <fs_students>-name }| ).
          out->write( |Age           : { <fs_students>-age }| ).
          out->write( |Major         : { <fs_students>-major }| ).
          out->write( |Email         : { <fs_students>-email }| ).
          out->write( |--------------------------------------------------------| ).
        ENDLOOP.
        out->write( |==============================================================================================================================================| ).

        " Delete Student
        lo_university->zif_aii_university~delete_student(
                           EXPORTING
                              iv_student_id = lo_student->lv_student_id ).

        out->write( |==============================================================================================================================================| ).
        out->write( |Student with ID { lo_student->lv_student_id } has been successfully removed (University id = initial value) from the university records. | ).
        out->write( |==============================================================================================================================================| ).

     " Clean up the data for test purpose.
*      DELETE FROM zaii_university.
*      DELETE FROM zaii_student.
*      out->write( |=========================================================================================================| ).
*      out->write( |All university and student records have been successfully removed.| ).
*      out->write( |=========================================================================================================| ).

      CATCH cx_uuid_error INTO DATA(lx_uuid_error).
        out->write( lx_uuid_error->get_text(  ) ).
      CATCH zcx_aii_student INTO DATA(lx_student_error).
        out->write( lx_student_error->get_text(  ) ).
      CATCH zcx_aii_university INTO DATA(lx_university_error).
        out->write( lx_university_error->get_text(  ) ).
    ENDTRY.

  ENDMETHOD.
ENDCLASS.
