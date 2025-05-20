@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Item view'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity ZI_RAP_ITEM_AII 
    as select from zrap_aitems_aii
    
    association        to parent ZI_RAP_ORDER_AII as _Order    on $projection.OrderUuid    = _Order.OrderUuid
    association [0..1] to        I_Currency       as _Currency on $projection.CurrencyCode = _Currency.Currency
{
    key item_uuid as ItemUuid,
    order_uuid as OrderUuid,
    name as Name,
    @Semantics.amount.currencyCode: 'CurrencyCode'
    item_price as ItemPrice,
    currency_code as CurrencyCode,
    quantity as Quantity,
    @Semantics.user.createdBy: true
    created_by as CreatedBy,
    @Semantics.systemDateTime.createdAt: true
    created_at as CreatedAt,
    @Semantics.user.lastChangedBy: true
    last_changed_by as LastChangedBy,
    @Semantics.systemDateTime.lastChangedAt: true 
    last_change_at as LastChangeAt,
    
    /* Associations */
    _Order,
    _Currency
    
}
