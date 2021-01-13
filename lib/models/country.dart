class Country {
  final String name;
  final String code;
  final String region;

  Country({this.name, this.code, this.region});

  factory Country.fromJson(String key, Map<String, dynamic> json) {
    // print('key => $key and $json');
    return Country(
      name: json["country"] != null ? json["country"] : json["name"],
      region: json["region"],
      code: key,
    );
  }
}
