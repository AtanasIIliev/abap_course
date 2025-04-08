INTERFACE zif_aii_abap_course_basics
  PUBLIC.
  TYPES: BEGIN OF lts_travel_id,
           travel_id TYPE /dmo/travel_id,
         END OF lts_travel_id.

  TYPES ltty_travel_id TYPE TABLE OF lts_travel_id.

  "! <p class="shorttext synchronized"></p>
  "! <strong>Task 1. Hello World</strong>
  "! <br/>
  "! <em>Implement method <strong>zif_abap_course_basics~hello_world</strong> which receives name as input and returns a message with the name and the system user id:
  "! “Hello IV_NAME, your system user is <system user id>.”
  "! <br/>
  "!The system user id should be fetched from the internal session properties.</em>
  "! @parameter iv_name   | <p class="shorttext synchronized"></p>
  "! @parameter rv_result | <p class="shorttext synchronized"></p>
  METHODS hello_world
    IMPORTING iv_name          TYPE string
    RETURNING VALUE(rv_result) TYPE string.

  "! <p class="shorttext synchronized"></p>
  "! <strong>Task 2. Calculator</strong>
  "! <br/>
  "! <em>Implement method <strong>zif_abap_course_basics~calculator</strong> which receives 2 numbers and an operator (+, -, *, /)
  "! and returns the result of calculation <param1> <operator> <param2>. </em>
  "! @parameter iv_first_number  | <p class="shorttext synchronized"></p>
  "! @parameter iv_second_number | <p class="shorttext synchronized"></p>
  "! @parameter iv_operator      | <p class="shorttext synchronized"></p>
  "! @parameter rv_result        | <p class="shorttext synchronized"></p>
  METHODS calculator
    IMPORTING iv_first_number  TYPE i
              iv_second_number TYPE i
              iv_operator      TYPE char1
    RETURNING VALUE(rv_result) TYPE i
    RAISING cx_sy_zerodivide.

  "! <p class="shorttext synchronized"></p>
  "! <strong>Task 3. Fizz Buzz</strong>
  "! <br/>
  "! <em>Implement method <strong>zif_abap_course_basics~fizz_buzz</strong> that returns a
  "! string with the numbers from 1 to 100. But for multiples of three writes “Fizz” instead of the number and for the multiples of five writes “Buzz”.
  "! For numbers which are multiples of both three and five it writes “FizzBuzz”. </em>
  "! @parameter rv_result | <p class="shorttext synchronized"></p>
  METHODS fizz_buzz
    RETURNING VALUE(rv_result) TYPE string.

  "! <p class="shorttext synchronized"></p>
  "! <strong>Task 4. Date Parsing</strong>
  "! <br/>
  "! <em>Implement method <strong>zif_abap_course_basics~date_parsing</strong> that receives a string, containing a date, formatted in one of two ways:
  "! <br/>
  "!With written month: 12 April 2017
  "! <br/>
  "!With number for month: 12 4 2017
  "! <br/>
  "!Parse this string and return a date variable with the result.</em>
  "! @parameter iv_date   | <p class="shorttext synchronized"></p>
  "! @parameter rv_result | <p class="shorttext synchronized"></p>
  METHODS date_parsing
    IMPORTING iv_date          TYPE string
    RETURNING VALUE(rv_result) TYPE dats.

  "! <p class="shorttext synchronized"></p>
  "! <strong>Task 5. Scrabble Score</strong>
  "! <br/>
  "! <em>Implement method <strong>zif_abap_course_basics~scrabble_score</strong> that receives a string and returns it’s
  "! Scrabble score. Use the letter position in English alphabet as score value. A=1 , B-2, etc...</em>
  "! @parameter iv_word   | <p class="shorttext synchronized"></p>
  "! @parameter rv_result | <p class="shorttext synchronized"></p>
  METHODS scrabble_score
    IMPORTING iv_word          TYPE string
    RETURNING VALUE(rv_result) TYPE i.

  "! <p class="shorttext synchronized"></p>
  "! <strong>Task 6. Current date and time</strong>
  "! <br/>
  "! <em>Implement method <strong>zif_abap_course_basics~get_current_date_time</strong> that returns the current date and time as timestamp.
  "! <br/>
  "! Use statement GET TIME STAMP FIELD DATA(lv_timestamp) to read the current time. </em>
  "! @parameter rv_result | <p class="shorttext synchronized"></p>
  METHODS get_current_date_time
    RETURNING VALUE(rv_result) TYPE timestampl.

  "! <p class="shorttext synchronized"></p>
  "!<strong>Task 7. Internal Tables</strong>
  "!<br/>
  "! <em>Implement method <strong>zif_abap_course_basics~internal_tables</strong> that covers the following requirements.</em>
  "! <em>Select all records in table ZTRAVEL_### into an internal table. Do not use any other OpenSQL. Execute the following operations on the internal table:
  "!<ul><li>The method should export a table containing all travels(TRAVEL_ID) for agency ( AGENCY_ID) 070001 with booking fee of 20 JPY (BOOKING_FEE CURRENCY_CODE)</li>
  "!<li>The method should export a table containing all travels with a price (TOTAL_PRICE) higher than 2000 USD. Hint: Currencies are convertible </li>
  "!<li>Delete all rows of the internal table with prices not in Euro, sort them by cheapest price and earliest date.</li>
  "!<li>Export a table containing the TRAVEL_ID of the first ten rows to screen.</li> </ul></em>
  "! @parameter et_travel_ids_task7_1 | <p class="shorttext synchronized"></p>
  "! @parameter et_travel_ids_task7_2 | <p class="shorttext synchronized"></p>
  "! @parameter et_travel_ids_task7_3 | <p class="shorttext synchronized"></p>
  METHODS internal_tables
    EXPORTING et_travel_ids_task7_1 TYPE ltty_travel_id
              et_travel_ids_task7_2 TYPE ltty_travel_id
              et_travel_ids_task7_3 TYPE ltty_travel_id.

  "! <p class="shorttext synchronized"></p>
  "! <strong> Task 8. OpenSQL</strong>
  "! <br/>
  "! <em>Implement <strong>zif_abap_course_basics~open_sql</strong> and achieve same results as task 7, but use <strong>only OpenSQL</strong> to filter the data,
  "! do not get any unneeded information from the database, do not delete/change any data in the database. </em>
  "! @parameter et_travel_ids_task8_1 | <p class="shorttext synchronized"></p>
  "! @parameter et_travel_ids_task8_2 | <p class="shorttext synchronized"></p>
  "! @parameter et_travel_ids_task8_3 | <p class="shorttext synchronized"></p>
  METHODS open_sql
    EXPORTING et_travel_ids_task8_1 TYPE ltty_travel_id
              et_travel_ids_task8_2 TYPE ltty_travel_id
              et_travel_ids_task8_3 TYPE ltty_travel_id.

*  METHODS generate_random_number
*    RETURNING VALUE(rv_result)      TYPE i.

ENDINTERFACE.
