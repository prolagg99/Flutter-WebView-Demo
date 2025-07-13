import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_webview_demo/copy_assets_to_temp_dir.dart';
import 'package:webview_flutter/webview_flutter.dart';

import 'local_http_server.dart';
import 'file_utils.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // await copyAssetsToLocalStorage();

  // final server = LocalHttpServer();
  // final url = await server.start();

  // runApp(MyApp(url: '$url/index.html'));

  WidgetsFlutterBinding.ensureInitialized();

  await copyAssetsToTempDir(); // step 1
  final tempDir =
      Directory.systemTemp.listSync().firstWhere(
            (e) => e.path.contains('unity_webgl_'),
          )
          as Directory;

  await startUnityServer(tempDir.path); // step 2

  runApp(MyApp(url: 'http://localhost:8080/index.html'));
}

class MyApp extends StatelessWidget {
  final String url;
  const MyApp({super.key, required this.url});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('Local Web Server')),
        body: CustomWebViewWidget(url: url),
      ),
    );
  }
}

class CustomWebViewWidget extends StatefulWidget {
  final String url;
  const CustomWebViewWidget({super.key, required this.url});

  @override
  State<CustomWebViewWidget> createState() => _CustomWebViewWidgetState();
}

class _CustomWebViewWidgetState extends State<CustomWebViewWidget> {
  late final WebViewController _controller;

  @override
  void initState() {
    super.initState();
    _controller =
        WebViewController()
          ..loadRequest(Uri.parse(widget.url))
          ..setJavaScriptMode(JavaScriptMode.unrestricted);
  }

  @override
  Widget build(BuildContext context) {
    return WebViewWidget(controller: _controller);
  }
}
