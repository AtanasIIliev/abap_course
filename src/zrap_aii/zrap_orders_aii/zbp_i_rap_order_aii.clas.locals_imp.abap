CLASS lhc_Order DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.

    CONSTANTS:
      BEGIN OF lt_status,
        in_process TYPE zrapd_order_status_aii VALUE 'O', " In Process
        completed  TYPE zrapd_order_status_aii VALUE 'C', " Completed
        cancelled  TYPE zrapd_order_status_aii VALUE 'X', " Cancelled
      END OF lt_status.

    METHODS get_instance_features FOR INSTANCE FEATURES
      IMPORTING keys REQUEST requested_features FOR Order RESULT result.

    METHODS get_instance_authorizations FOR INSTANCE AUTHORIZATION
      IMPORTING keys REQUEST requested_authorizations FOR Order RESULT result.

    METHODS orderCancelled FOR MODIFY
      IMPORTING keys FOR ACTION Order~orderCancelled RESULT result.

    METHODS orderCompleted FOR MODIFY
      IMPORTING keys FOR ACTION Order~orderCompleted RESULT result.

    METHODS setCreationDate FOR DETERMINE ON MODIFY
      IMPORTING keys FOR Order~setCreationDate.

    METHODS setInitialStatus FOR DETERMINE ON MODIFY
      IMPORTING keys FOR Order~setInitialStatus.

    METHODS incrementOrderId FOR DETERMINE ON SAVE
      IMPORTING keys FOR Order~incrementOrderId.

    METHODS validateCustomer FOR VALIDATE ON SAVE
      IMPORTING keys FOR Order~validateCustomer.

    METHODS validateOrderName FOR VALIDATE ON SAVE
      IMPORTING keys FOR Order~validateOrderName.

    METHODS validateDeliveryCountry FOR VALIDATE ON SAVE
      IMPORTING keys FOR Order~validateDeliveryCountry.

    METHODS recalcTotalPrice FOR MODIFY
      IMPORTING keys FOR ACTION Order~recalcTotalPrice.

    METHODS populateCurrencyCode FOR DETERMINE ON MODIFY
      IMPORTING keys FOR Order~populateCurrencyCode.

    METHODS isOrderEmpty FOR VALIDATE ON SAVE
      IMPORTING keys FOR Order~isOrderEmpty.

ENDCLASS.

CLASS lhc_Order IMPLEMENTATION.

  METHOD get_instance_features.
    " Read the order status of the existing orders
    READ ENTITIES OF zi_rap_order_aii IN LOCAL MODE
      ENTITY Order
        FIELDS ( Status ) WITH CORRESPONDING #( keys )
      RESULT DATA(orders)
      FAILED failed.

    result =
      VALUE #(
        FOR order IN orders
          LET is_enabled_disabled =   COND #( WHEN order-Status <> lt_status-in_process
                                      THEN if_abap_behv=>fc-o-disabled
                                      ELSE if_abap_behv=>fc-o-enabled  )
" The commented part of code was part of previous implementation.
" The following error message appears: "The status is already set. Further changes are not allowed."
*              is_rejected =   COND #( WHEN order-Status <> lt_status-cancelled
*                                      THEN if_abap_behv=>fc-o-disabled
*                                      ELSE if_abap_behv=>fc-o-disabled )
          IN
            ( %tky                   = order-%tky
              %action-orderCompleted = is_enabled_disabled
              %action-orderCancelled = is_enabled_disabled
              %update                = is_enabled_disabled
             ) ).
  ENDMETHOD.

  METHOD get_instance_authorizations.
  ENDMETHOD.

  METHOD orderCancelled.
    " The commented part of code was part of previous implementation
    " It has been deactivated as this responsibility  is now handled in the METHOD get_instance_features.
    " Read relevant order instance data
    READ ENTITIES OF zi_rap_order_aii IN LOCAL MODE
      ENTITY Order
        FIELDS ( Status ) WITH CORRESPONDING #( keys )
      RESULT DATA(orders).

*    LOOP AT orders INTO DATA(order).
*      APPEND VALUE #(  %tky        = order-%tky
*                       %state_area = 'VALIDATE_STATUS' )
*      TO reported-order.
*
*      IF order-Status = lt_status-in_process. " = 'O'

    " Set the status of the order to cancelled
    MODIFY ENTITIES OF zi_rap_order_aii IN LOCAL MODE
     ENTITY Order
      UPDATE
       FIELDS ( Status CancellationDt )
       WITH VALUE #( FOR key IN keys
                        ( %tky           = key-%tky
                          Status         = lt_status-cancelled
                          CancellationDt = cl_abap_context_info=>get_system_date( ) ) )
       FAILED failed
       REPORTED reported.

    result = VALUE #( FOR order IN orders
                     ( %tky   = order-%tky
                       %param = order ) ).

