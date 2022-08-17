import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_lorem/flutter_lorem.dart';

class AboutUs extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(
            'AboutUs',
          )),
      body:



      CustomScrollView(
        slivers: [
          SliverFillRemaining(
            hasScrollBody: false,
            child:  Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child : Text('${lorem(paragraphs: 2, words: 60)}'),)

              ],

            ),
          ),
        ],




      )











    );
  }
}
