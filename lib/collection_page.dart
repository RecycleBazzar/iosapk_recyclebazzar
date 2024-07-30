import 'package:flutter/material.dart';

class CollectionPage extends StatelessWidget {
  final String pageTitle;

  // Constructor includes Key? type for the key and a String for pageTitle
  const CollectionPage({Key? key, required this.pageTitle}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(pageTitle),
        backgroundColor: Colors.green,
      ),
      body: Center(
        child: Text('Collection Page for $pageTitle'),
      ),
    );
  }
}
