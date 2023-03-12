import 'dart:convert';

import 'package:zema/helper_types.dart';
import 'package:zema/model/super.dart';

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
    if (response.statusCode == 200) {
      final jsondedData = jsonDecode(response.body);
      final dataList = (jsondedData['results'] as List<dynamic>);
      if (dataList.isNotEmpty) {
        print('list is bak $url ${dataList.length}');
        return NextItemsList<T>(
            List<T>.from(
                dataList.map((e) => SuperModel.fromJson<T>(e)).toList()),
            jsondedData['next']);
      }
    }
    throw Exception('Failed to load albums');
  }
}
