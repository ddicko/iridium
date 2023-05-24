import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:iridium_reader_widget/views/viewers/epub_screen.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Epub Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Epub Demo'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Future<File> getFileFromAsset(String asset) async {
    ByteData data = await rootBundle.load(asset);
    String dir = (await getTemporaryDirectory()).path;
    String path = '$dir/${basename(asset)}';
    if (!File(path).existsSync()) {
      final buffer = data.buffer;
      return File(path).writeAsBytes(buffer.asUint8List(data.offsetInBytes, data.lengthInBytes));
    } else {
      return File(path);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: ElevatedButton(
          child: const Text("Open Epub File"),
          onPressed: () async {
            var epubFileName = "assets/bookfile.epub";
            var epubFilePath = (await getFileFromAsset(epubFileName)).path;
            if (context.mounted) {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => EpubScreen.fromPath(filePath: epubFilePath, theme: "dark"),
                  ));
            }
          },
        ),
      ),
    );
  }
}
