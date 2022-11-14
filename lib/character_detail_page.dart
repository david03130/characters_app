import 'package:flutter/material.dart';
import 'character_model.dart';
import 'dart:async';


class CharacterDetailPage extends StatefulWidget {
  final Character character;
  CharacterDetailPage(this.character);

  @override
  _CharacterDetailPageState createState() => new _CharacterDetailPageState();
}

class _CharacterDetailPageState extends State<CharacterDetailPage> {
  final double digimonAvarterSize = 150.0;
  double _sliderValue = 10.0;

  Widget get addYourRating {
    return new Column(
      children: <Widget>[
        new Container(
          padding: new EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
          child: new Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              new Flexible(
                flex: 1,
                child: new Slider(
                  activeColor: Color.fromARGB(255, 19, 109, 52),
                  min: 0.0,
                  max: 10.0,
                  value: _sliderValue,
                  onChanged: (newRating) {
                    setState(() {
                      _sliderValue = newRating;
                    });
                  },
                ),
              ),
              new Container(
                  width: 50.0,
                  alignment: Alignment.center,
                  child: new Text(
                    '${_sliderValue.toInt()}',
                    style: TextStyle(color: Colors.black, fontSize: 25.0),
                  )),
            ],
          ),
        ),
        submitRatingButton,
      ],
    );
  }

  void updateRating() {
    if (_sliderValue < 5) {
      _ratingErrorDialog();
    } else {
      setState(() {
        widget.character.rating = _sliderValue.toInt();
      });
    }
  }

  Future<Null> _ratingErrorDialog() async {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return new AlertDialog(
            title: new Text('Error!'),
            content: new Text("Come on! They're good!"),
            actions: <Widget>[
              new TextButton(
                child: new Text('Try Again'),
                onPressed: () => Navigator.of(context).pop(),
              )
            ],
          );
        });
  }

  Widget get submitRatingButton {
    return new ElevatedButton(
      onPressed: () => updateRating(),
      child: new Text('Submit'),
    );
  }

  Widget get digimonImage {
    return new Hero(
      tag: widget.character,
      child: new Container(
        height: digimonAvarterSize,
        width: digimonAvarterSize,
        constraints: new BoxConstraints(),
        decoration: new BoxDecoration(
            shape: BoxShape.circle,
            boxShadow: [
              const BoxShadow(offset: const Offset(1.0, 2.0), blurRadius: 2.0, spreadRadius: -1.0, color: const Color(0x33000000)),
              const BoxShadow(offset: const Offset(2.0, 1.0), blurRadius: 3.0, spreadRadius: 0.0, color: const Color(0x24000000)),
              const BoxShadow(offset: const Offset(3.0, 1.0), blurRadius: 4.0, spreadRadius: 2.0, color: const Color(0x1f000000))
            ],
            image: new DecorationImage(fit: BoxFit.cover, image: new NetworkImage(widget.character.imageUrl ?? ''))),
      ),
    );
  }

  Widget get rating {
    return new Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        new Icon(
          Icons.star,
          size: 40.0,
          color: Colors.black,
        ),
        new Text('${widget.character.rating}/10', style: TextStyle(color: Colors.black, fontSize: 30.0))
      ],
    );
  }

  Widget get digimonProfile {
    return new Container(
      padding: new EdgeInsets.symmetric(vertical: 32.0),
      decoration: new BoxDecoration(
        color: Color.fromARGB(255, 185, 216, 185),
      ),
      child: new Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          digimonImage,
          new Text('${widget.character.name}', style: TextStyle(color: Colors.black, fontSize: 32.0)),
          new Text('${widget.character.levelDigimon}', style: TextStyle(color: Colors.black, fontSize: 20.0)),
          Padding(
            padding: EdgeInsets.only(top: 20.0),
            child: rating,
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      backgroundColor: Color.fromARGB(255, 185, 216, 185),
      appBar: new AppBar(
        backgroundColor: Color.fromARGB(255, 19, 109, 52),
        title: new Text('Meet ${widget.character.name}'),
      ),
      body: new ListView(
        children: <Widget>[digimonProfile, addYourRating],
      ),
    );
  }
}
