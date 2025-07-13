import 'dart:developer';
import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:shelf/shelf_io.dart' as shelf_io;
import 'package:shelf_static/shelf_static.dart';

class LocalHttpServer {
  HttpServer? _server;
  final int _port = 8080;

  Future<String> start() async {
    final Directory docDir = await getApplicationDocumentsDirectory();
    final handler = createStaticHandler(
      docDir.path,
      defaultDocument:
          'index.html', // If a user opens http://localhost:8080/, it automatically serves index.html.
      // If a request ends in "/"", it will serve "index.html" by default.
      serveFilesOutsidePath:
          true, // shelf_static restricts serving only inside "docDir.path",
      // "true" removes that limit.
    );

    _server = await shelf_io.serve(handler, 'localhost', _port);
    log('Serving at http://localhost:$_port from ${docDir.path}');
    return 'http://localhost:$_port';
  }

  Future<void> stop() async {
    await _server?.close(force: true);
  }
}
