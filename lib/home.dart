
import 'package:flutter/material.dart';
import 'package:highlite_flutter_mvp/presentation/bloc/dashboard/auth/authentication_bloc.dart';
import 'package:highlite_flutter_mvp/presentation/bloc/dashboard/auth/authentication_event.dart';
import 'package:highlite_flutter_mvp/presentation/widgets/utils/initial.dart';
class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  @override
  void initState() {
    InitialStater.init().then((value) async {
      authentication.add(const AuthenticateOnStartEvent());
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    authentication.add(const AuthenticateOnStartEvent());
    return const Placeholder();
  }
}
