import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../utils/global.dart';
import '../../../../utils/helper/apihelper.dart';

class Homescreen extends StatefulWidget {
  const Homescreen({super.key});

  @override
  State<Homescreen> createState() => _HomescreenState();
}

List finalProduct = [];

class _HomescreenState extends State<Homescreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushNamed(
                context,
                'details',
              );
            },
            icon: Icon(Icons.add_shopping_cart),
          ),
        ],
      ),
      body: FutureBuilder(
        future: ApiHelper.apiHelper.fetchData(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text("${snapshot.error}"),
            );
          } else if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data?.length,
              itemBuilder: (context, index) {
                return Card(
                  child: ListTile(
                    onTap: () {
                      Navigator.pushNamed(context, 'details',
                          arguments: snapshot.data![index]);
                    },
                    title: Text(
                      snapshot.data![index].title,
                    ),
                    subtitle: Text(
                      snapshot.data![index].artist,
                    ),
                    leading: CircleAvatar(
                      foregroundImage: NetworkImage(
                        snapshot.data![index].image,
                      ),
                    ),
                  ),
                );
              },
            );
          }
          return Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
