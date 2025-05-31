CLASS lhc_Item DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.

    CONSTANTS:
      BEGIN OF lt_status,
        in_process TYPE zrapd_order_status_aii VALUE 'O', " In Process
        completed  TYPE zrapd_order_status_aii VALUE 'A', " Completed
        cancelled  TYPE zrapd_order_status_aii VALUE 'C', " Cancelled
      END OF lt_status.

    METHODS calculateTotalPrice FOR DETERMINE ON MODIFY
      IMPORTING keys FOR Item~calculateTotalPrice.

    METHODS validateItemPrice FOR VALIDATE ON SAVE
      IMPORTING keys FOR Item~validateItemPrice.

    METHODS validateItemName FOR VALIDATE ON SAVE
      IMPORTING keys FOR Item~validateItemName.

    METHODS validateQuantity FOR VALIDATE ON SAVE
      IMPORTING keys FOR Item~validateQuantity.

    METHODS get_instance_features FOR INSTANCE FEATURES
      IMPORTING keys REQUEST requested_features FOR Item RESULT result.

ENDCLASS.

CLASS lhc_Item IMPLEMENTATION.

  METHOD calculateTotalPrice.
    " Read all orders for the requested items.
    " If multiple items of the same order are requested, the order is returned only once.
    READ ENTITIES OF zi_rap_order_aii IN LOCAL MODE
    ENTITY Item BY \_Order
      FIELDS ( OrderUUID )
      WITH CORRESPONDING #( keys )
      RESULT DATA(orders)
      FAILED DATA(read_failed).

    " Trigger calculation of the total price
    MODIFY ENTITIES OF ZI_RAP_Order_aii IN LOCAL MODE
    ENTITY Order
      EXECUTE recalcTotalPrice
      FROM CORRESPONDING #( orders )
    REPORTED DATA(execute_reported).

    reported = CORRESPONDING #( DEEP execute_reported ).
  ENDMETHOD.

  METHOD validateItemPrice.

    " Read relevant item instance data
    READ ENTITIES OF zi_rap_order_aii IN LOCAL MODE
      ENTITY Item
        FIELDS ( OrderUuid ItemPrice ) WITH CORRESPONDING #( keys )
      RESULT DATA(items).

    " Raise msg for initial Name and non-alphabetic characters
    LOOP AT items INTO DATA(item).
      " Clear state messages that might exist
      APPEND VALUE #(  %tky        = item-%tky
                       %state_area = 'VALIDATE_PRICE' )
        TO reported-item.

      " Check if an item price is initial.
      IF item-ItemPrice IS INITIAL.
        APPEND VALUE #(  %tky        = item-%tky
                         %state_area = 'VALIDATE_PRICE'
                         %msg        = NEW zcm_rap_order_aii(
                                           severity   = if_abap_behv_message=>severity-error
                                           textid     = zcm_rap_order_aii=>initial_item_price
                                           itemprice = item-itemprice )
                         %path-order-%tky-%is_draft = item-%is_draft
                         %path-order-%tky-OrderUuid = item-OrderUuid
                         %element-itemprice = if_abap_behv=>mk-on )
          TO reported-item.
        CONTINUE.
      ENDIF.

      " Check if an item price is a non-positive number.
      IF item-itemprice < 1.
        APPEND VALUE #(  %tky        = item-%tky
                         %state_area = 'VALIDATE_PRICE'
                         %msg        = NEW zcm_rap_order_aii(
                                           severity   = if_abap_behv_message=>severity-error
                                           textid     = zcm_rap_order_aii=>is_positive_check
                                           itemprice = item-itemprice )
                         %path-order-%tky-%is_draft = item-%is_draft
                         %path-order-%tky-OrderUuid = item-OrderUuid
                         %element-itemprice = if_abap_behv=>mk-on )
          TO reported-item.
        CONTINUE.
      ENDIF.
    ENDLOOP.
  ENDMETHOD.

  METHOD validateItemName.

    " Read relevant item instance data
    READ ENTITIES OF zi_rap_order_aii IN LOCAL MODE
      ENTITY Item
        FIELDS ( OrderUuid Name ) WITH CORRESPONDING #( keys )
      RESULT DATA(items).

    " Raise msg for initial Name and non-alphabetic characters
    LOOP AT items INTO DATA(item).
      " Clear state messages that might exist
      APPEND VALUE #(  %tky        = item-%tky
                       %state_area = 'VALIDATE_ITEM_NAME' )
        TO reported-item.

      " Check if a item name is empty
      IF item-Name IS INITIAL.
        APPEND VALUE #(  %tky        = item-%tky
                         %state_area = 'VALIDATE_ITEM_NAME'
                         %msg        = NEW zcm_rap_order_aii(
                                           severity   = if_abap_behv_message=>severity-error
                                           textid     = zcm_rap_order_aii=>initial_item_name
                                           itemname = item-Name )
                         %path-order-%tky-%is_draft = item-%is_draft
                         %path-order-%tky-OrderUuid = item-OrderUuid
                         %element-name = if_abap_behv=>mk-on )
          TO reported-item.
        CONTINUE.
      ENDIF.

      FIND FIRST OCCURRENCE OF REGEX '[^A-Za-z0-9 _-]'
        IN item-name
      MATCH OFFSET DATA(offset).

      " Invalid characters check (only letters, numbers, space, _ and -)
      IF sy-subrc = 0.
        APPEND VALUE #(  %tky        = item-%tky
                         %state_area = 'VALIDATE_ITEM_NAME'
                         %msg        = NEW zcm_rap_order_aii(
                                           severity   = if_abap_behv_message=>severity-error
                                           textid     = zcm_rap_order_aii=>invalid_item_name
                                           itemname = item-Name )
                         %path-order-%tky-%is_draft = item-%is_draft
                         %path-order-%tky-OrderUuid = item-OrderUuid
                         %element-name = if_abap_behv=>mk-on )
          TO reported-item.
        CONTINUE.
      ENDIF.

      " Check min/max length
      IF strlen( item-Name ) < 5 OR strlen( item-Name ) > 30.
        APPEND VALUE #(  %tky        = item-%tky
                         %state_area = 'VALIDATE_ITEM_NAME'
                         %msg        = NEW zcm_rap_order_aii(
                                           severity   = if_abap_behv_message=>severity-error
                                           textid     = zcm_rap_order_aii=>min_max_lenght_item
                                           itemname = item-Name )
                         %path-order-%tky-%is_draft = item-%is_draft
                         %path-order-%tky-OrderUuid = item-OrderUuid
                         %element-name = if_abap_behv=>mk-on )
          TO reported-item.
        CONTINUE.
      ENDIF.
    ENDLOOP.

  ENDMETHOD.

  METHOD validateQuantity.

    " Read relevant item instance data
    READ ENTITIES OF zi_rap_order_aii IN LOCAL MODE
      ENTITY Item
        FIELDS ( OrderUuid Quantity ) WITH CORRESPONDING #( keys )
      RESULT DATA(items).

    " Raise msg for initial Name and non-alphabetic characters
    LOOP AT items INTO DATA(item).
      " Clear state messages that might exist
      APPEND VALUE #(  %tky        = item-%tky
                       %state_area = 'VALIDATE_QUANTITY' )
        TO reported-item.

      " Check if an item quantity is initial.
      IF item-Quantity IS INITIAL.
        APPEND VALUE #(  %tky        = item-%tky
                         %state_area = 'VALIDATE_QUANTITY'
                         %msg        = NEW zcm_rap_order_aii(
                                           severity   = if_abap_behv_message=>severity-error
                                           textid     = zcm_rap_order_aii=>initial_quantity
                                           quantity = item-quantity )
                         %path-order-%tky-%is_draft = item-%is_draft
                         %path-order-%tky-OrderUuid = item-OrderUuid
                         %element-quantity = if_abap_behv=>mk-on )
          TO reported-item.
        CONTINUE.
      ENDIF.

      " Check if an item quantity is a non-positive number.
      IF item-Quantity < 1.
        APPEND VALUE #(  %tky = item-%tky ) TO failed-item.

        APPEND VALUE #(  %tky        = item-%tky
                         %state_area = 'VALIDATE_PRICE'
                         %msg        = NEW zcm_rap_order_aii(
                                           severity   = if_abap_behv_message=>severity-error
                                           textid     = zcm_rap_order_aii=>invalid_quantity
                                           quantity = item-quantity )
                         %path-order-%tky-%is_draft = item-%is_draft
                         %path-order-%tky-OrderUuid = item-OrderUuid
                         %element-quantity = if_abap_behv=>mk-on )
          TO reported-item.
        CONTINUE.
      ENDIF.

    ENDLOOP.
  ENDMETHOD.

  METHOD get_instance_features.
    " Read the item status of the existing orders
    READ ENTITIES OF zi_rap_order_aii IN LOCAL MODE
      ENTITY Item BY \_Order
        FIELDS ( Status ) WITH CORRESPONDING #( keys )
      RESULT DATA(items)
      FAILED failed.

    result =
      VALUE #(
        FOR item IN items
          LET is_accepted_rejected =   COND #( WHEN item-Status = lt_status-completed OR
                                                    item-Status = lt_status-cancelled
                                               THEN if_abap_behv=>fc-o-disabled
                                               ELSE if_abap_behv=>fc-o-enabled  )
          IN
            ( %tky    = item-%tky
              %delete = is_accepted_rejected  ) ).
  ENDMETHOD.

ENDCLASS.
