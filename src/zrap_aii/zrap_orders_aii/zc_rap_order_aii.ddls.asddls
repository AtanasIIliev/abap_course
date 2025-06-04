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
    @Search.defaultSearchElement: true
    @Consumption.valueHelpDefinition : [{ entity : {name: 'ZI_RAP_STATUS_AII', element: 'StatusDescription'}  }]
    @ObjectModel.text.element: [ 'StatusDescription' ]
    Status,
    StatusDescription,
    @EndUserText.label: 'Complexity'
    @ObjectModel.virtualElementCalculatedBy: 'ABAP:ZCL_CALCULATE_ORDER_COMPLEXITY'
    virtual Complexity : abap.string(256),
    @Consumption.valueHelpDefinition: [{ entity : {name: '/DMO/I_Customer', element: 'CustomerID' }  }]
    @ObjectModel.text.element: [ 'CustomerName' ]
    @Search.defaultSearchElement: true
    CustomerId,
    _Customer.LastName as CustomerName,
    @Consumption.valueHelpDefinition: [{ entity : {name: 'I_Country', element: 'Country' }  }]
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
