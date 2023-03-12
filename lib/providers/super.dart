import 'package:flutter/foundation.dart';
import 'package:zema/model/super.dart';
import 'package:zema/network_service.dart';

abstract class SuperProvider<T extends SuperModel> with ChangeNotifier {
  List<T> items = [];
  bool isLoading = false;
  String? next;

  SuperProvider(this.next); // = ALBUMS_API_URL;

  Future<void> getNextItems() async {
    // if (next != '') {
    final networkService = NetworkService();
    isLoading = true;
    // notifyListeners();
    final data = await networkService.getData<T>(next);
    isLoading = false;
    final dataList = data.items;
    if (dataList.isNotEmpty) {
      items = [...items, ...dataList];
      next = data.next;
      // notifyListeners();
    } else {}
    notifyListeners();
  }
}
