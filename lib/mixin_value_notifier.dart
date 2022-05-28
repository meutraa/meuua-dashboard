import 'package:flutter/material.dart';

mixin ValueNotifierMixin<T extends StatefulWidget, S> on State<T> {
  late S value;

  ValueNotifier<S> get notifier;

  @override
  void initState() {
    super.initState();
    value = notifier.value;
    WidgetsBinding.instance.addPostFrameCallback(
      (_) => notifier.addListener(_onChange),
    );
  }

  @override
  void dispose() {
    notifier.removeListener(_onChange);
    super.dispose();
  }

  void _onChange() => setState(() => value = notifier.value);
}
