import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class LoadingScreen extends StatelessWidget {
  const LoadingScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _queryData = MediaQuery.of(context);

    return Scaffold(
      body: Container(
        width: double.infinity,
        height: _queryData.size.height,
        child: const SpinKitWave(
          color: Colors.cyan,
          size: 100,
        ),
      ),
    );
  }
}
