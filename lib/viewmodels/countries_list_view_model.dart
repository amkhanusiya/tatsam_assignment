import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:tatsam_assignment/models/country.dart';
import 'package:tatsam_assignment/services/web_service.dart';

import 'country_view_model.dart';

class CountriesListViewModel extends ChangeNotifier {
  List<CountryViewModel> _countries = List<CountryViewModel>();
  List<CountryViewModel> _favouritedCountries = List<CountryViewModel>();

  UnmodifiableListView<CountryViewModel> get countries =>
      UnmodifiableListView(_countries);
  UnmodifiableListView<CountryViewModel> get favouritedCountries =>
      UnmodifiableListView(_favouritedCountries);

  int total = 0;
  Future<void> fetchCountries(int page) async {
    final result = await WebService().fetchCountries(page);
    total = result['total'];
    final List<Country> results = result['countries'] as List<Country>;
    this._countries.addAll(
        results.map((item) => CountryViewModel(country: item)).toList());
    notifyListeners();
  }

  Future<void> addOrRemoveFavourite(CountryViewModel _country) async {
    bool _isAvailable = _favouritedCountries
        .where((item) => item.code == _country.code)
        .isNotEmpty;
    _country.isFavorite = !_isAvailable;
    if (_isAvailable) {
      _favouritedCountries.remove(_country);
    } else {
      _favouritedCountries.add(_country);
    }
    notifyListeners();
  }
}
