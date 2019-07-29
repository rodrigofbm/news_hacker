import 'package:rxdart/rxdart.dart';
import 'dart:async';
import '../models/item_model.dart';
import '../resources/repository.dart';

class StoriesBloc {
  final _repository = new Repository();
  final _topIds = PublishSubject<List<int>>();
  final _itemsOutPut = BehaviorSubject<Map<int,Future<ItemModel>>>();
  final _itemsFetcher = PublishSubject<int>();

  StoriesBloc() {
    _itemsFetcher.stream.transform(_itemsTransformer())
      .pipe(_itemsOutPut);
  }

  // Getters to Streams
  Observable<List<int>> get topIds => _topIds.stream;
  Observable<Map<int, Future<ItemModel>>> get items => _itemsOutPut.stream;
  // Getters do Sinks
  Function(int) get fetchItem => _itemsFetcher.sink.add;

  fetchTopIds() async{
    final ids = await _repository.fetchTopIds();
    _topIds.sink.add(ids);
  }

  _itemsTransformer() {
    return ScanStreamTransformer(
      (Map<int,Future<ItemModel>> cache, int id, i) {
        print(i);
        cache[id] = _repository.fetchItem(id);
        //print(i);
        return cache;
      },
      <int,Future<ItemModel>>{}
    );
  }

  dispose() {
    _topIds.close();
    _itemsOutPut.close();
    _itemsFetcher.close();
  }
}