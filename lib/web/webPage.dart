import 'package:NearCard/web/homePage.dart';
import 'package:NearCard/web/userPage.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:cloud_functions/cloud_functions.dart';

FirebaseFunctions functions =
    FirebaseFunctions.instanceFor(region: 'europe-west3');

String getParameterValue() {
  try {
    String parameterValue = "";
    if (kIsWeb) {
      parameterValue = Uri.base.queryParameters['userId'] ?? "";
    }
    return parameterValue;
  } catch (e) {
    return "";
  }
}

class WebPage extends StatelessWidget {
  const WebPage({super.key});

  @override
  Widget build(BuildContext context) {
    String userId = getParameterValue();
    return MaterialApp(
      title: 'NearCard',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: userId == ''
          ? const HomePage()
          : UserPage(
              visitedUserId: userId,
            ),
    );
  }
}
