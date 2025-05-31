@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Item BO projection view'
//@Search.searchable: true
@Metadata.allowExtensions: true
@Metadata.ignorePropagatedAnnotations: true

define view entity ZC_RAP_ITEM_AII 
      as projection on ZI_RAP_ITEM_AII as Items
{
    key ItemUuid,
    OrderUuid,
    Name,
    @Semantics.amount.currencyCode: 'CurrencyCode'
    ItemPrice,
//    @Consumption.valueHelpDefinition: [{ entity : {name: 'I_Currency', element: 'Currency' }  }]
    CurrencyCode,
    Quantity,
    CreatedBy,
    CreatedAt,
    LastChangedBy,
    LastChangeAt,
    /* Associations */
    _Currency,
    _Order : redirected to parent ZC_RAP_ORDER_AII
}
