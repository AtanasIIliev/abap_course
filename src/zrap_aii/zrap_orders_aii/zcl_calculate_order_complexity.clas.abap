CLASS zcl_calculate_order_complexity DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_sadl_exit .
    INTERFACES if_sadl_exit_calc_element_read .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_calculate_order_complexity IMPLEMENTATION.


  METHOD if_sadl_exit_calc_element_read~calculate.

    DATA:
          lt_orders     TYPE STANDARD TABLE OF zc_rap_order_aii,
          lv_complexity TYPE string.

  " Convert input data to internal table
    lt_orders = CORRESPONDING #( it_original_data ).

  " Loop through each order to calculate its complexity
    LOOP AT lt_orders ASSIGNING FIELD-SYMBOL(<order>).

  " Count how many items this order has
      READ ENTITIES OF zc_rap_order_aii
        ENTITY Order BY \_Item
        FIELDS ( Orderuuid )
        WITH VALUE #( ( Orderuuid = <order>-orderuuid ) )
        RESULT DATA(items).

      DATA(item_count) = lines( items ).

      " Determine complexity
      CASE item_count.
        WHEN 0 OR 1 OR 2.
          lv_complexity = 'Easy'.
        WHEN 3 OR 4.
          lv_complexity = 'Medium'.
        WHEN OTHERS.
          lv_complexity = 'Complex'.
      ENDCASE.

   " Save the result into the output structure
      <order>-complexity = lv_complexity.
    ENDLOOP.

   " Pass the calculated results
    ct_calculated_data = CORRESPONDING #( lt_orders ).
  ENDMETHOD.


  METHOD if_sadl_exit_calc_element_read~get_calculation_info.
  "TODO: DO I need it? It seems that the functionality works without implementation of this method.
  ENDMETHOD.
ENDCLASS.
