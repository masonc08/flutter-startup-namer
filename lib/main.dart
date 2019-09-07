// Copyright 2018 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'dart:convert';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';
import 'package:http/http.dart' as http;
import 'dart:async';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Startup Name Generator',
      home: RandomWords(),
    );
  }
}

class RandomWords extends StatefulWidget {
  //stateful widgets don't do much asides from calling its state class
  @override
  RandomWordsState createState() => RandomWordsState();
}

class RandomWordsState extends State<RandomWords> {
  Future<String> _loadHTML(url) async {
    http.Response response = await http.post(url);
//    return jsonDecode(response.body)['data'];
    return response.body;
  }
  final _url = "https://www.randomlists.com/data/verbs.json";
  final _fontSize = const TextStyle(fontSize: 18.0);
  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text('Church'),
        ),
      ),
      body: FutureBuilder(
        future: _loadHTML(_url),
        builder: (context, body){
          var verbs = jsonDecode(body.data.toString())['data'];
          return _buildSuggestions(verbs);
        }
      )
    );
  }
  Widget _buildSuggestions(body) {
    return ListView.builder(
      padding: const EdgeInsets.all(16.0),
      itemBuilder: (context, i) {
        if (i.isOdd) return Divider();
        final index = i~/2;
        Random rand = new Random();
        return _buildRow(index, body[rand.nextInt(body.length)]);
      }
    );
  }
  Widget _buildRow(index, verb){
    String displayText = '${index + 1}. succ $verb sydney';
    return ListTile(
      title: Text(
        displayText,
        style: _fontSize,
      ),
    );
  }
}