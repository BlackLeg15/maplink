import 'package:http/http.dart';
import 'package:maplink/src/external/datasources/geocoder_datasource_impl.dart';
import 'package:maplink/src/external/errors/geocoder_errors.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

import 'geocoder_mock.dart';

class MockClient extends Mock implements Client {}

class UriFake extends Fake implements Uri {}

void main() {
  late MockClient client;
  late GeocoderDatasourceImpl datasource;
  setUp(() {
    client = MockClient();
    datasource = GeocoderDatasourceImpl(client);
  });

  setUpAll(() {
    registerFallbackValue<Uri>(UriFake());
  });

  test("success", () async {
    when(() => client.get(any())).thenAnswer((realInvocation) async => successResponse);
    final content = await datasource.getAddressByZipcodeAndHouseNumber(
      "mock-token",
      "mock-zipcode",
      "mock-number",
    );
    expect(content.length, 1);
    // expect(content, isA<List<ZipcodeAddressModel>>());
  });
  group("multiple error message", () {
    test("invalid token error", () async {
      final error = ErrorsMaplinkFailure([
        ErrorsMaplinkMessage(
          code: "INVALID_APP_CODE_OR_TOKEN",
          errorMessage: "The informed token or application code [your-token] is not valid",
        )
      ]);
      when(() => client.get(any())).thenAnswer((realInvocation) async => unauthorizedErrorResponse);
      final content = datasource.getAddressByZipcodeAndHouseNumber(
        "mock-token",
        "mock-zipcode",
        "mock-number",
      );
      expect(content, throwsA(error));
    });
  });

  group("single error message", () {
    test("invalid country", () async {
      final error = ErrorsMaplinkFailure([
        ErrorsMaplinkMessage(
          code: "ERROR",
          errorMessage: "[BRAA] is an invalid ISO 3166-1 alpha-3 country code or there is no geocoding for the country",
        )
      ]);
      when(() => client.get(any())).thenAnswer((realInvocation) async => invalidCountryErrorResponse);
      final content = datasource.getAddressByStreetName(
        "mock-token",
        "mock-country",
        "mock-city",
        "mock-state",
        "mock-streetName",
        "mock-houseNumber",
      );
      expect(content, throwsA(error));
    });
  });
}
