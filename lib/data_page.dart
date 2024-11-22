import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

// Data model
class DataModel {
  final String id;
  final String name;

  DataModel({required this.id, required this.name});

  factory DataModel.fromJson(Map<String, dynamic> json) {
    return DataModel(
      id: json['id'].toString(),
      name: json['name'],
    );
  }
}

class DataPage extends StatefulWidget {
  const DataPage({super.key});

  @override
  State<DataPage> createState() => _DataPageState();
}

class _DataPageState extends State<DataPage> {
  Future<List<DataModel>> fetchData() async {
    final response =
        await http.get(Uri.parse('https://jsonplaceholder.typicode.com/users'));

    if (response.statusCode == 200) {
      List<dynamic> jsonList = jsonDecode(response.body);
      return jsonList.map((json) => DataModel.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load data');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<List<DataModel>>(
        future: fetchData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            return ListView.builder(
              itemCount: snapshot.data?.length ?? 0,
              itemBuilder: (context, index) {
                final item = snapshot.data![index];
                return ListTile(
                  title: Text(item.name),
                  subtitle: Text('ID: ${item.id}'),
                );
              },
            );
          }
        },
      ),
    );
  }
}
