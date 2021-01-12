import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:tatsam_assignment/models/country.dart';
import 'package:tatsam_assignment/services/web_service.dart';

import 'country_view_model.dart';

class CountriesListViewModel extends ChangeNotifier {
  List<CountryViewModel> _countries = List<CountryViewModel>();
  UnmodifiableListView<CountryViewModel> get countries =>
      UnmodifiableListView(_countries);

  int total = 0;
  Future<void> fetchCountries(int page) async {
    final result = await WebService().fetchCountries(page);
    total = result['total'];
    final List<Country> results = result['countries'] as List<Country>;
    this._countries.addAll(
        results.map((item) => CountryViewModel(country: item)).toList());
    print('total countries => ${countries.length}');
    notifyListeners();
  }
}
