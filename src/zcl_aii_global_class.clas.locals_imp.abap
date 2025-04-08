*"* use this source file for the definition and implementation of
*"* local helper classes, interface definitions and type
*"* declarations

CLASS lcl_connection DEFINITION.

  PUBLIC SECTION.

    CLASS-DATA conn_counter TYPE i.

*    METHODS get_attributes
*      EXPORTING
*        e_carrier_id    TYPE /dmo/carrier_id
*        e_connection_id TYPE /dmo/connection_id.

    METHODS set_attributes
      IMPORTING
        i_carrier_id    TYPE /dmo/carrier_id   OPTIONAL
        i_connection_id TYPE /dmo/connection_id
      RAISING
        cx_abap_invalid_value.

    METHODS constructor
      IMPORTING
        i_carrier_id    TYPE /dmo/carrier_id
        i_connection_id TYPE /dmo/connection_id.
    METHODS get_output RETURNING
        VALUE(r_output) TYPE string_table.

  PROTECTED SECTION.

  PRIVATE SECTION.

    DATA: carrier_id      TYPE /dmo/carrier_id,
          connection_id   TYPE /dmo/connection_id,

          airport_from_id TYPE /dmo/airport_from_id,
          airport_to_id   TYPE /dmo/airport_to_id,

          carrier_name    TYPE /dmo/carrier_name.

ENDCLASS.

CLASS lcl_connection IMPLEMENTATION.

  METHOD constructor.

    me->carrier_id    = i_carrier_id.
    me->connection_id = i_connection_id.

    conn_counter += 1.

  ENDMETHOD.

  METHOD set_attributes.

    IF carrier_id IS INITIAL OR connection_id IS INITIAL.
      RAISE EXCEPTION TYPE cx_abap_invalid_value.
    ENDIF.

    carrier_id    = i_carrier_id.
    connection_id = i_connection_id.

  ENDMETHOD.

*  METHOD get_attributes.
*
*  ENDMETHOD.

  METHOD get_output.

    APPEND |------------------------------| TO r_output.
    APPEND |Carrier:     { carrier_id    }| TO r_output.
    APPEND |Connection:  { connection_id }| TO r_output.

  ENDMETHOD.

ENDCLASS.
