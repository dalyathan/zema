import 'package:flutter/foundation.dart';
import 'package:zema/models/favourites.dart';
import 'package:zema/models/super.dart';
import 'package:zema/network_service.dart';

abstract class SuperProvider<T extends SuperModel> with ChangeNotifier {
  List<T> items = [];
  bool isLoading = false;
  final networkService = NetworkService();
  String? next;

  SuperProvider(this.next); // = ALBUMS_API_URL;

  Future<void> getNextItems() async {
    isLoading = true;
    final data = await networkService.getData<T>(next);
    isLoading = false;
    final dataList = data.items;
    if (dataList.isNotEmpty) {
      items = [...items, ...dataList];
      next = data.next;
    }
    if (T != Favourites) {
      notifyListeners();
    }
  }
}
