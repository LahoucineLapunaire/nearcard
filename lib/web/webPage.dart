import 'dart:js_interop';

import 'package:NearCard/web/homePage.dart';
import 'package:NearCard/web/userPage.dart';
import 'package:flutter/material.dart';
import 'dart:html' as html;
import 'package:cloud_functions/cloud_functions.dart';

FirebaseFunctions functions =
    FirebaseFunctions.instanceFor(region: 'europe-west3');
final uri = Uri.parse(html.window.location.href);
final parameterValue = uri.queryParameters['userId'];

class WebPage extends StatelessWidget {
  const WebPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'NearCard',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: parameterValue == null || parameterValue == ''
          ? HomePage()
          : UserPage(
              visitedUserId: parameterValue ?? "",
            ),
    );
  }
}
