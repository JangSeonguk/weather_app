import 'package:geolocator/geolocator.dart';

class MyLocation {
  double? myLatitude;
  double? myLongitude;

  final LocationSettings locationSettings = const LocationSettings(
    accuracy: LocationAccuracy.high,
    distanceFilter: 100,
  );

  //아래 함수가 비동기적으로 작동하며, 완료될때까지 기다려야함을 확인할 수 있도록ㅍFuture<void> 을 명시합니다. void만 사용하면 안됨.
  //async 사용 시, 내부적으로 Future를 반환하는것은 맞지만, 반환 값이 다른 곳에서 사용될 때는 명확하게 반환값 정보를 전달해야함.
  Future<void> getMyCurrentLocation() async {
    try {
      LocationPermission permission = await Geolocator.checkPermission();
      print(permission);
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        print("request !!!!");
      }
      Position position = await Geolocator.getCurrentPosition(
          locationSettings: locationSettings);
      myLatitude = position.latitude;
      myLongitude = position.longitude;
    } catch (e) {
      print("GPS Error : $e");
    }
  }
}
