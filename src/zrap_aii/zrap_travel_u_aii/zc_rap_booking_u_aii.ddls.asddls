@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Booking BO projection view'
//@Metadata.ignorePropagatedAnnotations: true
@Search.searchable: true
@Metadata.allowExtensions: true
define view entity ZC_RAP_Booking_U_AII as projection on ZI_RAP_Booking_U_AII
{
      //ZI_RAP_BOOKING_U_AII
      @Search.defaultSearchElement: true
  key TravelID,
      @Search.defaultSearchElement: true
  key BookingID,
      BookingDate,
      @Consumption.valueHelpDefinition: [ { entity: { name:     '/DMO/I_Customer',
                                                   element:     'CustomerID' } } ]
      CustomerID,
      @Consumption.valueHelpDefinition: [ { entity: { name:     '/DMO/I_Carrier',
                                                   element:     'AirlineID' } } ]
      CarrierID,
      @Consumption.valueHelpDefinition: [ { entity: { name:    '/DMO/I_Flight',
                                                      element: 'ConnectionID' },
                                            additionalBinding: [ { localElement: 'FlightDate',
                                                                   element:      'FlightDate',
                                                                   usage: #RESULT }, 
                                                                 { localElement: 'CarrierID',
                                                                        element: 'AirlineID',
                                                                          usage: #RESULT }, 
                                                                 { localElement: 'FlightPrice',
                                                                        element: 'Price',
                                                                          usage: #RESULT }, 
                                                                 { localElement: 'CurrencyCode',
                                                                        element: 'CurrencyCode',
                                                                          usage: #RESULT } ] 
                                            } ]
      ConnectionID,
      FlightDate,
      FlightPrice,
      @Consumption.valueHelpDefinition: [ {entity: { name:    'I_Currency',
                                                     element: 'Currency' } } ]
      CurrencyCode,
      
      /* Associations */   
      _Carrier,
      _Customer,
      _Travel : redirected to parent ZC_RAP_Travel_U_AII
}
