@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Travel BO projection view'
@Search.searchable: true
@Metadata.allowExtensions: true

define root view entity ZC_RAP_TRAVEL_AII 
    as projection on ZI_RAP_Travel_AII as Travel
{
    key TravelUUID,
    @Search.defaultSearchElement: true
    TravelID,
    @Consumption.valueHelpDefinition: [{ entity : {name: '/DMO/I_Agency', element: 'AgencyID' }  }]
    @ObjectModel.text.element: [ 'AgencyName' ]
    @Search.defaultSearchElement: true
    AgencyID,
    _Agency.Name as AgencyName,
    @Consumption.valueHelpDefinition: [{ entity : {name: '/DMO/I_Customer', element: 'CustomerID' }  }]
    @ObjectModel.text.element: [ 'CustomerName' ]
    @Search.defaultSearchElement: true
    CustomerID,
    _Customer.LastName as CustomerName,
    BeginDate,
    EndDate,
    @Semantics.amount.currencyCode: 'CurrencyCode'
    BookingFee,
    @Semantics.amount.currencyCode: 'CurrencyCode'
    TotalPrice,
    @Consumption.valueHelpDefinition: [{ entity : {name: 'I_Currency', element: 'Currency' }  }]
    CurrencyCode,
    Description,
    TravelStatus,
    CreatedBy,
    CreatedAt,
    LastChangedBy,
    LastChangedAt,
    LocalLastChangedAt,
    /* Associations */
    _Agency,
    _Booking : redirected to composition child ZC_RAP_Booking_AII,
    _Currency,
    _Customer
}
