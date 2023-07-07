import 'package:webview_flutter/webview_flutter.dart';
import 'package:flutter/material.dart';

class MenuWebView extends StatefulWidget {
  const MenuWebView({
    Key? key,
    required this.dininglink,
    required this.appbartitle,
  }) : super(key: key);

  final String dininglink;
  final String appbartitle;

  @override
  State<MenuWebView> createState() => _MenuWebViewState();
}

class _MenuWebViewState extends State<MenuWebView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          iconTheme: const IconThemeData(
            color: Colors.black,
          ),
          backgroundColor: Colors.grey[50],
          elevation: 2,
          title: Text(
            widget.appbartitle,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontFamily: 'merri',
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 25,
            ),
          ),
        ),
        body: SafeArea(
          child: WebView(
            initialUrl: widget.dininglink,
            javascriptMode: JavascriptMode.unrestricted,
          ),
        ));
  }
}
