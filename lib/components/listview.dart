import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;

class Listview extends StatefulWidget {
  const Listview({super.key});

  @override
  State<Listview> createState() => _ListviewState();
}

class _ListviewState extends State<Listview> {
  List users = [];
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const Center(
          child: Text(
            'Users Details',
            style: TextStyle(fontSize: 30, color: Colors.white),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: getData,
        splashColor: Colors.green,
        backgroundColor: Colors.blue,
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : users.isEmpty
              ? const Center(
                  child: Text("List is empty"),
                )
              : ListView.builder(
                  itemCount: users.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              const Text(
                                'ID No.',
                                style: TextStyle(
                                    fontSize: 17, fontWeight: FontWeight.w600),
                              ),
                              Text(
                                style: const TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.w600),
                                users[index]["id"].toString(),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              const Text(
                                'Name : ',
                                style: TextStyle(
                                    fontSize: 22, fontWeight: FontWeight.w600),
                              ),
                              Text(
                                style: const TextStyle(
                                    fontSize: 22, fontWeight: FontWeight.w600),
                                users[index]["name"].toString(),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              const Text(
                                'Username : ',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w800,
                                ),
                              ),
                              Text(
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w800,
                                ),
                                users[index]["username"].toString(),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              const Text(
                                'Phone : ',
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.w800),
                              ),
                              Text(
                                style: const TextStyle(
                                  fontSize: 19,
                                  fontWeight: FontWeight.w800,
                                ),
                                users[index]["phone"].toString(),
                              ),
                            ],
                          ),
                        ],
                      ),
                    );
                  },
                ),
    );
  }

  void getData() async {
    print('getData called');
    setState(() {
      isLoading = true;
    });
    const url = 'https://jsonplaceholder.typicode.com/users';
    final uri = Uri.parse(url);
    final response = await http.get(uri);
    final body = response.body;
    final data = json.decode(body);
    setState(() {
      users = data;
      isLoading = false;
    });
    print('FetchUsers completed');
  }
}
