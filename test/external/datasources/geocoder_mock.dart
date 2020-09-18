import 'package:http/http.dart';

Response get successResponse => Response(
      _responseMockString,
      200,
      headers: {"Content-Type": "application/json"},
    );
Response get unauthorizedErrorResponse => Response(
      _errorResponseString,
      401,
      headers: {"Content-Type": "application/json; charset=utf-8"},
    );

final _errorResponseString =
    r'{"message": "[{\"Code\":\"INVALID_APP_CODE_OR_TOKEN\",\"Message\":\"The informed token or application code [c1vjeJ2A5mUE5m2jNJUtNGY6OXt6NXK] is not valid\"}]"}';
final _responseMockString = '''{"addresses": [$responseMockSingleString]}''';
final responseMockSingleString = '''{
    "country": {
        "countryCode": "BRA"
    },
    "state": {
        "shortName": "SP",
        "name": "São Paulo"
    },
    "city": {
        "name": "São Paulo"
    },
    "citySubdivision": {
        "name": "Jardim Paulista"
    },
    "district": {
        "name": "Jardim Paulista"
    },
    "addressLine": {
        "houseNumber": "365",
        "location": {
            "type": "Point",
            "coordinates": [
                -46.652355,
                -23.564986
            ]
        },
        "name": "Alameda Campinas"
    },
    "matchingScore": 100.0,
    "matchLevel": "approximatedAddress",
    "consideredFields": "state,city,district,streetName,houseNumber,postalCode"
}''';