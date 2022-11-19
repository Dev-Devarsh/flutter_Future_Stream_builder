import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class FutureBuilderExample extends StatelessWidget {
  const FutureBuilderExample({
    Key? key,
  }) : super(key: key);
  Future<dynamic> getData() async {
    http.Response resp =
        await http.get(Uri.parse('https://expenseapi.onrender.com/list'));
    // log('${json.decode(resp.body)}');
    if (resp.statusCode == 200) {
      // because data could be list or String
      dynamic respJson = jsonDecode(resp.body);
      return respJson;
    } else {
      return '404';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: FutureBuilder(
        future: getData(),
        initialData: 0,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasError) {
            return const Text('error');
          } else if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator();
          } else {
            return Text('${snapshot.data}');
          }
        },
      ),
    );
  }
}
