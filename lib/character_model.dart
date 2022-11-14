import 'dart:convert';
import 'dart:io';
import 'dart:async';
// import 'package:http/http.dart';

class Character {
  final String name;
  String? imageUrl;
  String? apiname;
  String? levelDigimon;

  int rating = 10;

  Character(this.name);

  Future getImageUrl() async {
    if (imageUrl != null) {
      return;
    }

    HttpClient http = HttpClient();
    try {
      apiname = name.toLowerCase();
      // var uri = new Uri.https('digimon-api.vercel.app', '/api/digimon/name/gatomon');
      var uri = Uri.https('www.mockachino.com', '/97193f18-bbfd-44/api/character/name/$apiname');
      var request = await http.getUrl(uri);
      var response = await request.close();
      var responseBody = await response.transform(utf8.decoder).join();

      var data = json.decode(responseBody);
      imageUrl = data["img"];
      levelDigimon = data["level"];

      print(levelDigimon);
    } catch (exception) {
      print(exception);
    }
  }
}
