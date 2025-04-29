CLASS zcl_aii_university DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    INTERFACES zif_aii_university .

    DATA:
      lv_university_name TYPE zaiid_university_name,
      lv_location        TYPE zaiid_location,
      lv_university_id   TYPE zaiid_university_id.

  PROTECTED SECTION.
  PRIVATE SECTION.
       CONSTANTS: " Can be put in the main class as class-data, but in our case we use it only here.
         lc_initial_st_id TYPE zaiid_student_id VALUE '00000000000000000000000000000000'.

ENDCLASS.

CLASS zcl_aii_university IMPLEMENTATION.

  METHOD zif_aii_university~add_student.

    UPDATE zaii_student
           SET    university_id = @iv_university_id
           WHERE student_id    = @iv_student_id.

    " Check if the insert operation failed
    IF sy-subrc <> 0.
      RAISE EXCEPTION TYPE zcx_aii_university
           EXPORTING
           textid           = zcx_aii_university=>university_creation_insert_err
           lv_university_id = iv_university_id.
    ENDIF.

    " Commit the changes to the database and ensure all work is finalized
    COMMIT WORK AND WAIT.

    " Check if the commit operation failed
    IF sy-subrc <> 0.
      RAISE EXCEPTION TYPE zcx_aii_university
           EXPORTING
           textid = zcx_aii_university=>university_commit_error.
    ENDIF.

  ENDMETHOD.

  METHOD zif_aii_university~create_university.
    " The other way is to declare it in the public section
    " Create a new university structure with a unique ID and input values for name and location
    DATA(ls_university) = VALUE zaii_university(
                                university_id = cl_system_uuid=>create_uuid_x16_static(  )
                                name          = iv_university_name
                                location      = iv_university_location ).

    " Insert the newly created university record into the database table
    INSERT zaii_university FROM @ls_university.

    " Check if the insert operation failed
    IF sy-subrc <> 0.
      RAISE EXCEPTION TYPE zcx_aii_university
           EXPORTING
           textid           = zcx_aii_university=>university_creation_insert_err
           lv_university_id = ls_university-university_id.
    ENDIF.

    " Commit the changes to the database and ensure all work is finalized
    COMMIT WORK AND WAIT.

    " Check if the commit operation failed
    IF sy-subrc <> 0.
      RAISE EXCEPTION TYPE zcx_aii_university
           EXPORTING
           textid = zcx_aii_university=>university_commit_error.
    ENDIF.

    " Return the generated university ID as the output of the method
    rv_university_id = ls_university-university_id.
  ENDMETHOD.

  METHOD zif_aii_university~delete_student.

    " Get the student
    SELECT SINGLE
         FROM zaii_student
          FIELDS @abap_true
         WHERE student_id = @iv_student_id
          INTO @DATA(lf_found).

    " Check if we found a student
    IF lf_found <> abap_true.
      RAISE EXCEPTION TYPE zcx_aii_university
           EXPORTING
           textid           = zcx_aii_university=>university_student_not_found
           lv_university_id = iv_student_id.
    ENDIF.

    " Update the database
    UPDATE zaii_student
          SET university_id = @lc_initial_st_id " '00000000000000000000000000000000'
           WHERE student_id = @iv_student_id.

    " Check if the update operation failed
    IF sy-subrc <> 0.
      RAISE EXCEPTION TYPE zcx_aii_university
           EXPORTING
           textid           = zcx_aii_university=>university_dlt_stundent_err
           lv_university_id = iv_student_id.
    ENDIF.

    " Commit the changes to the database and ensure all work is finalized
    COMMIT WORK AND WAIT.

    " Check if the commit operation failed
    IF sy-subrc <> 0.
      RAISE EXCEPTION TYPE zcx_aii_university
           EXPORTING
           textid = zcx_aii_university=>university_commit_error.
    ENDIF.

  ENDMETHOD.

  METHOD zif_aii_university~list_students.

    " Get the students
    SELECT
        FROM zaii_student
         FIELDS *
        WHERE university_id = @iv_university_id
         ORDER BY student_id
          INTO TABLE @et_students.

    " Check the result
    IF sy-subrc = 0.
      " Check if there are any students in the specified University.
      IF et_students IS INITIAL.
        RAISE EXCEPTION TYPE zcx_aii_university
           EXPORTING
           textid           = zcx_aii_university=>university_empty_no_students
           lv_university_id = iv_university_id.
      ENDIF.
    ELSE.
      RAISE EXCEPTION TYPE zcx_aii_university
           EXPORTING
           textid           = zcx_aii_university=>university_select_sttment_err.
    ENDIF.

  ENDMETHOD.
ENDCLASS.
