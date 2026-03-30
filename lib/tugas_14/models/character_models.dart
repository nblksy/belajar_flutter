import 'dart:convert';

GetCharacterResponse getCharacterFromJson(String str) =>
    GetCharacterResponse.fromJson(json.decode(str));

String getCharacterToJson(GetCharacterResponse data) =>
    json.encode(data.toJson());

class GetCharacterResponse {
  Info? info;
  List<GetCharacter>? results;

  GetCharacterResponse({this.info, this.results});

  factory GetCharacterResponse.fromJson(Map<String, dynamic> json) =>
      GetCharacterResponse(
        info: json["info"] == null ? null : Info.fromJson(json["info"]),
        results: json["results"] == null
            ? []
            : List<GetCharacter>.from(
                json["results"].map((x) => GetCharacter.fromJson(x)),
              ),
      );

  Map<String, dynamic> toJson() => {
    "info": info?.toJson(),
    "results": results == null
        ? []
        : List<dynamic>.from(results!.map((x) => x.toJson())),
  };
}

class Info {
  int? count;
  int? pages;
  String? next;
  dynamic prev;

  Info({this.count, this.pages, this.next, this.prev});

  factory Info.fromJson(Map<String, dynamic> json) => Info(
    count: json["count"],
    pages: json["pages"],
    next: json["next"],
    prev: json["prev"],
  );

  Map<String, dynamic> toJson() => {
    "count": count,
    "pages": pages,
    "next": next,
    "prev": prev,
  };
}

class GetCharacter {
  int? id;
  String? name;
  String? status;
  String? species;
  String? type;
  String? gender;
  CharacterLocation? origin;
  CharacterLocation? location;
  String? image;
  List<String>? episode;
  String? url;
  String? created;

  GetCharacter({
    this.id,
    this.name,
    this.status,
    this.species,
    this.type,
    this.gender,
    this.origin,
    this.location,
    this.image,
    this.episode,
    this.url,
    this.created,
  });

  factory GetCharacter.fromJson(Map<String, dynamic> json) => GetCharacter(
    id: json["id"],
    name: json["name"],
    status: json["status"],
    species: json["species"],
    type: json["type"],
    gender: json["gender"],
    origin: json["origin"] == null
        ? null
        : CharacterLocation.fromJson(json["origin"]),
    location: json["location"] == null
        ? null
        : CharacterLocation.fromJson(json["location"]),
    image: json["image"],
    episode: json["episode"] == null
        ? []
        : List<String>.from(json["episode"].map((x) => x)),
    url: json["url"],
    created: json["created"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "status": status,
    "species": species,
    "type": type,
    "gender": gender,
    "origin": origin?.toJson(),
    "location": location?.toJson(),
    "image": image,
    "episode": episode == null
        ? []
        : List<dynamic>.from(episode!.map((x) => x)),
    "url": url,
    "created": created,
  };
}

class CharacterLocation {
  String? name;
  String? url;

  CharacterLocation({this.name, this.url});

  factory CharacterLocation.fromJson(Map<String, dynamic> json) =>
      CharacterLocation(name: json["name"], url: json["url"]);

  Map<String, dynamic> toJson() => {"name": name, "url": url};
}
