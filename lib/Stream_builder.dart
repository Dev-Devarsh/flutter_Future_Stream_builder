import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

class StreamBuilderExample extends StatefulWidget {
  const StreamBuilderExample({Key? key}) : super(key: key);

  @override
  State<StreamBuilderExample> createState() => _StreamBuilderExampleState();
}

class _StreamBuilderExampleState extends State<StreamBuilderExample> {
  Stream<dynamic> getData() async* {
    // ashync* always work with Stream and it enable[yield]
    // without [async*] yield will not work

    http.Response resp = await http.delete(
        Uri.parse('https://expenseapi.onrender.com/delete?title=devarsh'));
    // log('${json.decode(resp.body)}');
    if (resp.statusCode == 200) {
      dynamic respJson = jsonDecode(resp.body);
      yield respJson;
    } else {
      yield '404';
    }
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: getData(),
        initialData: 0,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator();
          } else if (!snapshot.hasData) {
            // if snapShot has no data & 1st if condition is not in your code then [initialData] will be disaplyed by builder
            //and this condition will only work as 1st if condition (to show CircularProgressIndicator) if [initialData] has nullable value
            return const CircularProgressIndicator();
            // above two condition will work same and give same input if [initialData] has nullable value
          } else if (snapshot.connectionState == ConnectionState.done) {
            return Text(snapshot.data.toString());
          } else if (snapshot.hasData) {
            return Text(snapshot.data.toString());
            // above two condition will work same and give same input
          } else {
            return const Text('error');
          }
        });
  }
}
