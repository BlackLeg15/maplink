import 'package:maplink/maplink.dart';
// import 'package:maplink/src/domain/models/zipcode_address_model.dart';
import 'package:maplink/src/presentation/maplink.dart';
import 'package:test/test.dart';

void main() {
  late Maplink model;

  // test("sucesso", () async {
  //   model = Maplink("your-token");
  //   final response = await model.getAddressByZipcodeAndHouseNumber(
  //     "03118030",
  //     "156",
  //   );
  //   expect(response, [
  //     ZipcodeAddressModel(
  //       state: "SP",
  //       city: "São Paulo",
  //       country: "BRA",
  //       district: "Mooca",
  //       streetName: "Rua Guaimbé",
  //       houseNumber: "156",
  //       latitude: "-46.59345",
  //       longitude: "-23.562638",
  //     )
  //   ]);
  // });
  // test("sucesso apenas cep", () async {
  //   model = Maplink("your-token");
  //   final response = await model.getAddressByZipcodeAndHouseNumber("03118030");
  //   expect(response, [
  //     ZipcodeAddressModel(
  //       state: "SP",
  //       city: "São Paulo",
  //       country: "BRA",
  //       district: "Mooca",
  //       streetName: "Rua Guaimbé",
  //       latitude: "-46.592773",
  //       longitude: "-23.56159",
  //     )
  //   ]);
  // });

  // test("sucesso getAddressByStreetName", () async {
  //   model = Maplink("your-token");
  //   final response = await model.getAddressByStreetName(
  //     state: "SP",
  //     city: "São Paulo",
  //     country: "BRA",
  //     streetName: "Rua Guaimbé",
  //   );
  //   expect(
  //     response?.first,
  //     ZipcodeAddressModel(
  //       state: "SP",
  //       city: "São Paulo",
  //       country: "BRA",
  //       district: "Mooca",
  //       streetName: "Rua Guaimbé",
  //       latitude: "-46.592773",
  //       longitude: "-23.56159",
  //     ),
  //   );
  // });

  test("incorrect token error", () {
    model = Maplink("incorrect-token");
    final response = model.getAddressByZipcodeAndHouseNumber("031180301", "156");
    expect(
        response,
        throwsA(ErrorsMaplinkFailure([
          ErrorsMaplinkMessage(
            code: "ERROR",
            errorMessage: "Monitor id not found for token: incorrect-token",
          )
        ])));
  });
}
