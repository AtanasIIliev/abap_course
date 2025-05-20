CLASS lhc_Order DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.

    METHODS get_instance_features FOR INSTANCE FEATURES
      IMPORTING keys REQUEST requested_features FOR Order RESULT result.

    METHODS get_instance_authorizations FOR INSTANCE AUTHORIZATION
      IMPORTING keys REQUEST requested_authorizations FOR Order RESULT result.

    METHODS orderCancelled FOR MODIFY
      IMPORTING keys FOR ACTION Order~orderCancelled RESULT result.

    METHODS orderCompleted FOR MODIFY
      IMPORTING keys FOR ACTION Order~orderCompleted RESULT result.

    METHODS populateCreationDate FOR DETERMINE ON MODIFY
      IMPORTING keys FOR Order~populateCreationDate.

    METHODS setInitialStatus FOR DETERMINE ON MODIFY
      IMPORTING keys FOR Order~setInitialStatus.

    METHODS incrementOrderId FOR DETERMINE ON SAVE
      IMPORTING keys FOR Order~incrementOrderId.

    METHODS validateCustomer FOR VALIDATE ON SAVE
      IMPORTING keys FOR Order~validateCustomer.

    METHODS validateName FOR VALIDATE ON SAVE
      IMPORTING keys FOR Order~validateName.

ENDCLASS.

CLASS lhc_Order IMPLEMENTATION.

  METHOD get_instance_features.
  ENDMETHOD.

  METHOD get_instance_authorizations.
  ENDMETHOD.

  METHOD orderCancelled.
  ENDMETHOD.

  METHOD orderCompleted.
  ENDMETHOD.

  METHOD populateCreationDate.
  ENDMETHOD.

  METHOD setInitialStatus.
  ENDMETHOD.

  METHOD incrementOrderId.
  ENDMETHOD.

  METHOD validateCustomer.
  ENDMETHOD.

  METHOD validateName.
  ENDMETHOD.

ENDCLASS.
