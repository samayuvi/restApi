import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Test Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List? posts;
  Future setListPost() async {
    final response =
        await http.get(Uri.parse('https://jsonplaceholder.typicode.com/posts'));
    if (response.statusCode == 200) {
      posts = json.decode(response.body);
    } else {
      posts = null;
      throw Exception('Unable to fetch products from the REST API');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: FutureBuilder(
            future: setListPost(),
            builder: (context, snapshot) {
              return ListView.builder(
                itemCount: posts!.length,
                itemBuilder: (context, index) {
                  return InkWell(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Card(
                          child: Text(posts![index]["title"],
                              style: const TextStyle(
                                fontSize: 18,
                              ))),
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => Scaffold(
                                  body: Center(
                                    child: Text(posts![index]["body"]),
                                  ),
                                )),
                      );
                    },
                  );
                },
              );
            }) // This trailing comma makes auto-formatting nicer for build methods.
        );
  }
}
