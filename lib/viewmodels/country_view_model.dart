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
}
