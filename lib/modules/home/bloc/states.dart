abstract class HomeStates {}
class HomeStateInit extends HomeStates{}
class HomeStateLoading extends HomeStates{}
class HomeStateSuccess extends HomeStates{}
class HomeStateSuccessAddress extends HomeStates{}
class HomeStateSuccessLocation extends HomeStates{}
class HomeStateGetAddress extends HomeStates{}
class HomeStateGetLocation extends HomeStates{}
class HomeStateGetWeather extends HomeStates{}
class HomeStateSearch extends HomeStates{
  var error;
  HomeStateSearch(error){
    this.error=error;
  }
}
class HomeStateError extends HomeStates{
  var error;
  HomeStateError(error){
    this.error=error;
  }

}