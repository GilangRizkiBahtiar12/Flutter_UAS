import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ListQuote extends StatelessWidget {
  final String apiUrl =
      "https://al-quran-8d642.firebaseio.com/data.json?print=pretty";

  const ListQuote({super.key});

  Future<List<dynamic>> _fetchListQuotes() async {
    var result = await http.get(Uri.parse(apiUrl));
    return json.decode(result.body);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Al-Quran API'),
      ),
      body: FutureBuilder<List<dynamic>>(
        future: _fetchListQuotes(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              padding: const EdgeInsets.all(10),
              itemCount: snapshot.data.length,
              itemBuilder: (BuildContext context, int index) {
                var listTile = ListTile(
                  leading: Image.asset(
                    'background/mekah.jpg',
                    width: 60,
                    height: 60,
                  ),
                  title: Text(
                    snapshot.data[index]['asma'],
                    textAlign: TextAlign.justify,
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "nama: " + snapshot.data[index]['nama'],
                        style: const TextStyle(fontStyle: FontStyle.italic),
                      ),
                      Text(
                        "Arti surat: " + snapshot.data[index]['arti'],
                        style: const TextStyle(fontStyle: FontStyle.italic),
                      ),
                      Text(
                        "Keterangan: " + snapshot.data[index]['keterangan'],
                        style: const TextStyle(fontStyle: FontStyle.italic),
                      ),
                    ],
                  ),
                  trailing: SizedBox(
                    width: 60,
                    child: Row(
                      children: [
                        Text(snapshot.data[index]['nomor'].toString()),
                      ],
                    ),
                  ),
                );
                return Card(
                  child: listTile,
                );
              },
            );
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
