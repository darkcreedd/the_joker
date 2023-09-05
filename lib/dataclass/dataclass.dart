import 'dart:convert';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:the_joker/models/models.dart';

class DataClass extends ChangeNotifier {
  String? flagx2;
  String? categoryx2;
  String? internetState;

  List<SavedJoke> savedJokeList = [];

  Future<List<SavedJoke>> loadSavedJokes() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? savedJokesString = prefs.getString('savedJokes');

    if (savedJokesString == null) {
      return [];
    }

    final List<dynamic> savedJokesJson = jsonDecode(savedJokesString);
    savedJokeList = savedJokesJson
        .map((json) => SavedJoke(
              id: json['id'],
              category: json['category'],
              type: json['type'],
              joke: json['joke'],
              setup: json['setup'],
              delivery: json['delivery'],
            ))
        .toList();
    return savedJokeList;
  }

  saveListToSharedPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<Map<String, dynamic>> savedJokesJson =
        savedJokeList.map((joke) => joke.toJson()).toList();
    await prefs.setString('savedJokes', json.encode(savedJokesJson));
  }

  void addToSaved({
    required int id,
    required String category,
    required String type,
    String? joke,
    String? setup,
    String? delivery,
  }) {
    // Check if a SavedJoke with the same id already exists in the list
    if (savedJokeList.where((savedJoke) => savedJoke.id == id).isEmpty) {
      // If not, add a new SavedJoke instance to the list
      if (type == 'single') {
        savedJokeList.add(SavedJoke(
          id: id,
          category: category,
          type: type,
          joke: joke,
        ));
      } else if (type == 'twopart') {
        savedJokeList.add(SavedJoke(
          id: id,
          category: category,
          type: type,
          setup: setup,
          delivery: delivery,
        ));
      }
    }
    saveListToSharedPreferences();
  }

//Filters
  String customisation = 'Any';
  String custom = 'Custom';
  String any = 'Any';
  bool programming = false;
  bool programmingState = true;
  bool miscellaneous = false;
  bool miscellaneousState = true;
  bool dark = false;
  bool darkState = true;
  bool pun = false;
  bool punState = true;
  bool spooky = false;
  bool spookyState = true;
  bool christmas = false;
  bool christmasState = true;
  String category = 'Any';

  void toggle1(bool rx) {
    programmingState = rx;
    miscellaneousState = rx;
    darkState = rx;
    punState = rx;
    spookyState = rx;
    christmasState = rx;
    categoryx2 = 'Any';
    reset();
  }

  void toggle(bool rx) {
    programmingState = rx;
    miscellaneousState = rx;
    darkState = rx;
    punState = rx;
    spookyState = rx;
    christmasState = rx;
    categoryx2 = 'Any';
    reset();
    notifyListeners();
  }

  void reset() {
    programming = false;
    miscellaneous = false;
    dark = false;
    pun = false;
    spooky = false;
    christmas = false;
  }

  //Flags
  bool nsfw = false;
  bool religious = false;
  bool political = false;
  bool racist = false;
  bool sexist = false;
  bool explicit = false;
  void resetFlags() {
    nsfw = false;
    religious = false;
    political = false;
    racist = false;
    sexist = false;
    explicit = false;
  }

  void setFlags() {
    String flagx = '';
    if (nsfw) {
      flagx = 'nsfw,';
    }
    if (religious) {
      flagx = '$flagx,religious';
    }
    if (political) {
      flagx = '$flagx,political';
    }
    if (racist) {
      flagx = '$flagx,racist';
    }
    if (sexist) {
      flagx = '$flagx,sexist';
    }
    if (explicit) {
      flagx = '$flagx,explicit';
    }
    List<String> flagx1 = flagx.split(',');
    flagx1.removeWhere((item) => item.trim().isEmpty);
    flagx2 = flagx1.join(',');
    notifyListeners();
  }

  void setCategory() {
    String categoryx = '';
    if (programming) {
      categoryx = 'Programming,';
    }
    if (miscellaneous) {
      categoryx = '$categoryx,Miscellaneous';
    }
    if (dark) {
      categoryx = '$categoryx,Dark';
    }
    if (pun) {
      categoryx = '$categoryx,Pun';
    }
    if (spooky) {
      categoryx = '$categoryx,Spooky';
    }
    if (christmas) {
      categoryx = '$categoryx,Christmas';
    }
    List<String> flagx1 = categoryx.split(',');
    flagx1.removeWhere((item) => item.trim().isEmpty);
    categoryx2 = flagx1.join(',');
    notifyListeners();

    if (categoryx2 == '') {
      categoryx2 = 'Any?';
    } else {
      categoryx2 = '$categoryx2?';
    }
  }

  String? xconnectionStatus;
  void updateConnectionStatus(ConnectivityResult result) {
    xconnectionStatus = result.toString();
  }

  String errorMessage = 'Tap on next joke to refresh data';
  Future<DualJoke>? dualJoke() async {
    updateConnectionStatus(ConnectivityResult.none);

    if (categoryx2 == '') {
      categoryx2 = 'Any?';
    }
    DualJoke jokes;
    String url =
        'https://v2.jokeapi.dev/joke/$categoryx2&type=twopart&blacklistFlags=$flagx2';
    Uri uri = Uri.parse(url);

    final response = await http.get(uri);
    if (response.statusCode == 200) {
      jokes = dualJokeFromJson(response.body);
      notifyListeners();

      return jokes;
    } else {
      throw Exception('There was an error fetching the data');
    }
  }

  //Error message
  String errorMessage1 = 'Click Next Joke to refresh data';
  String testvalue = 'a';
  String testvalue1 = 'a';

  Future<SingleJoke>? singleJoke() async {
    updateConnectionStatus(ConnectivityResult.none);

    if (categoryx2 == '') {
      categoryx2 = 'Any?';
    }
    SingleJoke jokes;
    String url =
        'https://v2.jokeapi.dev/joke/$categoryx2&type=single&blacklistFlags=$flagx2';
    Uri uri = Uri.parse(url);

    final response = await http.get(uri);

    if (response.statusCode == 200) {
      jokes = singleJokeFromJson(response.body);

      notifyListeners();
      return jokes;
    } else {
      throw Exception('There was an error fetching the data');
    }
  }
}
