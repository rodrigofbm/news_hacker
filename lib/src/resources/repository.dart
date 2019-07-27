import 'dart:async';
import 'news_api_provider.dart';
import 'news_db_provider.dart';
import '../models/item_model.dart';

class Repository {
  NewsApiProvider apiProvider = new NewsApiProvider();
  


  Future<List<dynamic>> fetchTopIds() {
    return apiProvider.fetchTopIds();
  }

  Future<ItemModel> fetchItem(int id) async{
    newsDbProvider.init();
    await Future.delayed(Duration(seconds: 1));

    var item = await newsDbProvider.fetchItem(id);

    if( item != null) {
      return item;
    }

    item = await apiProvider.fetchItem(id);
    newsDbProvider.addItemToDb(item);

    return item;
  }

}