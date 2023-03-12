import 'dart:convert';

import 'package:zema/constants.dart';
import 'package:zema/helper_types.dart';
import 'package:zema/models/super.dart';

import 'package:http/http.dart' as http;

class NetworkService {
  Future<NextItemsList<T>> getData<T extends SuperModel>(String? url) async {
    if (url == null) {
      return NextItemsList<T>([], '');
    }
    var response;
    try {
      response = await http.get(Uri.parse(url));
    } on Exception {
      return NextItemsList<T>([], '');
    }
    if (response.statusCode == 200 || response.statusCode == 201) {
      final jsondedData = jsonDecode(response.body);
      final dataList = (jsondedData['results'] as List<dynamic>);
      if (dataList.isNotEmpty) {
        return NextItemsList<T>(
            List<T>.from(
                dataList.map((e) => SuperModel.fromJson<T>(e)).toList()),
            jsondedData['next']);
      }
    }
    throw Exception('Failed to load');
  }

  Future<Map> addFavourite(int trackId, String userFUI) async {
    final response = await http.post(Uri.parse(FAVOURITES_API_URL),
        headers: <String, String>{
          'Content-Type': 'application/json',
        },
        body: jsonEncode(
            <String, String>{'user_FUI': userFUI, 'track_id': '$trackId'}));
    if (response.statusCode == 200 || response.statusCode == 201) {
      return jsonDecode(response.body);
    }
    throw Exception('Failed to add');
  }

  Future<bool> deleteFavourite(int favId, String userFUI) async {
    final response =
        await http.delete(Uri.parse('${FAVOURITES_API_URL}/${favId}'));
    return response.statusCode == 204;
  }
}
