import 'package:flutter/material.dart';

class NotifyProvider<Model extends ChangeNotifier> extends StatefulWidget {
  final Model Function() create;
  final bool isManagingModel;
  final Widget child;

  const NotifyProvider({
    Key? key,
    required this.create,
    this.isManagingModel = true,
    required this.child,
  }) : super(key: key);

  @override
  State<NotifyProvider> createState() => _NotifyProviderState<Model>();

  static Model? watch<Model extends ChangeNotifier>(BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<_InheritedNotifyProvider<Model>>()
        ?.model;
  }

  static Model? read<Model extends ChangeNotifier>(BuildContext context) {
    final widget = context
        .getElementForInheritedWidgetOfExactType<
            _InheritedNotifyProvider<Model>>()
        ?.widget;
    return widget is _InheritedNotifyProvider<Model> ? widget.model : null;
  }
}

class _NotifyProviderState<Model extends ChangeNotifier>
    extends State<NotifyProvider<Model>> {
  late final Model _model;

  @override
  void initState() {
    super.initState();
    _model = widget.create();
  }

  @override
  Widget build(BuildContext context) {
    return _InheritedNotifyProvider(
      model: _model,
      child: widget.child,
    );
  }

  @override
  void dispose() {
    if (widget.isManagingModel) {
      _model.dispose();
    }
    _model.dispose();
    super.dispose();
  }
}

class _InheritedNotifyProvider<Model extends ChangeNotifier>
    extends InheritedNotifier {
  final Model model;

  const _InheritedNotifyProvider({
    Key? key,
    required Widget child,
    required this.model,
  }) : super(
          key: key,
          notifier: model,
          child: child,
        );
}

class Provider<Model> extends InheritedWidget {
  final Model model;

  const Provider({
    Key? key,
    required this.model,
    required Widget child,
  }) : super(
          key: key,
          child: child,
        );

  static Model? watch<Model>(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<Provider>()?.model;
  }

  static Model? read<Model>(BuildContext context) {
    final widget =
        context.getElementForInheritedWidgetOfExactType<Provider>()?.widget;
    return widget is Provider<Model> ? widget.model : null;
  }

  @override
  bool updateShouldNotify(Provider oldWidget) {
    return model != oldWidget.model;
  }
}
