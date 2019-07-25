import 'dart:async';
import 'news_api_provider.dart';
import 'news_db_provider.dart';
import '../models/item_model.dart';

class Repository {
  NewsApiProvider apiProvider = new NewsApiProvider();
  NewsDbProvider dbProvider = new NewsDbProvider();


  Future<List<int>> fetchTopIds() {
    return apiProvider.fetchTopIds();
  }

  Future<ItemModel> fetchItem(int id) async{
    var item = await dbProvider.fetchItem(id);

    if( item != null) {
      return item;
    }

    item = await apiProvider.fetchItem(id);
    dbProvider.addItemToDb(item);

    return item;
  }

}