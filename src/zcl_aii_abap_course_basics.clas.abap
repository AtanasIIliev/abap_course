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
    DATA lv_task_number TYPE i VALUE 2.

    CASE lv_task_number.
      WHEN 1. " Hello world
        out->write( zif_aii_abap_course_basics~hello_world( 'Atanas' ) ) .

      WHEN 2. " Calculator
        DATA:
          lv_first_number  TYPE i     VALUE 2,
          lv_second_number TYPE i     VALUE 5,
          lv_operator      TYPE char1 VALUE '*'.

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

      WHEN 7. " Internal tables
        DATA:
          lt_travel_ids_task7_1 TYPE TABLE OF zif_aii_abap_course_basics~lts_travel_id,
          lt_travel_ids_task7_2 TYPE TABLE OF zif_aii_abap_course_basics~lts_travel_id,
          lt_travel_ids_task7_3 TYPE TABLE OF zif_aii_abap_course_basics~lts_travel_id.

        zif_aii_abap_course_basics~internal_tables(
                    IMPORTING et_travel_ids_task7_1 = lt_travel_ids_task7_1
                              et_travel_ids_task7_2 = lt_travel_ids_task7_2
                              et_travel_ids_task7_3 = lt_travel_ids_task7_3  ).

        out->write( '---------lt_travel_ids_task7_1---------' ).
        out->write( lt_travel_ids_task7_1 ).
        out->write( '---------lt_travel_ids_task7_2---------' ).
        out->write( lt_travel_ids_task7_2 ).
        out->write( '---------lt_travel_ids_task7_3---------' ).
        out->write( lt_travel_ids_task7_3 ).

      WHEN 8. " Open SQL
        DATA:
          lt_travel_ids_task8_1 TYPE TABLE OF zif_aii_abap_course_basics~lts_travel_id,
          lt_travel_ids_task8_2 TYPE TABLE OF zif_aii_abap_course_basics~lts_travel_id,
          lt_travel_ids_task8_3 TYPE TABLE OF zif_aii_abap_course_basics~lts_travel_id.

        zif_aii_abap_course_basics~open_sql(
               IMPORTING et_travel_ids_task8_1 = lt_travel_ids_task8_1
                         et_travel_ids_task8_2 = lt_travel_ids_task8_2
                         et_travel_ids_task8_3 = lt_travel_ids_task8_3  ).

        out->write( '---------lt_travel_ids_task8_1---------' ).
        out->write( lt_travel_ids_task8_1 ).
        out->write( '---------lt_travel_ids_task8_2---------' ).
        out->write( lt_travel_ids_task8_2 ).
        out->write( '---------lt_travel_ids_task8_3---------' ).
        out->write( lt_travel_ids_task8_3 ).

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

    DATA:
      lt_ztravel            TYPE TABLE OF  ztravel_aii,
      lt_travel_ids_task7_1 TYPE TABLE OF  zif_aii_abap_course_basics~lts_travel_id,
      lt_travel_ids_task7_2 TYPE TABLE OF  zif_aii_abap_course_basics~lts_travel_id,
      lt_travel_ids_task7_3 TYPE TABLE OF  zif_aii_abap_course_basics~lts_travel_id,
      lv_price_in_usd       TYPE           ztravel_aii-total_price,
      lv_conv_rate          TYPE           p DECIMALS 6.

    " Check if ZTRAVEL_AII is empty
    SELECT SINGLE *
           FROM ztravel_aii
           INTO @DATA(ls_empty_check).

    " And if no records exist, fetch them.
    IF sy-subrc <> 0.

      SELECT * FROM ztravel_aii INTO TABLE @lt_ztravel.
      DELETE ztravel_aii FROM TABLE @lt_ztravel.
      COMMIT WORK AND WAIT.

      INSERT ztravel_aii FROM
    ( SELECT FROM /dmo/travel
        FIELDS uuid( )          AS travel_uuid,
               travel_id        AS travel_id,
               agency_id        AS agency_id,
               customer_id      AS customer_id,
               begin_date       AS begin_date,
               end_date         AS end_date,
               booking_fee      AS booking_fee,
               total_price      AS total_price,
               currency_code    AS currency_code,
               description      AS description,
               CASE status
             WHEN 'B' THEN 'A'  " ACCEPTED
             WHEN 'X' THEN 'X'  " CANCELLED
                 ELSE 'O'         " open
            END                 AS overall_status,
               createdby        AS createdby,
               createdat        AS createdat,
               lastchangedby    AS last_changed_by,
               lastchangedat    AS last_changed_at
        ORDER BY travel_id ).

      COMMIT WORK AND WAIT.
    ENDIF.

    " Load all records
    SELECT *
          FROM ztravel_aii
          into table @lt_ztravel.

    " Check if any data was loaded (not sure whether we need it)
    if sy-subrc <> 0. "TODO: Ask for assert statement!!!
      RETURN.
    endif.

