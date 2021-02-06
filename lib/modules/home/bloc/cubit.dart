import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:flutter/services.dart';
import 'package:new_weather_app/model.dart';
import 'package:new_weather_app/modules/home/bloc/states.dart';
import 'package:new_weather_app/shared/const.dart';
import 'package:new_weather_app/shared/network/remote/helper.dart';

class HomeCubit extends Cubit<HomeStates> {
  HomeCubit() : super(HomeStateInit());

  static HomeCubit get(context) => BlocProvider.of(context);
  final Geolocator geolocator = Geolocator()..forceAndroidLocationManager;
  Position _currentPosition;
  Map data = {};
  var currentLocation = '';

  getWeather({city})async {
    emit(HomeStateLoading());
    await DioHelper.getWeather(
        path: WEATHER_END_POINT,
        query: {'q': '$city', 'appid': API_KEY}).then((value)async {
     data =  value.data as Map;
      DataModel(data: data);
     // print('before==>> $data');
      emit(HomeStateSuccess());
    }).catchError((error) {
      print('error===>>>${error.toString()}');
      emit(HomeStateError(error));
    });
  }
  getCurrentLocation() async{
    emit(HomeStateGetLocation());
   await geolocator
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.best)
        .then((Position position) {
          _currentPosition = position;
      _getAddressFromLatLng();
          emit(HomeStateSuccess());
    }).catchError((e) {
     emit(HomeStateError(e));
      print(e);
    });
  }
  _getAddressFromLatLng() async {
    emit(HomeStateGetAddress());
    try {
      List<Placemark> p = await geolocator.placemarkFromCoordinates(
          _currentPosition.latitude, _currentPosition.longitude);
      Placemark place = p[0];
      currentLocation=place.locality;
      print(place.locality);
      emit(HomeStateSuccess());
    } catch (e) {
      emit(HomeStateError(e));
      print(e);
    }
  }
}
