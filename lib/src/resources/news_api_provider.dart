import 'package:http/http.dart' show Client;
import 'dart:convert';
import '../models/item_model.dart';

class NewsApiProvider {
  final url = 'https://hacker-news.firebaseio.com/v0';
  Client client = new Client();

  Future<List<int>> fetchTopIds() async{
    final resp = await client.get('$url/topstories.json');
    final List<int> ids = json.decode(resp.body);

    return ids;
  }

  Future<ItemModel> fetchItem(int id) async {
    final resp = await client.get('$url/item/$id.json');
    final parsedJson = json.decode(resp.body);

    return new ItemModel.fromJson(parsedJson);
  }
}