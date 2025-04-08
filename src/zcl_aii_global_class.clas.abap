CLASS zcl_aii_global_class DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    INTERFACES if_oo_adt_classrun .

  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_aii_global_class IMPLEMENTATION.
  METHOD if_oo_adt_classrun~main.

*    CONSTANTS: c_carrier_id    TYPE              /dmo/carrier_id       VALUE 'LH',
*               c_connection_id TYPE              /dmo/connection_id VALUE '0400'.

    DATA: connection  TYPE REF TO          lcl_connection,
          connections TYPE TABLE OF REF TO lcl_connection.

*    connection = NEW #( ).

    TRY.

        connection = NEW #( i_carrier_id = 'LH'
                            i_connection_id = '0400' ).

*        connection->carrier_id    = 'LH'.
*        connection->connection_id = '0400'.

        APPEND connection TO connections.

      CATCH cx_abap_invalid_value.
        out->write( `Method call failed` ).
    ENDTRY.

    TRY.
        connection = NEW #( i_carrier_id = 'AA'
                            i_connection_id = '0500' ).

*        connection->carrier_id    = 'AA'.
*        connection->connection_id = '0017'.

        APPEND connection TO connections.

      CATCH cx_abap_invalid_value.
        out->write( `Method call failed` ).
    ENDTRY.

    LOOP AT connections INTO connection.
      out->write( connection->get_output( ) ).
    ENDLOOP.

  ENDMETHOD.
ENDCLASS.
