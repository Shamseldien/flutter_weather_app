import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:flutter/services.dart';
import 'package:new_weather_app/models/model.dart';
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

  Future<void>getWeather({city})async {
    emit(HomeStateLoading());
      try {
        await DioHelper.getWeather(
            path: WEATHER_END_POINT,
            query: {
              'q': '$city',
              'units':'metric',
              'appid': API_KEY}).then((value)async {
          data =  value.data as Map;
          DataModel(data: data);
          print('before==>> ${DataModel.getCountry()}');
          emit(HomeStateGetWeather());
        }).catchError((error) {
          print('error===>>>${error.toString()}');
          emit(HomeStateError(error));
        });
      } on Exception catch (e) {
        print(e.toString());
        emit(HomeStateError(e.toString()));
      }

  }
  getCurrentLocation() async{
    emit(HomeStateGetLocation());
   await geolocator
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.best)
        .then((Position position) {
          _currentPosition = position;
      getAddressFromLatLng().then((value){
        getWeather(city: value).then((value){
          emit(HomeStateGetWeather());
        });

      });
          emit(HomeStateSuccessLocation());
    }).catchError((e) {
     emit(HomeStateError(e));
      print(e);
    });

  }
  Future<String>getAddressFromLatLng() async {
    emit(HomeStateGetAddress());
    var myPlace ;
    try {
      List<Placemark> p = await geolocator.placemarkFromCoordinates(
          _currentPosition.latitude, _currentPosition.longitude);
      Placemark place = p[0];
      currentLocation=place.locality;
      myPlace = place.locality;
      emit(HomeStateSuccessAddress());
      print(place.locality);
    } catch (e) {
      emit(HomeStateError(e));
      print(e);
    }
    return myPlace;
  }
}
