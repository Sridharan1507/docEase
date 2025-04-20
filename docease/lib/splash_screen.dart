import 'dart:async';

import 'package:docease_1/auth/auth.state.dart';
import 'package:docease_1/auth/auth_bloc.dart';
import 'package:docease_1/auth/auth_event.dart';
import 'package:docease_1/constant.dart';
import 'package:docease_1/model/auth_response.dart';
import 'package:docease_1/pages/home.dart';
import 'package:docease_1/pages/signin.dart';
import 'package:docease_1/shared_prefrenec.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<AuthBloc>(
        create: (context) => AuthBloc(), child: const SplashScreenFul());
  }
}

class SplashScreenFul extends StatefulWidget {
  const SplashScreenFul({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return SplashWidgetScreen();
  }
}

class SplashWidgetScreen extends State<SplashScreenFul> {
  AuthBloc authBloc = AuthBloc();

  @override
  void initState() {
    super.initState();
    authBloc = BlocProvider.of<AuthBloc>(context);
    // userBloc =BlocProvider.of<UserBloc>(context);

    getSession();
  }

  getSession() async {
    String userName = await SharedPreference.getUserName();
    String password = await SharedPreference.getPassword();
    print("userName $userName");
    print("password $password");
    if (userName.isNotEmpty && password.isNotEmpty) {
      authBloc.add(GetAuthTokenEvent(
          AuthRequest(userName: userName, password: password)));
    } else {
      navigatePage();
    }
  }

  navigatePage()async {
     String userName = await SharedPreference.getUserName();
    String password = await SharedPreference.getPassword();
    if(userName.isNotEmpty && password.isNotEmpty){
        Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (BuildContext context) => dashboard));
    }
    else{
 Timer(
        const Duration(seconds: 2),
        () => Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (BuildContext context) => signUp),
            ));
    }
   
  }

  @override
  void dispose() {
    super.dispose();
    if (!authBloc!.isClosed) {
      authBloc!.close();
    }
  }

  final signUp = const SignInScreen();
  final dashboard = HomeScreen();

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => AuthBloc()),
      ],
      child: BlocConsumer(
        listener: (context, state) {
          if (state is GetAuthTokenLoadedState) {
              navigatePage();
            }
        },
          bloc: authBloc,
          builder: (context, AuthState state) {
            if (state is GetAuthTokenLoadedState) {
              SharedPreference.saveAuthToken(
                  state.authResponse![0].accessToken.toString());
                 
            }
           
            // if (state is AuthInitialState) {
            //   return _splash(context);
            //   //debugPrint("Inside AuthInitialState");
            // }
            if (state is GetAuthTokenLoadingState) {
              print('GetAuthTokenLoadingState');
            } else if (state is GetAuthTokenErrorState) {
              print('GetAuthToken Error');
              navigateSignup();
            }
            return _splash(context);

            // return _splash(context);
          }),
    );
  }
   navigateSignup() async {
    await SharedPreference.logout();
    Timer(
        const Duration(seconds: 2),
        () => Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (BuildContext context) => signUp),
            ));
  }

  Widget _splash(BuildContext context) {
    return Container(
      color: Colors.grey.shade100,
      child: Stack(
        children: <Widget>[
          Align(
              alignment: Alignment.center,
              child: Container(
                width: MediaQuery.of(context).size.width * 0.5,
                height: MediaQuery.of(context).size.height * 0.3,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  image: DecorationImage(
                    image: AssetImage(Constant.splashlogo1),
                    fit: BoxFit.contain,
                    alignment: Alignment.center,
                  ),
                ),
              )),
        ],
      ),
    );
  }
}
