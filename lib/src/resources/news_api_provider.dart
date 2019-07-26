import 'package:http/http.dart' show Client;
import 'dart:convert';
import 'dart:async';
import '../models/item_model.dart';

final _root = 'https://hacker-news.firebaseio.com/v0';

class NewsApiProvider {
  
  Client client = new Client();

  Future<List<dynamic>> fetchTopIds() async{
    final resp = await client.get('$_root/topstories.json');
    final ids = List<int>.from(json.decode(resp.body));
    
    return ids;
  }

  Future<ItemModel> fetchItem(int id) async {
    final resp = await client.get('$_root/item/$id.json');
    final parsedJson = json.decode(resp.body);

    return new ItemModel.fromJson(parsedJson);
  }
}