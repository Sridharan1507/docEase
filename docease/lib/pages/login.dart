// ignore_for_file: use_build_context_synchronously

import 'package:docease_1/auth/auth.state.dart';
import 'package:docease_1/auth/auth_bloc.dart';
import 'package:docease_1/auth/auth_event.dart';
import 'package:docease_1/constant.dart';
import 'package:docease_1/model/auth_response.dart';
import 'package:docease_1/pages/home.dart';
import 'package:docease_1/shared_prefrenec.dart';
import 'package:docease_1/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController userNameTextEditingController = TextEditingController();

  TextEditingController passwordTextEditingController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  AuthBloc authBloc = AuthBloc();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return buildLoginForm();
  }

  Widget buildLoginForm() {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => AuthBloc())
      ],
      // : (context) => AuthBloc(),
      child: Scaffold(
        appBar: AppBar(
            leading: IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.black),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            elevation: 0,
            shape: const Border(
                bottom: BorderSide(color: Color(0xFFf3f5f5), width: 1)),
            title: const Row(
              children: [
                Expanded(
                    child:
                        Text('Log In', style: TextStyle(color: Colors.black))),
              ],
            )),
        body: SafeArea(
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [buildLoginFormList(), buildLoginButton()],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget buildLoginFormList() {
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
      child: Column(
        children: [
          Column(
            children: [
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.only(
                        bottom: 5, top: 7, left: 5, right: 2),
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "User Name",
                      style: Theme.of(context).custom().textBody5_Dark_M,
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(left: 2),
                    child: Text(
                      "*",
                      style: Theme.of(context).custom().textBody2_Red_SB,
                    ),
                  ),
                ],
              ),
              TextFormField(
                controller: userNameTextEditingController,
                showCursor: true,
                style: Theme.of(context).custom().textBody5_Light_M,
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.symmetric(
                      vertical: 10.0, horizontal: 15.0),
                  labelText: 'Enter User Name',
                  labelStyle: Theme.of(context).custom().textBody5_Light_M,
                  enabledBorder: OutlineInputBorder(
                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                    borderSide:
                        BorderSide(color: Constant.borderColorLight!, width: 1),
                  ),
                  errorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(
                      color: Constant.borderColorLight!,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                    borderSide:
                        BorderSide(color: Constant.borderColorLight!, width: 2),
                  ),
                ),
              ),
            ],
          ),
          Column(
            children: [
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.only(
                        bottom: 5, top: 7, left: 5, right: 2),
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Password",
                      style: Theme.of(context).custom().textBody5_Dark_M,
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(left: 2),
                    child: Text(
                      "*",
                      style: Theme.of(context).custom().textBody2_Red_SB,
                    ),
                  ),
                ],
              ),
              Form(
                key: _formKey,
                child: TextFormField(
                  controller: passwordTextEditingController,
                  showCursor: true,
                  style: Theme.of(context).custom().textBody5_Light_M,
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.symmetric(
                        vertical: 10.0, horizontal: 15.0),
                    labelText: 'Enter Password',
                    labelStyle: Theme.of(context).custom().textBody5_Light_M,
                    enabledBorder: OutlineInputBorder(
                      borderRadius: const BorderRadius.all(Radius.circular(10)),
                      borderSide: BorderSide(
                          color: Constant.borderColorLight!, width: 1),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(
                        color: Constant.borderErrorRed!,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: const BorderRadius.all(Radius.circular(10)),
                      borderSide: BorderSide(
                          color: Constant.borderColorLight!, width: 2),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  buildElevatedButtonMedium(
      btnText, btnTextColor, btnColor, btnBorderColor, Function? onPress) {
    return Visibility(
      child: Container(
        width: 150,
        margin: const EdgeInsets.only(left: 10),
        child: ElevatedButton(
          onPressed: onPress as void Function()?,
          style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(btnColor),
              padding: MaterialStateProperty.all(EdgeInsets.zero),
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    side: BorderSide(width: 1, color: btnBorderColor)),
              )),
          child: Center(
            child: Text(btnText,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: btnTextColor,
                  fontSize: 13,
                )),
          ),
        ),
      ),
    );
  }

  Widget buildLoginButton() {
    return Column(
      children: [
        buildAuthBlocWidget(),
        buildElevatedButtonMedium("Login", Constant.buttonNegativeOkColor,
            Constant.buttonColorDark, Constant.buttonColorDark, () async {
//  Navigator.of(context).push(MaterialPageRoute(
//           builder: (BuildContext context) =>
//                MachineConfiguratorScreen( getUserResponseData: null)));

          if (userNameTextEditingController.text.isEmpty) {
            _toast(context, "Please Enter User name");
          } else if (passwordTextEditingController.text.isEmpty) {
            _toast(context, "Plaese enter Password");
          } else {
            AuthRequest authRequest = AuthRequest(
                userName: userNameTextEditingController.text.trim(),
                password: passwordTextEditingController.text.trim());

            authBloc.add(GetAuthTokenEvent(authRequest));
          }
        })
      ],
    );
  }

  void _toast(BuildContext context, String errDesc) async {
    await Future.delayed(const Duration(microseconds: 1));
    if (WidgetsBinding.instance.window.viewInsets.bottom > 0.0) {
      FocusScope.of(context).requestFocus(FocusNode());
    }
   
  }

  _listenerGetTicketDetailsBloc(context, state) {
    if (state is GetAuthTokenLoadingState) {
      print('GetAuthTokenLoadingState');
    } else if (state is GetAuthTokenLoadedState) {
      print('GetAuthTokenLoadedState');
      if (state.authResponse != null) {
              SharedPreference.login(
                  authToken: state.authResponse![0].accessToken.toString(),
                  sessionId: state.authResponse![0].sessionToken.toString(),
                  userNmae: userNameTextEditingController.text.trim(),
                  password: passwordTextEditingController.text.trim());
            }

      Navigator.of(context).push(MaterialPageRoute(
          builder: (BuildContext context) =>
               HomeScreen()));
    } else if (state is GetAuthTokenErrorState) {
      print('GetAuthToken Error');
      _toast(context, state.error);
    }
  }



  Widget buildAuthBlocWidget() {
    return BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          _listenerGetTicketDetailsBloc(context, state);
        },
        bloc: authBloc,
        builder: (context, AuthState state) {
          if (state is GetAuthTokenLoadedState) {
            return const SizedBox();
          }
          return const SizedBox();
        });
  }


}
