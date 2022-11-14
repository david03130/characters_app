import 'package:characters_app/intro_card.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'character_model.dart';
import 'character_list.dart';
import 'new_character_form.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'WCB4 TV',
      theme: ThemeData(brightness: Brightness.dark),
      home: MyHomePage(
        title: 'WCB4 TV Research App',
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  final String title;
  MyHomePage({Key? key, required this.title}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Character> initialCharacters = []..add(Character('Quentin'))..add(Character('Theodore'))..add(Character('Baker'))..add(Character('Mayor'))..add(Character('Keith'));

  Future _showNewDigimonForm() async {
    Character newDigimon = await Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) {
      return AddDigimonFormPage();
    }));
    //print(newDigimon);
    if (newDigimon != null) {
      initialCharacters.add(newDigimon);
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    var key = GlobalKey<ScaffoldState>();
    return Scaffold(
      key: key,
      appBar: AppBar(
        title: Text(widget.title, style: TextStyle(color: Colors.white)),
        centerTitle: true,
        backgroundColor: Color.fromARGB(255, 84, 72, 43),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add),
            onPressed: _showNewDigimonForm,
          ),
        ],
      ),
      body: Container(
          color: Color.fromARGB(255, 163, 157, 127),
          child: Center(
            child: CharacterList(initialCharacters),
          )
          // children: <Widget>[
          //   MyStatelessWidget(),
          //   Container(
          //     child: new Center(
          //       child: new CharacterList(initialCharacters),
          //     )
          //   )
          // ]
          ),
    );
  }
}
