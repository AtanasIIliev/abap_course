@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Connection View - CDS data model'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity ZAII_I_Connection_R
  as select from /DMO/I_Connection_R

//{
//  key AirlineID,
//  key ConnectionID,
//
////      _Flight.OccupiedSeats
//        sum(_Flight.OccupiedSeats) as TotalOccupiedSeats
//
//}
//where
//      AirlineID    = 'LH'   // Only one connection
//  and ConnectionID = '0400' // fulfills this condition
//
//  group by
//    AirlineID,
//    ConnectionID
 
{
    key AirlineID,
    key ConnectionID,

//        _Airline._Currency._Text.CurrencyName

//        _Airline._Currency._Text[ Language = 'E' ].CurrencyName

        _Airline._Currency._Text[ 1: Language = 'E' ].CurrencyName
  }
where
      AirlineID    = 'AA'
  and ConnectionID = '0017'
  
  
  
  
  
  
  
