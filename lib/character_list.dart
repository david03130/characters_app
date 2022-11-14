import 'package:characters_app/character_card.dart';
import 'package:flutter/material.dart';
import 'character_model.dart';

class CharacterList extends StatelessWidget {
  final List<Character> digimons;
  CharacterList(this.digimons);

  @override
  Widget build(BuildContext context) {
    return _buildList(context);
  }

  ListView _buildList(context) {
    return new ListView.builder(
      itemCount: digimons.length,
      itemBuilder: (context, int) {
        return new CharacterCard(digimons[int]);
      },
    );
  }
}
