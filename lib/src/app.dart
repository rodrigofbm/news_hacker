import 'package:flutter/material.dart';
import 'screens/news_list.dart';
import 'screens/news_detail.dart';
import 'blocs/stories_provider.dart';
import 'blocs/comments_provider.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CommentsProvides(
      child: StoriesProvider(
        child: MaterialApp(
          title: 'News',
          onGenerateRoute: routes,
        ),
      ),
    );
  }

  Route routes(RouteSettings settings) {
    if (settings.name == '/') {
      return MaterialPageRoute(builder: (context) {
        return NewsList();
      });
    } else {
      return MaterialPageRoute(builder: (context) {
        final commentsBloc = CommentsProvides.of(context);
        final itemId = int.parse(settings.name.replaceFirst('/', ''));

        //pontos de start
        commentsBloc.fetcheItemWithComments(itemId);

        return NewsDetail(id: itemId);
      });
    }
  }
}