*      ELSE.
*        APPEND VALUE #(  %tky = order-%tky ) TO failed-order.
*
*        APPEND VALUE #(  %tky        = order-%tky
*                         %state_area = 'VALIDATE_STATUS'
*                         %msg        = NEW zcm_rap_order_aii(
*                                           severity   = if_abap_behv_message=>severity-error
*                                           textid     = zcm_rap_order_aii=>status_already_set )
*                         %element-CustomerID = if_abap_behv=>mk-on )
*          TO reported-order.
*      ENDIF.
*    ENDLOOP.
  ENDMETHOD.

  METHOD orderCompleted.
    " The commented part of code was part of previous implementation
    " It has been deactivated as this responsibility  is now handled in the METHOD get_instance_features.
    " Read relevant order instance data
    READ ENTITIES OF zi_rap_order_aii IN LOCAL MODE
      ENTITY Order
        FIELDS ( Status ) WITH CORRESPONDING #( keys )
      RESULT DATA(orders).

*    LOOP AT orders INTO DATA(order).
*      APPEND VALUE #(  %tky        = order-%tky
*                       %state_area = 'VALIDATE_STATUS' )
*      TO reported-order.
*
*      IF order-Status = lt_status-in_process. " = 'O'

    " Set the status of the order to cancelled
    MODIFY ENTITIES OF zi_rap_order_aii IN LOCAL MODE
     ENTITY Order
      UPDATE
       FIELDS ( Status CompletionDt )
       WITH VALUE #( FOR key IN keys
                        ( %tky           = key-%tky
                          Status         = lt_status-cancelled
                          CompletionDt   = cl_abap_context_info=>get_system_date( ) ) )
       FAILED failed
       REPORTED reported.

    result = VALUE #( FOR order IN orders
                     ( %tky   = order-%tky
                       %param = order ) ).
