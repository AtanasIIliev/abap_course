@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Travel BO projection view'
//@Metadata.ignorePropagatedAnnotations: true
@Search.searchable: true
@Metadata.allowExtensions: true
define root view entity ZC_RAP_Travel_U_AII 
    as projection on ZI_RAP_Travel_U_AII
{
    //ZI_RAP_TRAVEL_U_AII
    key TravelID,
    @Consumption.valueHelpDefinition: [ { entity: { name: '/DMO/I_Agency', element: 'AgencyID' } } ]
    @Search.defaultSearchElement: true
    AgencyID,
    @Consumption.valueHelpDefinition: [ { entity: { name: '/DMO/I_Customer', element: 'CustomerID' } } ]
    @Search.defaultSearchElement: true
    CustomerID,
    BeginDate,
    EndDate,
    BookingFee,
    TotalPrice,
    @Consumption.valueHelpDefinition: [ { entity: { name: 'I_Currency', element: 'Currency' } } ]
    CurrencyCode,
    Description,
    Status,
    Createdby,
    Createdat,
    Lastchangedby,
    Lastchangedat,
    /* Associations */
    _Agency,
    _Booking : redirected to composition child ZC_RAP_Booking_U_AII, 
    _Currency,
    _Customer
}
