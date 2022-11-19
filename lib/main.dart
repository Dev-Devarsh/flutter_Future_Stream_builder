// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:flutter_application_1/Future_builder.dart';
import 'package:flutter_application_1/Stream_builder.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material App',
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Material App Bar'),
        ),
        body: Center(
          child: SingleChildScrollView(
            child: Column(
              children: [
                StreamBuilderExample(),
                Divider(thickness: 10),
                FutureBuilderExample(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
