// import 'dart:convert';
// import 'dart:developer';
// import 'dart:io';
// import 'package:flutter/services.dart';
// import 'package:path/path.dart' as p;
// import 'package:path_provider/path_provider.dart';

// Future<void> copyAssetsToLocalStorage() async {
//   final docDir = await getApplicationDocumentsDirectory();
//   final manifestContent = await rootBundle.loadString('AssetManifest.json');
//   final manifestMap = json.decode(manifestContent) as Map<String, dynamic>;

//   final assetPaths =
//       manifestMap.keys.where((key) => key.startsWith('assets/')).toList();

//   for (final assetPath in assetPaths) {
//     final relativePath = assetPath.replaceFirst('assets/', '');
//     final file = File(p.join(docDir.path, relativePath));

//     if (!await file.exists()) {
//       await file.create(recursive: true);
//       final data = await rootBundle.load(assetPath);
//       await file.writeAsBytes(data.buffer.asUint8List());
//       log('✅ Copied: $assetPath ➜ ${file.path}');
//     } else {
//       log('ℹ️ Already exists: ${file.path}');
//     }
//   }
// }

import 'package:shelf/shelf_io.dart' as shelf_io;
import 'package:shelf_static/shelf_static.dart';

Future<void> startUnityServer(String servePath) async {
  final handler = createStaticHandler(
    servePath,
    defaultDocument: 'index.html',
    serveFilesOutsidePath: true,
  );

  final server = await shelf_io.serve(handler, 'localhost', 8080);
  print('Serving Unity WebGL on http://${server.address.host}:${server.port}');
}
