CLASS zcm_rap_order_aii DEFINITION
  PUBLIC
  INHERITING FROM cx_static_check
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_t100_message .
    INTERFACES if_t100_dyn_msg .
    INTERFACES if_abap_behv_message.

    CONSTANTS:
      BEGIN OF customer_unknown,
        msgid TYPE symsgid VALUE 'ZRAP_ORDERS_MSG_AII',
        msgno TYPE symsgno VALUE '001',
        attr1 TYPE scx_attrname VALUE 'CUSTOMERID',
        attr2 TYPE scx_attrname VALUE '',
        attr3 TYPE scx_attrname VALUE '',
        attr4 TYPE scx_attrname VALUE '',
      END OF customer_unknown .

    CONSTANTS:
      BEGIN OF invalid_order_name,
        msgid TYPE symsgid VALUE 'ZRAP_ORDERS_MSG_AII',
        msgno TYPE symsgno VALUE '002',
        attr1 TYPE scx_attrname VALUE 'ORDERNAME',
        attr2 TYPE scx_attrname VALUE '',
        attr3 TYPE scx_attrname VALUE '',
        attr4 TYPE scx_attrname VALUE '',
      END OF invalid_order_name .

    CONSTANTS:
      BEGIN OF invalid_item_name,
        msgid TYPE symsgid VALUE 'ZRAP_ORDERS_MSG_AII',
        msgno TYPE symsgno VALUE '003',
        attr1 TYPE scx_attrname VALUE 'ITEMNAME',
        attr2 TYPE scx_attrname VALUE '',
        attr3 TYPE scx_attrname VALUE '',
        attr4 TYPE scx_attrname VALUE '',
      END OF invalid_item_name .

    CONSTANTS:
      BEGIN OF invalid_quantity,
        msgid TYPE symsgid VALUE 'ZRAP_ORDERS_MSG_AII',
        msgno TYPE symsgno VALUE '004',
        attr1 TYPE scx_attrname VALUE 'QUANTITY',
        attr2 TYPE scx_attrname VALUE '',
        attr3 TYPE scx_attrname VALUE '',
        attr4 TYPE scx_attrname VALUE '',
      END OF invalid_quantity .

    CONSTANTS:
      BEGIN OF is_positive_check,
        msgid TYPE symsgid VALUE 'ZRAP_ORDERS_MSG_AII',
        msgno TYPE symsgno VALUE '005',
        attr1 TYPE scx_attrname VALUE 'ITEMPRICE',
        attr2 TYPE scx_attrname VALUE '',
        attr3 TYPE scx_attrname VALUE '',
        attr4 TYPE scx_attrname VALUE '',
      END OF is_positive_check .

    CONSTANTS:
      BEGIN OF initial_order_name,
        msgid TYPE symsgid VALUE 'ZRAP_ORDERS_MSG_AII',
        msgno TYPE symsgno VALUE '006',
        attr1 TYPE scx_attrname VALUE '',
        attr2 TYPE scx_attrname VALUE '',
        attr3 TYPE scx_attrname VALUE '',
        attr4 TYPE scx_attrname VALUE '',
      END OF initial_order_name .

    CONSTANTS:
      BEGIN OF min_max_lenght_order,
        msgid TYPE symsgid VALUE 'ZRAP_ORDERS_MSG_AII',
        msgno TYPE symsgno VALUE '007',
        attr1 TYPE scx_attrname VALUE 'ORDERNAME',
        attr2 TYPE scx_attrname VALUE '',
        attr3 TYPE scx_attrname VALUE '',
        attr4 TYPE scx_attrname VALUE '',
      END OF min_max_lenght_order .

    CONSTANTS:
      BEGIN OF invalid_delivery_country,
        msgid TYPE symsgid VALUE 'ZRAP_ORDERS_MSG_AII',
        msgno TYPE symsgno VALUE '008',
        attr1 TYPE scx_attrname VALUE 'DELIVERYCOUNTRY',
        attr2 TYPE scx_attrname VALUE '',
        attr3 TYPE scx_attrname VALUE '',
        attr4 TYPE scx_attrname VALUE '',
      END OF invalid_delivery_country .

    CONSTANTS:
      BEGIN OF initial_item_name,
        msgid TYPE symsgid VALUE 'ZRAP_ORDERS_MSG_AII',
        msgno TYPE symsgno VALUE '009',
        attr1 TYPE scx_attrname VALUE '',
        attr2 TYPE scx_attrname VALUE '',
        attr3 TYPE scx_attrname VALUE '',
        attr4 TYPE scx_attrname VALUE '',
      END OF initial_item_name .

    CONSTANTS:
      BEGIN OF min_max_lenght_item,
        msgid TYPE symsgid VALUE 'ZRAP_ORDERS_MSG_AII',
        msgno TYPE symsgno VALUE '010',
        attr1 TYPE scx_attrname VALUE 'ITEMNAME',
        attr2 TYPE scx_attrname VALUE '',
        attr3 TYPE scx_attrname VALUE '',
        attr4 TYPE scx_attrname VALUE '',
      END OF min_max_lenght_item .

    CONSTANTS:
      BEGIN OF initial_item_price,
        msgid TYPE symsgid VALUE 'ZRAP_ORDERS_MSG_AII',
        msgno TYPE symsgno VALUE '011',
        attr1 TYPE scx_attrname VALUE 'ITEMPRICE',
        attr2 TYPE scx_attrname VALUE '',
        attr3 TYPE scx_attrname VALUE '',
        attr4 TYPE scx_attrname VALUE '',
      END OF initial_item_price .

    CONSTANTS:
      BEGIN OF initial_quantity,
        msgid TYPE symsgid VALUE 'ZRAP_ORDERS_MSG_AII',
        msgno TYPE symsgno VALUE '012',
        attr1 TYPE scx_attrname VALUE 'QUANTITY',
        attr2 TYPE scx_attrname VALUE '',
        attr3 TYPE scx_attrname VALUE '',
        attr4 TYPE scx_attrname VALUE '',
      END OF initial_quantity .

    CONSTANTS:
      BEGIN OF is_order_empty,
        msgid TYPE symsgid VALUE 'ZRAP_ORDERS_MSG_AII',
        msgno TYPE symsgno VALUE '013',
        attr1 TYPE scx_attrname VALUE 'ORDERNAME',
        attr2 TYPE scx_attrname VALUE '',
        attr3 TYPE scx_attrname VALUE '',
        attr4 TYPE scx_attrname VALUE '',
      END OF is_order_empty .

    " The commented part of code was part of previous implementation
    " It has been deactivated as this responsibility  is now handled in the METHOD get_instance_features.
