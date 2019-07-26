import 'dart:async';
import 'news_api_provider.dart';
import 'news_db_provider.dart';
import '../models/item_model.dart';

class Repository {
  NewsApiProvider apiProvider = new NewsApiProvider();
  


  Future<List<int>> fetchTopIds() {
    return apiProvider.fetchTopIds();
  }

  Future<ItemModel> fetchItem(int id) async{
    var item = await newsDbProvider.fetchItem(id);

    if( item != null) {
      return item;
    }

    item = await apiProvider.fetchItem(id);
    newsDbProvider.addItemToDb(item);

    return item;
  }

}