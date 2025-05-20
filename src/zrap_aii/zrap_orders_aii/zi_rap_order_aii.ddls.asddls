@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Order view'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define root view entity ZI_RAP_ORDER_AII 
       as select from zrap_aorders_aii
  
  composition [1..*] of ZI_RAP_ITEM_AII    as _Item
  
  association [0..1] to /DMO/I_Customer    as _Customer on $projection.CustomerId      = _Customer.CustomerID
  association [0..1] to I_Currency         as _Currency on $projection.CurrencyCode    = _Currency.Currency
  association [0..1] to I_Country          as _Country  on $projection.DeliveryCountry = _Country.Country
  association [0..1] to ZI_RAP_STATUS_AII  as _Status   on $projection.Status          = _Status.StatusId
  
{
    key order_uuid as OrderUuid,
    order_id as OrderId,
    name as Name,
    status as Status,
    _Status.StatusDescription,
    customer_id as CustomerId,
    delivery_country as DeliveryCountry,
    @Semantics.amount.currencyCode: 'CurrencyCode'
    total_price as TotalPrice,
    currency_code as CurrencyCode,
    creation_dt as CreationDt,
    cancellation_dt as CancellationDt,
    completion_dt as CompletionDt,
    @Semantics.user.createdBy: true
    created_by as CreatedBy,
    @Semantics.systemDateTime.createdAt: true
    created_at as CreatedAt,
    @Semantics.user.lastChangedBy: true
    last_changed_by as LastChangedBy,
    @Semantics.systemDateTime.lastChangedAt: true 
    last_change_at as LastChangeAt,
    
    /* Associations */
    _Item,
    _Customer,
    _Currency,
    _Country,
    _Status
    
}
