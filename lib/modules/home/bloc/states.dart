abstract class HomeStates {}
class HomeStateInit extends HomeStates{}
class HomeStateLoading extends HomeStates{}
class HomeStateSuccess extends HomeStates{}
class HomeStateGetAddress extends HomeStates{}
class HomeStateGetLocation extends HomeStates{}
class HomeStateError extends HomeStates{
  var error;
  HomeStateError(error){
    this.error=error;
  }

}