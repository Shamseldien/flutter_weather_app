import 'package:dio/dio.dart';

class DioHelper{

  static Dio dio;

  DioHelper(){
    dio = Dio(BaseOptions(baseUrl: 'http://api.openweathermap.org/'));
  }

 static Future<Response>getWeather({path,query})async{
   return await  dio.get(path,queryParameters: query);
  }

}