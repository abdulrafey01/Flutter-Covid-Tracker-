import 'dart:convert';

import 'package:covid_19_tracker_app/Modal/world_states_model.dart';
import 'package:http/http.dart' as http;

import '../Utilities/api_url.dart';

class WorldStatesHitApi {
  Future<WorldStatesModel> hitApiWorldStates() async {
    var response = await http.get(Uri.parse(ApiUrl.worldStatesApi));

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      return WorldStatesModel.fromJson(data);
    } else {
      throw Exception("Error");
    }
  }

  Future<List<dynamic>> hitApiCountriesStates() async {
    var response = await http.get(Uri.parse(ApiUrl.countriesList));
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      return data;
    } else {
      throw Exception("Error");
    }
  }
}
