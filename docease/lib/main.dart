import 'dart:math';
import 'package:docease_1/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:zego_uikit_prebuilt_call/zego_uikit_prebuilt_call.dart';
import 'package:get/get.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'DocEase',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.white),
        useMaterial3: true,
      ),
      home: const SplashScreen(),
    );
  }
}

class CallPage extends StatelessWidget {
  const CallPage({Key? key, required this.callID}) : super(key: key);
  final String callID;

  @override
  Widget build(BuildContext context) {
    int userID =Random().nextInt(100000);
    return ZegoUIKitPrebuiltCall(
      appID: 1550726564, // Fill in the appID that you get from ZEGOCLOUD Admin Console.
      appSign: "3cbe941ce7b5b12b87f0a786993dc14cb4df545f907612a8be8bc98620443eb5", // Fill in the appSign that you get from ZEGOCLOUD Admin Console.
      userID: userID.toString(),
      userName: 'user$userID',
      callID: callID,
      // You can also use groupVideo/groupVoice/oneOnOneVoice to make more types of calls.
      config: ZegoUIKitPrebuiltCallConfig.oneOnOneVideoCall(),
    );
  }
}


