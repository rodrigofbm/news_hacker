import 'package:rxdart/rxdart.dart';
import 'dart:async';
import '../models/item_model.dart';
import '../resources/repository.dart';

class CommentsBloc {
  final _commentsFetcher = PublishSubject<int>();
  final _commentsOutPut = BehaviorSubject<Map<int, Future<ItemModel>>>();
  final _repository = Repository();

  CommentsBloc() {
    _commentsFetcher.stream
        .transform(_commentsTransformer())
        .pipe(_commentsOutPut);
  }

  // Streams
  Observable<Map<int, Future<ItemModel>>> get itemWithComments =>
      _commentsOutPut.stream;

  // Sinks
  Function(int) get fetcheItemWithComments => _commentsFetcher.sink.add;

  _commentsTransformer() {
    return ScanStreamTransformer<int, Map<int, Future<ItemModel>>>(
      (cache, int id, index) {
        print(index);
        cache[id] = _repository.fetchItem(id);
        cache[id].then((ItemModel item) {
          item.kids.forEach((kidId) => fetcheItemWithComments(kidId));
        });

        return cache; // ADD THIS!!!!! <<<--------------
      },
      <int, Future<ItemModel>>{},
    );
  }

  dispose() {
    _commentsFetcher.close();
    _commentsOutPut.cast();
  }
}
