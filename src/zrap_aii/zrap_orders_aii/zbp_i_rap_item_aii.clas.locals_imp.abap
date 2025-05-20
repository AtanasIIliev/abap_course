CLASS lhc_Item DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.

    METHODS calculateTotalPrice FOR DETERMINE ON MODIFY
      IMPORTING keys FOR Item~calculateTotalPrice.

    METHODS validateItemPrice FOR VALIDATE ON SAVE
      IMPORTING keys FOR Item~validateItemPrice.

    METHODS validateName FOR VALIDATE ON SAVE
      IMPORTING keys FOR Item~validateName.

    METHODS validateQuantity FOR VALIDATE ON SAVE
      IMPORTING keys FOR Item~validateQuantity.

ENDCLASS.

CLASS lhc_Item IMPLEMENTATION.

  METHOD calculateTotalPrice.
  ENDMETHOD.

  METHOD validateItemPrice.
  ENDMETHOD.

  METHOD validateName.
  ENDMETHOD.

  METHOD validateQuantity.
  ENDMETHOD.

ENDCLASS.
