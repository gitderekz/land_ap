import 'dart:convert';

class regions_class {
  static String regions_json_string = '''{ "name": "Regions", "features": [ { "type": "Feature", "properties": {"region": "Arusha"}, "geometry": null }, { "type": "Feature", "properties": {"region": "Dar es Salaam"}, "geometry": null }, { "type": "Feature", "properties": {"region": "Dodoma"}, "geometry": null }, { "type": "Feature", "properties": {"region": "Geita"}, "geometry": null }, { "type": "Feature", "properties": {"region": "Iringa"}, "geometry": null }, { "type": "Feature", "properties": {"region": "Kagera"}, "geometry": null }, { "type": "Feature", "properties": {"region": "Katavi"}, "geometry": null }, { "type": "Feature", "properties": {"region": "Kigoma"}, "geometry": null }, { "type": "Feature", "properties": {"region": "Kilimanjaro"}, "geometry": null }, { "type": "Feature", "properties": {"region": "Lindi"}, "geometry": null }, { "type": "Feature", "properties": {"region": "Manyara"}, "geometry": null }, { "type": "Feature", "properties": {"region": "Mara"}, "geometry": null }, { "type": "Feature", "properties": {"region": "Mbeya"}, "geometry": null }, { "type": "Feature", "properties": {"region": "Morogoro"}, "geometry": null }, { "type": "Feature", "properties": {"region": "Mtwara"}, "geometry": null }, { "type": "Feature", "properties": {"region": "Mwanza"}, "geometry": null }, { "type": "Feature", "properties": {"region": "Njombe"}, "geometry": null }, { "type": "Feature", "properties": {"region": "Pemba Kaskazini"}, "geometry": null }, { "type": "Feature", "properties": {"region": "Pemba Kusini"}, "geometry": null }, { "type": "Feature", "properties": {"region": "Pwani"}, "geometry": null }, { "type": "Feature", "properties": {"region": "Rukwa"}, "geometry": null }, { "type": "Feature", "properties": {"region": "Ruvuma"}, "geometry": null }, { "type": "Feature", "properties": {"region": "Shinyanga"}, "geometry": null }, { "type": "Feature", "properties": {"region": "Simiyu"}, "geometry": null }, { "type": "Feature", "properties": {"region": "Singida"}, "geometry": null }, { "type": "Feature", "properties": {"region": "Songwe"}, "geometry": null }, { "type": "Feature", "properties": {"region": "Tabora"}, "geometry": null }, { "type": "Feature", "properties": {"region": "Tanga"}, "geometry": null }, { "type": "Feature", "properties": {"region": "Unguja Kaskazini"}, "geometry": null }, { "type": "Feature", "properties": {"region": "Unguja Mjini Magharibi"}, "geometry": null }, { "type": "Feature", "properties": {"region": "Unguja Kusini"}, "geometry": null } ] }''';

  static all_regions() {
    try {
      // Parse the JSON string
      Map<String, dynamic> jsonData = json.decode(regions_json_string);

      // Extract the "features" list from the parsed data
      List<dynamic> features = jsonData['features'];

      // Extract the "region" properties into a list
      List mikoa = ['-Mkoa'];
      mikoa = mikoa + features.map((feature) => feature['properties']['region']).toList();

      // Print the resulting list
      return mikoa;
    } catch (e) {
      print('Error decoding JSON: $e');
    }
  }

  static filtered_regions(chosenCountry) {
    try {
      // Parse the JSON string
      Map<String, dynamic> jsonData = json.decode(regions_json_string);

      // Extract the "features" list from the parsed data
      List<dynamic> features = jsonData['features'];

      // Extract the "region" properties into a list
      List mikoa = ['-Mkoa'];
      if (chosenCountry == 'Tanzania') {
        mikoa = mikoa + features.map((feature) => feature['properties']['region']).toList();
        // mikoa = mikoa + features.where((feature) => feature['properties']['country'] == chosenCountry).map((feature) => feature['properties']['region'] ?? '').toList();
      }

      return mikoa;
    } catch (e) {
      print('Error decoding JSON: $e');
    }
  }
}
