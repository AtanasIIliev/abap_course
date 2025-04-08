CLASS zcl_aii_abap_course_basics DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun.
    INTERFACES zif_aii_abap_course_basics.

  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.


CLASS zcl_aii_abap_course_basics IMPLEMENTATION.

  METHOD if_oo_adt_classrun~main.

    " Since the ABAP Eclipse does not have a real time console for input,
    " we need to declare a task number/value in order to start one of the tasks.
    DATA lv_task_number TYPE i VALUE 6.

    CASE lv_task_number.
      WHEN 1. " Hello world
        out->write( zif_aii_abap_course_basics~hello_world( 'Atanas' ) ) .

      WHEN 2. " Calculator
        DATA:
          lv_first_number  TYPE i     VALUE 1,
          lv_second_number TYPE i     VALUE 0,
          lv_operator      TYPE char1 VALUE '+'.

        TRY.
            "TO DO: provide a little bit more formatted output, when the operation is successful!!!
            out->write( zif_aii_abap_course_basics~calculator(
                 EXPORTING
                iv_first_number  = lv_first_number
                iv_second_number = lv_second_number
                iv_operator      = lv_operator ) ) .

          CATCH cx_sy_zerodivide INTO DATA(lv_error_message).
            DATA(lv_output) = lv_error_message->get_text(  ).
            out->write( lv_output ).
        ENDTRY.

      WHEN 3. " Fizz Buzz
        out->write(  zif_aii_abap_course_basics~fizz_buzz( ) ).

      WHEN 4. " Date Parsing
        out->write(  zif_aii_abap_course_basics~date_parsing( '12 12 2017' ) ).

      WHEN 5. " Scrabble Score
        out->write(  zif_aii_abap_course_basics~scrabble_score( 'ABZ' ) ).

      WHEN 6. " Get current date and time
        out->write(  zif_aii_abap_course_basics~get_current_date_time( ) ).

    ENDCASE.
  ENDMETHOD.

  METHOD zif_aii_abap_course_basics~calculator.

    CASE iv_operator.
      WHEN '-'.
        rv_result = iv_first_number - iv_second_number.

      WHEN '+'.
        rv_result = iv_first_number + iv_second_number.

      WHEN '*'.
        rv_result = iv_first_number * iv_second_number.

      WHEN '/'.
        IF iv_second_number = 0.
          RAISE EXCEPTION TYPE cx_sy_zerodivide.
        ELSE.
          rv_result = iv_first_number / iv_second_number.
        ENDIF.
    ENDCASE.

  ENDMETHOD.

  METHOD zif_aii_abap_course_basics~date_parsing.

    TYPES: BEGIN OF tt_months,
             month_name   TYPE string,
             month_number TYPE string,
           END OF tt_months.

    DATA: lt_months      TYPE TABLE OF tt_months,
          lt_input_split TYPE TABLE OF string,
          lv_temp        TYPE          string,
          lv_only_digits TYPE          abap_bool VALUE abap_false,
          lv_day         TYPE          string,
          lv_month       TYPE          string,
          lv_year        TYPE          string.

    SPLIT iv_date AT space INTO TABLE lt_input_split.

    lv_day = lt_input_split[ 1 ].

    lv_month = to_upper( lt_input_split[ 2 ] ).
    IF lv_month CO '0123456789'.
      lv_only_digits = abap_true.
    ENDIF.

    lv_year = lt_input_split[ 3 ].

    IF lv_only_digits = abap_false.

      lt_months = VALUE #(
                ( month_name = 'JANUARY'   month_number = '01' )
                ( month_name = 'FEBRUARY'  month_number = '02' )
                ( month_name = 'MARCH'     month_number = '03' )
                ( month_name = 'APRIL'     month_number = '04' )
                ( month_name = 'MAY'       month_number = '05' )
                ( month_name = 'JUNE'      month_number = '06' )
                ( month_name = 'JULY'      month_number = '07' )
                ( month_name = 'AUGUST'    month_number = '08' )
                ( month_name = 'SEPTEMBER' month_number = '09' )
                ( month_name = 'OCTOBER'   month_number = '10' )
                ( month_name = 'NOVEMBER'  month_number = '11' )
                ( month_name = 'DECEMBER'  month_number = '12' ) ).

      READ TABLE lt_months WITH KEY month_name = lv_month INTO DATA(ls_month).

      lv_month = ls_month-month_number.

    ELSE.
      IF strlen( lv_day ) <> 2 OR strlen( lv_month ) <> 2 .

        IF strlen( lv_day ) <> 2 AND strlen( lv_month ) <> 2 .
          lv_day = '0' && lv_day.
          lv_month = '0' && lv_month.
        ELSEIF strlen( lv_month ) <> 2.
          lv_month = '0' && lv_month.
        ELSE.
          lv_day = '0' && lv_day.
        ENDIF.

      ENDIF.
    ENDIF.

    CONCATENATE lv_year lv_month lv_day INTO rv_result.

  ENDMETHOD.

  METHOD zif_aii_abap_course_basics~fizz_buzz.
    DATA: lv_number TYPE i,
          lv_text   TYPE string,
          lt_output TYPE TABLE OF string.

    DO 100 TIMES.
      lv_number = sy-index.

      IF lv_number MOD 5 = 0 AND lv_number MOD 3 = 0.
        lv_text = '“FizzBuzz”'.
      ELSEIF lv_number MOD 5 = 0.
        lv_text = '“Fizz”'.
      ELSEIF lv_number MOD 3 = 0.
        lv_text = '“Buzz”'.
      ELSE.
        lv_text = lv_number.
      ENDIF.

      APPEND lv_text TO lt_output.
    ENDDO.

    LOOP AT lt_output INTO lv_text.
      rv_result = |{ rv_result } { lv_text }|.
    ENDLOOP.
  ENDMETHOD.

  METHOD zif_aii_abap_course_basics~get_current_date_time.
    DATA lv_timestamp TYPE timestampl.

    GET TIME STAMP FIELD lv_timestamp.

    rv_result =  lv_timestamp.
  ENDMETHOD.

  METHOD zif_aii_abap_course_basics~hello_world.

    DATA(lv_user_id) = sy-uname.
    rv_result = |Hello { iv_name }, your system user id { lv_user_id }.|.

  ENDMETHOD.

  METHOD zif_aii_abap_course_basics~internal_tables.
  ENDMETHOD.

  METHOD zif_aii_abap_course_basics~open_sql.
  ENDMETHOD.

  METHOD zif_aii_abap_course_basics~scrabble_score.
    DATA: lv_char     TYPE char1,
          lv_result   TYPE i,
          lv_alphabet TYPE string VALUE 'ABCDEFGHIJKLMNOPQRSTUVWXYZ',
          lv_index    TYPE i.

    DO strlen( iv_word ) TIMES.
      lv_char = to_upper( iv_word+lv_index(1) ).

      FIND FIRST OCCURRENCE OF lv_char IN lv_alphabet MATCH OFFSET DATA(lv_position).
      lv_result +=  lv_position + 1.

      lv_index += 1.
    ENDDO.

    rv_result = lv_result.
  ENDMETHOD.

ENDCLASS.

