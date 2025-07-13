import 'dart:developer';
import 'dart:io';
import 'package:flutter/services.dart';
import 'package:path/path.dart' as p;

Future<void> copyAssetsToTempDir() async {
  final assetBasePath = 'assets/web1';
  final fileList = [
    'index.html',
    'Build/web1.data.br',
    'Build/web1.framework.js.br',
    'Build/web1.loader.js',
    'Build/web1.wasm.br',
    'TemplateData/style.css',
    'TemplateData/favicon.ico',
    'TemplateData/fullscreen-button.png',
    'TemplateData/MemoryProfiler.png',
    'TemplateData/progress-bar-empty-dark.png',
    'TemplateData/progress-bar-full-dark.png',
    'TemplateData/progress-bar-empty-light.png',
    'TemplateData/progress-bar-full-light.png',
    'TemplateData/unity-logo-dark.png',
    'TemplateData/unity-logo-light.png',
    'TemplateData/unity-logo-title-footer.png',
    'TemplateData/webmemd-icon.png',
  ];

  final tempDir = Directory.systemTemp.createTempSync('unity_webgl_');
  for (var filePath in fileList) {
    final assetPath = '$assetBasePath/$filePath';
    final data = await rootBundle.load(assetPath);
    final file = File(p.join(tempDir.path, filePath));
    await file.parent.create(recursive: true);
    await file.writeAsBytes(data.buffer.asUint8List());
  }

  log("Files copied to: ${tempDir.path}");
}
