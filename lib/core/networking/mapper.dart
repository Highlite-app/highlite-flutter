import 'onboarding_mapper.dart';

class MapperFactory {
  static Map<Type, dynamic Function(dynamic)> constructor = {};

  static void registerConstructor<T>(
    T Function(dynamic) callback,
  ) {
    if (constructor[T] == null) constructor[T] = callback;
  }

  static void initialize(){
    registerOnBoardingConstructors();


  }

  static T? map<T>(dynamic json){
    assert(
       constructor[T] !=null ,
      "A proper constructor callback must be registered for all api model classes . Couldn't find registry for $T" ,
    );
    if(json  == null) return null ;

    return constructor[T]!(json) as T ;
  }

  static T? mapItem<T>(dynamic json , T Function(dynamic) mapper){
    if(json == null) return null ;
    return mapper(json) ;
  }

  static List<T>? mapList<T>(List<dynamic>? json , T Function(dynamic) mapper){
    if(json == null) return null ;
    return json.map<T>(mapper).toList();
  }

}
