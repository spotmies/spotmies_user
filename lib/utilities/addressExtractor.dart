import 'dart:developer';

addressExtractor(address, double lati, double longi) {
  Map<String, String> val = {
    "subLocality": "${address.subLocality}",
    "locality": "${address.locality}",
    "latitude": "${lati}",
    "logitude": "${longi}",
    "street": "${address.street}",
    "subAdminArea": "${address.subAdministrativeArea}",
    "postalCode": "${address.postalCode}",
    "adminArea": "${address.administrativeArea}",
    "name": "${address.name}",
    "isoCountryCode": "${address.isoCountryCode}",
    // "thoroughfare": "${address.Thoroughfare}",
  };
  log(val.toString());
  return val;
}
