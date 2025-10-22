import 'package:flutter/material.dart';

import 'Add_Data.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState(){
    super.initState();
    Future.delayed(
        Duration(seconds: 2),() => Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => AddData(),)),);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(backgroundColor: Colors.black12,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset("assets/image/SQLite-removebg-preview.png")
        ],
      ),
    );
  }
}
