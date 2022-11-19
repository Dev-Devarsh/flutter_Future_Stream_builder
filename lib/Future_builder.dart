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
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator();
          } else if (!snapshot.hasData) {
            // if snapShot has no data & 1st if condition is not in your code then [initialData] will be disaplyed by builder
            //and this condition will only work as 1st if condition (to show CircularProgressIndicator) if [initialData] has nullable value
            return const CircularProgressIndicator();
          }
          // above two condition will work same and give same outPut if [initialData] has nullable value
          else if (snapshot.connectionState == ConnectionState.done) {
            return Text(snapshot.data.toString());
          } else if (snapshot.hasData) {
            return Text(snapshot.data.toString());
          }
          // above two condition will work same and give same outPut
          else if (snapshot.hasError) {
            return const Text('error');
          } else {
            return const Text('error');
          }
        },
      ),
    );
  }
}