*    CONSTANTS:
*      BEGIN OF status_already_set,
*        msgid TYPE symsgid VALUE 'ZRAP_ORDERS_MSG_AII',
*        msgno TYPE symsgno VALUE '014',
*        attr1 TYPE scx_attrname VALUE '',
*        attr2 TYPE scx_attrname VALUE '',
*        attr3 TYPE scx_attrname VALUE '',
*        attr4 TYPE scx_attrname VALUE '',
*      END OF status_already_set.

    DATA:
      customerid       TYPE string               READ-ONLY,
      ordername        TYPE zrapd_order_name_aii READ-ONLY,
      itemname         TYPE zrapd_item_name_aii  READ-ONLY,
      quantity         TYPE zrapd_quantity_aii   READ-ONLY,
      itemprice        TYPE /dmo/total_price     READ-ONLY,
      delivery_country TYPE land1                READ-ONLY,
      orderid          TYPE n LENGTH 8           READ-ONLY.

    METHODS constructor
      IMPORTING
        severity         TYPE if_abap_behv_message=>t_severity
          DEFAULT if_abap_behv_message=>severity-error
        textid           LIKE if_t100_message=>t100key OPTIONAL
        previous         TYPE REF TO cx_root OPTIONAL
        customerid       TYPE /dmo/customer_id OPTIONAL
        ordername        TYPE zrapd_order_name_aii OPTIONAL
        itemname         TYPE zrapd_item_name_aii OPTIONAL
        quantity         TYPE zrapd_quantity_aii  OPTIONAL
        itemprice        TYPE /dmo/total_price OPTIONAL
        delivery_country TYPE land1            OPTIONAL
        orderid          TYPE n                OPTIONAL.

  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.


CLASS zcm_rap_order_aii IMPLEMENTATION.


  METHOD constructor ##ADT_SUPPRESS_GENERATION.
    super->constructor(
    previous = previous
    ).
    CLEAR me->textid.
    IF textid IS INITIAL.
      if_t100_message~t100key = if_t100_message=>default_textid.
    ELSE.
      if_t100_message~t100key = textid.
    ENDIF.

    me->if_abap_behv_message~m_severity = severity.
    me->customerid = |{ customerid ALPHA = OUT }|.
    me->ordername = ordername.
    me->itemname = itemname.
    me->quantity = quantity.
    me->itemprice = itemprice.
    me->delivery_country = delivery_country.
    me->orderid = orderid.

  ENDMETHOD.
ENDCLASS.
