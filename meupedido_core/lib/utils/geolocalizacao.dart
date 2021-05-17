import 'package:geolocator/geolocator.dart';

Future<double> getGEO_Distancia(
  double startLatitude,
  double startLongitude,
  double endLatitude,
  double endLongitude,
) async {
  ///////
  if (startLatitude == null ||
      startLongitude == null ||
      endLatitude == null ||
      endLongitude == null) return null;
  //////

  return Geolocator.distanceBetween(
    startLatitude,
    startLongitude,
    endLatitude,
    endLongitude,
  );
}

Future<List<double>> getGEO_DoEndereco(String endereco) async {
  if (endereco.isEmpty) return null;

  // List<Placemark> placemarks;

  // try {
  //   placemarks = await GeolocatorPlatform.placemarkFromAddress(endereco,
  //       localeIdentifier: 'pt_BR');
  // } catch (e) {
  //   return null;
  // }

  // List<double> result = [];
  // result.add(placemarks[0].position.latitude);
  // result.add(placemarks[0].position.longitude);

  // return result;

  return null;
}

Future<List<double>> getGEO_LocalAtual() async {
  //var permissao =
  await Geolocator.checkPermission();

  Position position;

  try {
    // final Geolocator geolocator = Geolocator()..forceAndroidLocationManager;
    //
    position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.best);
  } catch (e) {
    return null;
  }

  List<double> result = [];
  result.add(position.latitude);
  result.add(position.longitude);

  return result;
}
