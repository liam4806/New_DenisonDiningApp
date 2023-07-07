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
          shape: const Border(
            bottom: BorderSide(
              color: Color(0xffb71c1c),
              width: 2,
            ),
          ),
          iconTheme: const IconThemeData(
            color: Color(0xffb71c1c),
          ),
          backgroundColor: Colors.grey[50],
          elevation: 2,
          title: Text(
            widget.appbartitle,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Color(0xffb71c1c),
              fontFamily: 'merri',
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
