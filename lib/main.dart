import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(LatihanApi());
}

class LatihanApi extends StatefulWidget {
  const LatihanApi({super.key});

  @override
  State<LatihanApi> createState() => _LatihanApiState();
}

class _LatihanApiState extends State<LatihanApi> {
  var data = [];

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    final apiUrl =
        "http://localhost/api/data.php"; // Ganti dengan URL API PHP Anda

    final response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      final ready = json.decode(response.body);
      data.addAll(ready);
      print(data);
      // setState(() {
      //   data = List<Map<String, dynamic>>.from(ready);
      //   print(data);
      // });
    } else {
      print("Gagal mengambil data dari API.");
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text("Flutter Rest API"),
          centerTitle: true,
        ),
        body: Center(
            child: data.isNotEmpty
                ? ListView.builder(
                    itemCount: data.length,
                    itemBuilder: (context, index) {
                      final productItem = data[index];
                      print(productItem);
                      return ListTile(
                        contentPadding: EdgeInsets.fromLTRB(5, 5, 5, 0),
                        focusColor: Colors.amber,
                        leading: Container(
                          decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                              border: Border.all(
                                  width: 1,
                                  color: Colors.black,
                                  style: BorderStyle.solid)),
                          margin: EdgeInsets.fromLTRB(2, 5, 2, 0),
                          height: 100,
                          width: 100,
                          child: Image.network(
                            productItem['image'],
                            fit: BoxFit.cover,
                          ),
                        ),
                        title: Text(
                          productItem['produk'],
                          style: TextStyle(fontSize: 15),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        subtitle: Text(
                          productItem['keterangan'],
                          style: TextStyle(fontSize: 15),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      );
                    })
                : CircularProgressIndicator()),
      ),
    );
  }
}
