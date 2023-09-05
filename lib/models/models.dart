// To parse this JSON data, do
//
//     final dualJoke = dualJokeFromJson(jsonString);

import 'dart:convert';

DualJoke dualJokeFromJson(String str) => DualJoke.fromJson(json.decode(str));

String dualJokeToJson(DualJoke data) => json.encode(data.toJson());

class DualJoke {
  DualJoke({
    required this.error,
    required this.category,
    required this.type,
    required this.setup,
    required this.delivery,
    required this.flags,
    required this.safe,
    required this.id,
    required this.lang,
  });

  bool error;
  String? category;
  String? type;
  String? setup;
  String? delivery;
  Flags? flags;
  bool safe;
  int id;
  String? lang;

  factory DualJoke.fromJson(Map<String, dynamic> json) => DualJoke(
        error: json["error"],
        category: json["category"] ?? 'Unknown',
        type: json["type"] ?? "Unknown",
        setup: json["setup"],
        delivery: json["delivery"],
        flags: Flags.fromJson(json["flags"]),
        safe: json["safe"],
        id: json["id"],
        lang: json["lang"],
      );

  Map<String, dynamic> toJson() => {
        "error": error,
        "category": category,
        "type": type,
        "setup": setup,
        "delivery": delivery,
        "flags": flags!.toJson(),
        "safe": safe,
        "id": id,
        "lang": lang,
      };
}

class Flags {
  Flags({
    required this.nsfw,
    required this.religious,
    required this.political,
    required this.racist,
    required this.sexist,
    required this.explicit,
  });

  bool nsfw;
  bool religious;
  bool political;
  bool racist;
  bool sexist;
  bool explicit;

  factory Flags.fromJson(Map<String, dynamic> json) => Flags(
        nsfw: json["nsfw"],
        religious: json["religious"],
        political: json["political"],
        racist: json["racist"],
        sexist: json["sexist"],
        explicit: json["explicit"],
      );

  Map<String, dynamic> toJson() => {
        "nsfw": nsfw,
        "religious": religious,
        "political": political,
        "racist": racist,
        "sexist": sexist,
        "explicit": explicit,
      };
}

//
//     final singleJoke = singleJokeFromJson(jsonString);

SingleJoke singleJokeFromJson(String str) =>
    SingleJoke.fromJson(json.decode(str));

String singleJokeToJson(SingleJoke data) => json.encode(data.toJson());

class SingleJoke {
  SingleJoke({
    required this.error,
    required this.category,
    required this.type,
    required this.joke,
    required this.flags,
    required this.id,
    required this.safe,
    required this.lang,
  });

  bool? error;
  String? category;
  String? type;
  String? joke;
  Flags? flags;
  int id;
  bool safe;
  String lang;

  factory SingleJoke.fromJson(Map<String, dynamic> json) => SingleJoke(
        error: json["error"],
        category: json["category"] ?? 'Unknown',
        type: json["type"],
        joke: json["joke"],
        flags: Flags.fromJson(json["flags"]),
        id: json["id"],
        safe: json["safe"],
        lang: json["lang"],
      );

  Map<String, dynamic> toJson() => {
        "error": error,
        "category": category,
        "type": type,
        "joke": joke,
        "flags": flags!.toJson(),
        "id": id,
        "safe": safe,
        "lang": lang,
      };
}

class SavedJoke {
  int id;
  String category;
  String type;
  String? joke;
  String? setup;
  String? delivery;

  SavedJoke({
    required this.id,
    required this.category,
    required this.type,
    this.joke,
    this.setup,
    this.delivery,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'category': category,
      'type': type,
      'joke': joke,
      'setup': setup,
      'delivery': delivery,
    };
  }
}
