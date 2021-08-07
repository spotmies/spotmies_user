import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class PrivacyPolicyWebView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //appBar: AppBar(),
      body: SafeArea(
              child: WebView(
          initialUrl:
              'https://www.privacypolicies.com/live/931def21-ec24-4e98-84c9-1a7be3af4c8a',
          javascriptMode: JavascriptMode.unrestricted,
        ),
      ),
    );
  }
}