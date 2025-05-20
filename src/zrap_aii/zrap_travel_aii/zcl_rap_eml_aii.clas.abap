CLASS zcl_rap_eml_aii DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    INTERFACES if_oo_adt_classrun.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS ZCL_RAP_EML_AII IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.

*    " step 1 - READ
*    READ ENTITIES OF zi_rap_travel_aii
*     ENTITY Travel
*       from value #( ( TravelUUID = '6D9480E329B791571900FDE605BA7F5C' ) )
*     RESULT data(travels).
*
*     out->write( travels ).

*     " step 2 - READ with Fields
*     READ ENTITIES OF zi_rap_travel_aii
*      ENTITY Travel
*         FIELDS ( AgencyID CustomerID )
*      WITH VALUE #( ( TravelUUID = '6D9480E329B791571900FDE605BA7F5C' ) )
*      RESULT DATA(travels).
*
*     out->write( travels ).

    " step 3 - READ with ALL Fields
*     READ ENTITIES OF ZI_RAP_Travel_AII
*      ENTITY Travel
*       ALL FIELDS WITH VALUE #( ( TravelUUID = '6D9480E329B791571900FDE605BA7F5C' ) )
*     RESULT DATA(travels).

*     out->write( travels ).

    " step 4 - READ by Association
*      READ ENTITIES OF ZI_RAP_TRAVEL_AII
*        ENTITY Travel BY \_Booking
*          ALL FIELDS WITH VALUE #( ( TravelUUID = '6D9480E329B791571900FDE605BA7F5C' ) )
*        RESULT DATA(bookings).
*
*        out->write( bookings ).

*    " step 5 - Unsuccessful READ
*        READ ENTITIES OF zi_rap_travel_aii
*          ENTITY travel
*            ALL FIELDS WITH VALUE #( ( TravelUUID = '11111111111111111111111111111111' ) )
*          RESULT   DATA(travels)
*          FAILED   DATA(failed)
*          REPORTED DATA(reported).
*
*       out->write( travels ).
*       out->write( failed ).   " complex structure not supported by the console output
*       out->write( reported ). " complex structure not supported by the console output

*     " step 6 - MODIFY Update
*     MODIFY ENTITIES OF zi_rap_travel_aii
*       ENTITY travel
*         UPDATE
*           SET FIELDS WITH VALUE
*             #( ( TravelUUID  = '6D9480E329B791571900FDE605BA7F5C'
*                  Description = 'I like RAP@openSAP' ) )
*
*     FAILED DATA(failed)
*     REPORTED DATA(reported).
*
*     out->write( 'Update done!' ).
*
*     " step 6b - Commit
*     COMMIT ENTITIES
*       RESPONSE OF zi_rap_travel_aii
*       FAILED   DATA(failed_commit)
*       REPORTED DATA(reported_commit).

*      " step 7 - MODIFY Create
*      MODIFY ENTITIES OF zi_rap_travel_aii
*        ENTITY travel
*          CREATE
*            SET FIELDS WITH VALUE
*              #( ( %cid = 'MyContentID_1'
*                   AgencyID    = '70012'
*                   CustomerID  = '14'
*                   BeginDate   = cl_abap_context_info=>get_system_date( )
*                   EndDate     = cl_abap_context_info=>get_system_date( ) + 10
*                   Description = 'I like RAP@openSAP' ) )
*
*      MAPPED DATA(mapped)
*      FAILED DATA(failed)
*      REPORTED DATA(reported).
*
*      out->write( mapped-travel ).
*
*      COMMIT ENTITIES
*        RESPONSE OF zi_rap_travel_aii
*        FAILED   DATA(failed_commit)
*        REPORTED DATA(reported_commit).
*
*     out->write( 'Create done!' ).

      " step 8 - MODIFY Delete
      MODIFY ENTITIES OF zi_rap_travel_aii
        ENTITY travel
          DELETE FROM
            VALUE
              #( ( TravelUUID = '1624162E1BF11FD08AC82EB04BEBCE88' ) )

      FAILED DATA(failed)
      REPORTED DATA(reported).

      COMMIT ENTITIES
        RESPONSE OF zi_rap_travel_aii
        FAILED   DATA(failed_commit)
        REPORTED DATA(reported_commit).

     out->write( 'Delete done!' ).

  ENDMETHOD.
ENDCLASS.