*      ELSE.
*        APPEND VALUE #(  %tky = order-%tky ) TO failed-order.
*
*        APPEND VALUE #(  %tky        = order-%tky
*                         %state_area = 'VALIDATE_STATUS'
*                         %msg        = NEW zcm_rap_order_aii(
*                                           severity   = if_abap_behv_message=>severity-error
*                                           textid     = zcm_rap_order_aii=>status_already_set )
*                         %element-CustomerID = if_abap_behv=>mk-on )
*          TO reported-order.
*      ENDIF.
*    ENDLOOP.

  ENDMETHOD.

  METHOD setCreationDate.
    " Read relevant order instance data
    READ ENTITIES OF zi_rap_order_aii IN LOCAL MODE
      ENTITY Order
        FIELDS ( CreationDt ) WITH CORRESPONDING #( keys )
      RESULT DATA(orders).

    " Remove all order instance data with defined status
    DELETE orders WHERE CreationDt IS NOT INITIAL.
    CHECK orders IS NOT INITIAL.

    " Set default order status
    MODIFY ENTITIES OF zi_rap_order_aii IN LOCAL MODE
    ENTITY Order
      UPDATE
        FIELDS ( CreationDt )
        WITH VALUE #( FOR order IN orders
                      ( %tky         = order-%tky
                        CreationDt   = cl_abap_context_info=>get_system_date( ) ) )
    REPORTED DATA(update_reported).

    reported = CORRESPONDING #( DEEP update_reported ).
  ENDMETHOD.

  METHOD setInitialStatus.
    " Read relevant order instance data
    READ ENTITIES OF zi_rap_order_aii IN LOCAL MODE
      ENTITY Order
        FIELDS ( Status ) WITH CORRESPONDING #( keys )
      RESULT DATA(orders).

    " Remove all order instance data with defined status
    DELETE orders WHERE status IS NOT INITIAL.
    CHECK orders IS NOT INITIAL.

    " Set default order status
    MODIFY ENTITIES OF zi_rap_order_aii IN LOCAL MODE
    ENTITY Order
      UPDATE
        FIELDS ( Status )
        WITH VALUE #( FOR order IN orders
                      ( %tky         = order-%tky
                        Status       = lt_status-in_process ) )
    REPORTED DATA(update_reported).

    reported = CORRESPONDING #( DEEP update_reported ).
  ENDMETHOD.

  METHOD incrementOrderId.
    " Check if OrderID is already filled
    READ ENTITIES OF zi_rap_order_aii IN LOCAL MODE
      ENTITY Order
        FIELDS ( OrderID ) WITH CORRESPONDING #( keys )
      RESULT DATA(orders).

    " remove lines where orderID is already filled.
    DELETE orders WHERE OrderID IS NOT INITIAL.

    " anything left ?
    CHECK orders IS NOT INITIAL.

    " Select max order ID
    SELECT SINGLE
        FROM  zrap_aorders_aii
        FIELDS MAX( order_id ) AS orderID
        INTO @DATA(max_orderid).

    " Set the order ID
    MODIFY ENTITIES OF zi_rap_order_aii IN LOCAL MODE
    ENTITY Order
      UPDATE
        FROM VALUE #( FOR order IN orders INDEX INTO i (
          %tky              = order-%tky
          OrderID          = max_orderid + i
          %control-OrderID = if_abap_behv=>mk-on ) )
    REPORTED DATA(update_reported).

    reported = CORRESPONDING #( DEEP update_reported ).
  ENDMETHOD.

  METHOD validateCustomer.
    " Read relevant order instance data
    READ ENTITIES OF zi_rap_order_aii IN LOCAL MODE
      ENTITY Order
        FIELDS ( CustomerID ) WITH CORRESPONDING #( keys )
      RESULT DATA(orders).

    DATA customers TYPE SORTED TABLE OF /dmo/customer WITH UNIQUE KEY customer_id.

    " Optimization of DB select: extract distinct non-initial customer IDs
    customers = CORRESPONDING #( orders DISCARDING DUPLICATES MAPPING customer_id = CustomerID EXCEPT * ).
    DELETE customers WHERE customer_id IS INITIAL.
    IF customers IS NOT INITIAL.
      " Check if customer ID exist
      SELECT FROM /dmo/customer FIELDS customer_id
        FOR ALL ENTRIES IN @customers
        WHERE customer_id = @customers-customer_id
        INTO TABLE @DATA(customers_db).
    ENDIF.

    " Raise msg for non existing and initial customerID
    LOOP AT orders INTO DATA(order).
      " Clear state messages that might exist
      APPEND VALUE #(  %tky        = order-%tky
                       %state_area = 'VALIDATE_CUSTOMER' )
        TO reported-order.

      IF order-CustomerID IS INITIAL OR NOT line_exists( customers_db[ customer_id = order-CustomerID ] ).
        APPEND VALUE #(  %tky = order-%tky ) TO failed-order.

        APPEND VALUE #(  %tky        = order-%tky
                         %state_area = 'VALIDATE_CUSTOMER'
                         %msg        = NEW zcm_rap_order_aii(
                                           severity   = if_abap_behv_message=>severity-error
                                           textid     = zcm_rap_order_aii=>customer_unknown
                                           customerid = order-CustomerID )
                         %element-CustomerID = if_abap_behv=>mk-on )
          TO reported-order.
      ENDIF.
    ENDLOOP.
  ENDMETHOD.

  METHOD validateOrderName.
    " Read relevant order instance data
    READ ENTITIES OF zi_rap_order_aii IN LOCAL MODE
      ENTITY Order
        FIELDS ( Name ) WITH CORRESPONDING #( keys )
      RESULT DATA(orders).

    " Raise msg for initial Name and non-alphabetic characters
    LOOP AT orders INTO DATA(order).
      " Clear state messages that might exist
      APPEND VALUE #(  %tky        = order-%tky
                       %state_area = 'VALIDATE_NAME' )
        TO reported-order.

      " Check if name is empty
      IF order-Name IS INITIAL.
        APPEND VALUE #(  %tky = order-%tky ) TO failed-order.

        APPEND VALUE #(  %tky        = order-%tky
                         %state_area = 'VALIDATE_NAME'
                         %msg        = NEW zcm_rap_order_aii(
                                           severity   = if_abap_behv_message=>severity-error
                                           textid     = zcm_rap_order_aii=>initial_order_name )
                         %element-name = if_abap_behv=>mk-on )
          TO reported-order.
        CONTINUE.
      ENDIF.

      FIND FIRST OCCURRENCE OF REGEX '[^A-Za-z0-9 _-]'
        IN order-name
      MATCH OFFSET DATA(offset).

      " Invalid characters check (only letters, numbers, space, _ and -)
      IF sy-subrc = 0.
        APPEND VALUE #(  %tky = order-%tky ) TO failed-order.

        APPEND VALUE #(  %tky        = order-%tky
                         %state_area = 'VALIDATE_NAME'
                         %msg        = NEW zcm_rap_order_aii(
                                           severity   = if_abap_behv_message=>severity-error
                                           textid     = zcm_rap_order_aii=>invalid_order_name
                                           ordername = order-Name )
                         %element-name = if_abap_behv=>mk-on )
          TO reported-order.
        CONTINUE.
      ENDIF.

      " Check min/max length
      IF strlen( order-Name ) < 5 OR strlen( order-Name ) > 30.
        APPEND VALUE #(  %tky = order-%tky ) TO failed-order.

        APPEND VALUE #(  %tky        = order-%tky
                         %state_area = 'VALIDATE_NAME'
                         %msg        = NEW zcm_rap_order_aii(
                                           severity   = if_abap_behv_message=>severity-error
                                           textid     = zcm_rap_order_aii=>min_max_lenght_order
                                           ordername = order-Name )
                         %element-name = if_abap_behv=>mk-on )
          TO reported-order.
        CONTINUE.
      ENDIF.
    ENDLOOP.

  ENDMETHOD.

  METHOD validateDeliveryCountry.
    " Read relevant order instance data
    READ ENTITIES OF zi_rap_order_aii IN LOCAL MODE
      ENTITY Order
        FIELDS ( DeliveryCountry ) WITH CORRESPONDING #( keys )
      RESULT DATA(orders).

    DATA countries TYPE SORTED TABLE OF I_Country WITH UNIQUE KEY country.

    " Optimization of DB select: extract distinct non-initial customer IDs
    countries = CORRESPONDING #( orders DISCARDING DUPLICATES MAPPING country = DeliveryCountry EXCEPT * ).
    DELETE countries WHERE Country IS INITIAL.
    IF countries IS NOT INITIAL.
      " Check if customer ID exist
      SELECT FROM I_Country FIELDS Country
        FOR ALL ENTRIES IN @countries
        WHERE Country = @countries-Country
        INTO TABLE @DATA(countries_db).
    ENDIF.

    " Raise msg for non existing and initial customerID
    LOOP AT orders INTO DATA(order).
      " Clear state messages that might exist
      APPEND VALUE #(  %tky        = order-%tky
                       %state_area = 'VALIDATE_COUNTRY' )
        TO reported-order.

      IF order-DeliveryCountry IS INITIAL.
        APPEND VALUE #(  %tky = order-%tky ) TO failed-order.

        APPEND VALUE #(  %tky        = order-%tky
                         %state_area = 'VALIDATE_COUNTRY'
                         %msg        = NEW zcm_rap_order_aii(
                                           severity   = if_abap_behv_message=>severity-error
                                           textid     = zcm_rap_order_aii=>invalid_delivery_country
                                           delivery_country = order-DeliveryCountry )
                         %element-deliverycountry = if_abap_behv=>mk-on )
          TO reported-order.
      ENDIF.
    ENDLOOP.
  ENDMETHOD.

  METHOD recalcTotalPrice.
    TYPES: BEGIN OF ty_amount_per_currencycode,
             amount        TYPE /dmo/total_price,
             currency_code TYPE /dmo/currency_code,
           END OF ty_amount_per_currencycode.

    DATA lt_update TYPE TABLE FOR UPDATE ZI_RAP_Order_aii.

    DATA: amount_per_currencycode TYPE STANDARD TABLE OF ty_amount_per_currencycode.

    " Read all relevant order instances.
    READ ENTITIES OF zi_rap_order_aii IN LOCAL MODE
         ENTITY Order
            FIELDS ( TotalPrice CurrencyCode )
            WITH CORRESPONDING #( keys )
         RESULT DATA(orders).

    DELETE orders WHERE CurrencyCode IS INITIAL.

    LOOP AT orders ASSIGNING FIELD-SYMBOL(<fs_order>).
      " Set the start for the calculation by adding the price.
      amount_per_currencycode = VALUE #( ( amount        = 0
                                           currency_code = <fs_order>-CurrencyCode ) ).

      " Read all associated items and add them to the total price.
      READ ENTITIES OF zi_rap_order_aii IN LOCAL MODE
        ENTITY Order BY \_Item
          FIELDS ( OrderUuid ItemPrice CurrencyCode Quantity )
        WITH VALUE #( ( %tky = <fs_order>-%tky ) )
        RESULT DATA(items).

      LOOP AT items ASSIGNING FIELD-SYMBOL(<fs_item>)
        WHERE CurrencyCode IS NOT INITIAL.

        COLLECT VALUE ty_amount_per_currencycode( amount        = <fs_item>-ItemPrice * <fs_item>-Quantity
                                                  currency_code = <fs_item>-CurrencyCode ) INTO amount_per_currencycode.
      ENDLOOP.

      CLEAR <fs_order>-TotalPrice.
      LOOP AT amount_per_currencycode INTO DATA(single_amount_per_currencycode).
        <fs_order>-TotalPrice += single_amount_per_currencycode-amount.
      ENDLOOP.
      APPEND VALUE #( %tky = <fs_order>-%tky
                     TotalPrice = <fs_order>-TotalPrice
                     CurrencyCode = <fs_order>-CurrencyCode )
                     TO lt_update.
    ENDLOOP.

    MODIFY ENTITIES OF zi_rap_order_aii IN LOCAL MODE
      ENTITY Order
        UPDATE FIELDS ( TotalPrice CurrencyCode )
        WITH lt_update
        REPORTED DATA(lt_update_reported).

    reported = CORRESPONDING #( DEEP lt_update_reported ).

  ENDMETHOD.

  METHOD populateCurrencyCode.
    DATA lt_currency_code_updtd TYPE TABLE FOR UPDATE ZI_RAP_Order_aii\\Item.
    " Read order currency code.
    READ ENTITIES OF zi_rap_order_aii IN LOCAL MODE
      ENTITY Order
       FIELDS ( CurrencyCode )
      WITH CORRESPONDING #( keys )
      RESULT DATA(orders).

    " Read all items that are included in the order from above
    READ ENTITIES OF zi_rap_order_aii IN LOCAL MODE
     ENTITY Order BY \_Item
      FIELDS ( OrderUuid ItemUuid CurrencyCode )
     WITH CORRESPONDING #( orders )
     RESULT DATA(items).

    LOOP AT orders ASSIGNING FIELD-SYMBOL(<fs_order>).
      " Update all items of that order
      LOOP AT items ASSIGNING FIELD-SYMBOL(<fs_item>).
        APPEND VALUE #( %tky          = <fs_item>-%tky
                         CurrencyCode = <fs_order>-CurrencyCode )
                         TO lt_currency_code_updtd.
      ENDLOOP.
    ENDLOOP.

    MODIFY ENTITIES OF zi_rap_order_aii IN LOCAL MODE
    ENTITY Item
        UPDATE FIELDS ( CurrencyCode )
        WITH lt_currency_code_updtd
        REPORTED DATA(lt_update_reported).

    reported = CORRESPONDING #( DEEP lt_update_reported ).

  ENDMETHOD.

  METHOD isOrderEmpty.
    " Read relevant order instance data
    READ ENTITIES OF zi_rap_order_aii IN LOCAL MODE
     ENTITY Order
     FIELDS ( OrderUuid OrderId Name ) WITH CORRESPONDING #( keys )
     RESULT DATA(orders).

    " Read relevant item instance data
    READ ENTITIES OF zi_rap_order_aii IN LOCAL MODE
       ENTITY Order BY \_Item
       FIELDS ( OrderUuid ItemUuid ) WITH CORRESPONDING #( keys )
       RESULT DATA(items).

    SORT items BY orderuuid.

    LOOP AT orders INTO DATA(order).
      " Clear state messages that might exist
      APPEND VALUE #(  %tky        = order-%tky
                     %state_area = 'IS_ORDER_EMPTY' )
      TO reported-order.

      " Check if any item exists for this order
      READ TABLE items WITH KEY orderuuid = order-orderuuid TRANSPORTING NO FIELDS.

      " Check if any item exists
      IF sy-subrc <> 0.
        " No items found for this order
        APPEND VALUE #(  %tky = order-%tky ) TO failed-order.

        APPEND VALUE #(  %tky        = order-%tky
                         %state_area = 'IS_ORDER_EMPTY'
                         %msg        = NEW zcm_rap_order_aii(
                                           severity   = if_abap_behv_message=>severity-error
                                           textid     = zcm_rap_order_aii=>is_order_empty
                                           ordername  = order-Name )
                         %element-name = if_abap_behv=>mk-on )
          TO reported-order.

      ENDIF.
    ENDLOOP.
  ENDMETHOD.

ENDCLASS.
