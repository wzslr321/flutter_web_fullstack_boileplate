import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class LoadingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    MediaQueryData queryData = MediaQuery.of(context);

    return Scaffold(
      body: Container(
        width: double.infinity,
        height: queryData.size.height,
        child: SpinKitWave(
          color: Colors.cyan,
          size: 100.0,
        ),
      ),
    );
  }
}
