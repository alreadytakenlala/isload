import 'package:flutter/material.dart';

abstract class BaseBloc {
  void dispose();
}

class BlocProvider<T extends BaseBloc> extends StatefulWidget {
  BlocProvider({
    Key key,
    @required this.child,
    @required this.bloc,
    this.userDispose: true,
  }) : super(key: key);

  final T bloc;
  final Widget child;
  final bool userDispose;

  @override
  _BlocProviderState<T> createState() => _BlocProviderState<T>();

  static T of<T extends BaseBloc>(BuildContext context) {
    BlocProvider<T> provider = context.findAncestorWidgetOfExactType();
    return provider.bloc;
  }

  static Type _typeOf<T>() => T;
}

class _BlocProviderState<T> extends State<BlocProvider<BaseBloc>> {
  @override
  void dispose() {
    super.dispose();
    if (widget.userDispose) widget.bloc.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}
