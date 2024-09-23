import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:highlite_flutter_mvp/presentation/bloc/splash/splash_event.dart';
import 'package:highlite_flutter_mvp/presentation/bloc/splash/splash_state.dart';

class OnBoardingSplashBloc extends Bloc<SplashEvent , SplashState>{

  OnBoardingSplashBloc():super(InitialState());

}