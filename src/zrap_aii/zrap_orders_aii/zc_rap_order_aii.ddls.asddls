@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Order BO projection view'
@Search.searchable: true
@Metadata.allowExtensions: true
@Metadata.ignorePropagatedAnnotations: true

define root view entity ZC_RAP_ORDER_AII 
       as projection on ZI_RAP_ORDER_AII as Orders
{
    key OrderUuid,
    @Search.defaultSearchElement: true
    OrderId,
    Name,
    @Consumption.valueHelpDefinition : [{ entity : {name: 'ZI_RAP_STATUS_AII', element: 'StatusDescription' }  }]
    @ObjectModel.text.element: [ 'Status' ]
    Status,
    _Status.StatusDescription,
//    @ObjectModel.virtualElementCalculatedBy: ''
//    @EndUserText.label: 'Complexity'
//    virtual Complexity : abap.string(16),
    @Consumption.valueHelpDefinition: [{ entity : {name: '/DMO/I_Customer', element: 'CustomerID' }  }]
    @ObjectModel.text.element: [ 'CustomerName' ]
    @Search.defaultSearchElement: true
    CustomerId,
    _Customer.LastName as CustomerName,
    @Consumption.valueHelpDefinition: [{ entity : {name: 'I_Country', element: 'Country' }  }]
    //@ObjectModel.text.element: [ 'DeliveryCountry' ] //TODO: Ask why when this is not comment a error check appears (3 characters and space - data element?)
    @Search.defaultSearchElement: true
    DeliveryCountry,
    @Semantics.amount.currencyCode: 'CurrencyCode'
    TotalPrice,
    @Consumption.valueHelpDefinition: [{ entity : {name: 'I_Currency', element: 'Currency' }  }]
    CurrencyCode,
    @Search.defaultSearchElement: true
    CreationDt,
    CancellationDt,
    CompletionDt,
    CreatedBy,
    CreatedAt,
    LastChangedBy,
    LastChangeAt,
    /* Associations */
    _Country,
    _Currency,
    _Customer,
    _Item : redirected to composition child ZC_RAP_ITEM_AII,
    _Status
}
