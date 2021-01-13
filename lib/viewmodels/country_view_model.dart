import 'package:tatsam_assignment/models/country.dart';

class CountryViewModel {
  final Country country;
  bool isFavorite;

  CountryViewModel({this.country, this.isFavorite = false});

  String get name {
    return this.country.name;
  }

  String get region {
    return this.country.region;
  }

  String get code {
    return this.country.code;
  }

  Map<String, dynamic> toJson() => {
        'name': name,
        'region': region,
        'code': code,
        'isFavorite': isFavorite,
      };

  factory CountryViewModel.fromJson(Map<String, dynamic> json) {
    return CountryViewModel(
      country: Country.fromJson(json['code'], json),
      isFavorite: json['isFavorite'],
    );
  }
}
