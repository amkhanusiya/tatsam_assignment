import 'dart:collection';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:tatsam_assignment/models/country.dart';
import 'package:tatsam_assignment/services/web_service.dart';
import 'package:tatsam_assignment/shared_pref.dart';

import 'country_view_model.dart';

class CountriesListViewModel extends ChangeNotifier {
  List<CountryViewModel> _countries = List<CountryViewModel>();
  List<CountryViewModel> _favouritedCountries = List<CountryViewModel>();

  UnmodifiableListView<CountryViewModel> get countries =>
      UnmodifiableListView(_countries);
  UnmodifiableListView<CountryViewModel> get favouritedCountries =>
      UnmodifiableListView(_favouritedCountries);

  static const String COUNTRIES = 'countries';
  SharedPref _sharedPref;
  CountriesListViewModel() {
    _sharedPref = SharedPref();
    _fetchFavouriteStoredCountries();
  }

  int total = 0;
  Future<void> fetchCountries(int page) async {
    final result = await WebService().fetchCountries(page);
    total = result['total'];
    final List<Country> results = result['countries'] as List<Country>;
    this._countries.addAll(
        results.map((item) => CountryViewModel(country: item)).toList());
    this._countries.forEach((item) => {
          this._favouritedCountries.forEach(
                (favItem) => {
                  if (favItem.code == item.code &&
                      favItem.name == item.name &&
                      favItem.region == item.region)
                    {item.isFavorite = true}
                },
              ),
        });
    notifyListeners();
  }

  Future<void> addOrRemoveFavourite(CountryViewModel _country) async {
    bool _isAvailable = _favouritedCountries
        .where((item) => item.code == _country.code)
        .isNotEmpty;

    _country.isFavorite = !_isAvailable;
    if (_isAvailable) {
      _favouritedCountries.removeWhere((item) => item.code == _country.code);
    } else {
      _favouritedCountries.add(_country);
    }
    var json = jsonEncode(_favouritedCountries.map((e) => e.toJson()).toList());
    // print(json);
    await _sharedPref.saveObject(COUNTRIES, json);
    notifyListeners();
  }

  _fetchFavouriteStoredCountries() async {
    var jsonString = await _sharedPref.readObject(COUNTRIES);
    if (jsonString != null) {
      var json = jsonDecode(jsonString) as List<dynamic>;
      // print('stored countries => $json');
      var _list = json.map((item) => CountryViewModel.fromJson(item)).toList();
      _favouritedCountries = _list;
    }
  }
}
