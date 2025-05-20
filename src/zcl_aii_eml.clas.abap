CLASS zcl_aii_eml DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
    DATA update_tab TYPE TABLE FOR UPDATE /DMO/R_AgencyTP.

ENDCLASS.



CLASS ZCL_AII_EML IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.
    update_tab = VALUE #( ( AgencyID    = '070003'
                            name        = 'VISAGES Agency'
                            city        = 'Sofia'
                            countrycode = 'BG'
                            street      = 'Vitoshka' )  ).

    MODIFY ENTITIES OF /DMO/R_AgencyTP
    ENTITY /DMO/Agency
    UPDATE FIELDS ( name city countrycode street )
    WITH update_tab.

    COMMIT ENTITIES.

    out->write( `The related information was changed successfully!`  ).

  ENDMETHOD.
ENDCLASS.
