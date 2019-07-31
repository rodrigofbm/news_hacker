import 'package:flutter/material.dart';
import 'comments_bloc.dart';
export 'comments_bloc.dart';

class CommentsProvides extends InheritedWidget {
  final CommentsBloc bloc;

  CommentsProvides({Key key, Widget child})
    :bloc =  CommentsBloc(),
      super(key: key, child: child);

  bool updateShouldNotify(InheritedWidget oldWidget) => true;

  static CommentsBloc of(BuildContext context) {
    return (context.inheritFromWidgetOfExactType(CommentsProvides) as CommentsProvides).bloc;
  }
}