*    et_travel_ids_task7_1 = FILTER #( lt_ztravel using key primary_key WHERE agency_id = CONV #( '070001' )
*                                                      AND   booking_fee = CONV #( 20 )
*                                                      AND   currency_code = conv #( 'JPY' ) ).

    LOOP AT lt_ztravel ASSIGNING FIELD-SYMBOL(<fs_ltztravel>).
      FREE lv_price_in_usd.

      " Conversion magic from My bank
      CASE <fs_ltztravel>-currency_code.
        WHEN 'EUR'.  lv_conv_rate = '1.10'.  " EUR to USD from My bank
        WHEN 'JPY'.  lv_conv_rate = '0.007'. " JPY to USD from My bank
        WHEN 'SGD'.  lv_conv_rate = '0.75'.  " SGD to USD from My bank
        WHEN 'INR'.  lv_conv_rate = '0.0117'." INR to USD from My bank
        WHEN 'AFN'.  lv_conv_rate = '0.0141'." AFN to USD from My bank
        WHEN OTHERS. lv_conv_rate = '1'.     " If there are other currencies OR currency_code = 'USD'
      ENDCASE.

      lv_price_in_usd = <fs_ltztravel>-total_price * lv_conv_rate.

      "7.1 Filter by agency_id, currency_code and booking fee
      IF <fs_ltztravel>-agency_id   = '070001' AND
         <fs_ltztravel>-currency_code = 'JPY'  AND
         <fs_ltztravel>-booking_fee   = 20.

        APPEND <fs_ltztravel>-travel_id TO lt_travel_ids_task7_1.
      ENDIF.

      "7.2 Filter by total_price > 2000 USD
      IF lv_price_in_usd > 2000.

        APPEND <fs_ltztravel>-travel_id TO lt_travel_ids_task7_2.
      ENDIF.
    ENDLOOP.

    " Delete all rows with EUR price
    DELETE lt_ztravel WHERE currency_code <> 'EUR'.

    " Sort by total_price ASC and begin_date DESC.
    SORT lt_ztravel BY total_price " ASC
                       begin_date. " ASC

    " Export only the travel_id of the first ten rows
    LOOP AT lt_ztravel ASSIGNING FIELD-SYMBOL(<fs_ztravel>)
         FROM 1 TO 10.

        APPEND <fs_ztravel>-travel_id TO lt_travel_ids_task7_3.
    ENDLOOP.

    " Assign filtered travel_ids to exporting parameters
    et_travel_ids_task7_1 = lt_travel_ids_task7_1.
    et_travel_ids_task7_2 = lt_travel_ids_task7_2.
    et_travel_ids_task7_3 = lt_travel_ids_task7_3.

  ENDMETHOD.

  METHOD zif_aii_abap_course_basics~open_sql.
    " Get travel_ids as per the following criteria - agency '070001' with booking fee 20 JPY
    SELECT travel_id
        FROM ztravel_aii AS tr

        WHERE tr~agency_id     = '070001'
        AND   tr~booking_fee   = 20
        AND   tr~currency_code = 'JPY'

        INTO TABLE @DATA(lt_travel_ids_task8_1).

    " Get travel_ids with total price > 2000 USD
        SELECT travel_id
            FROM ztravel_aii AS tr

           WHERE
              CASE tr~currency_code
               WHEN 'EUR' THEN tr~total_price * CAST( '1.10'   AS DEC ) " EUR to USD from My bank
               WHEN 'JPY' THEN tr~total_price * CAST( '0.007'  AS DEC ) " JPY to USD from My bank
               WHEN 'SGD' THEN tr~total_price * CAST( '0.75'   AS DEC ) " SGD to USD from My bank
               WHEN 'INR' THEN tr~total_price * CAST( '0.0117' AS DEC ) " INR to USD from My bank
               WHEN 'AFN' THEN tr~total_price * CAST( '0.0141' AS DEC ) " AFN to USD from My bank
              ELSE tr~total_price                                       " If there are other currencies OR currency_code = 'USD'
           END > 2000

        INTO TABLE @DATA(lt_travel_ids_task8_2).

    " Get first 10 travel_ids sorted by cheapest price and earliest begin date
    SELECT travel_id
        FROM ztravel_aii AS tr

        WHERE tr~currency_code = 'EUR'

        ORDER BY tr~total_price, "ASC
                 tr~begin_date   "ASC

        INTO TABLE @DATA(lt_travel_ids_task8_3)

        UP TO 10 ROWS.

    " Assign filtered travel_ids to exporting parameters
    et_travel_ids_task8_1 = lt_travel_ids_task8_1.
    et_travel_ids_task8_2 = lt_travel_ids_task8_2.
    et_travel_ids_task8_3 = lt_travel_ids_task8_3.

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

