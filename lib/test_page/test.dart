import 'package:ebroker/main.dart';
import 'package:ebroker/test_page/add_property_page.dart';
import 'package:ebroker/test_page/db.dart';
import 'package:ebroker/test_page/show_all_property_page.dart';
import 'package:flutter/material.dart';

import '../app/routes.dart';

class TestPage extends StatefulWidget {
  const TestPage({super.key});

  @override
  State<TestPage> createState() => _TestPageState();
}

class _TestPageState extends State<TestPage> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Test Page'),
      ),
      body: Column(
        children: [
          Container(child: Center(child: Text('This is a test page'))),
          SizedBox(height: 10),
          ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(
                  context,
                  Routes.selectPropertyTypeScreen,
                );
              },
              child: Text('Add Sample Property')),
          SizedBox(height: 10),
          ElevatedButton(onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (BuildContext context) => ShowAllPropertyPage()));
          }, child: Text('Show all Properties')),
        ],
      ),
    );
  }
}
