// Copyright (c) Abdulhamid Yusuf. All rights reserved.
// Licensed under the MIT license. See LICENSE file in the project root for details.

import 'package:change_notifier_builder/change_notifier_builder.dart';
import 'package:flutter/widgets.dart';

typedef ListenableBuildWhen<S> = bool Function(S, S);

class ListenableBuilder<T extends StatefulListenable<S>, S>
    extends StatefulWidget {
  ListenableBuilder({
    Key? key,
    required this.listenable,
    required this.builder,
    ListenableBuildWhen<S>? buildWhen,
  })  : _buildWhen = buildWhen ?? ((_, __) => true),
        super(key: key);

  final T listenable;
  final Widget Function(BuildContext) builder;
  final ListenableBuildWhen<S> _buildWhen;

  @override
  _ListenableBuilderState<T, S> createState() =>
      _ListenableBuilderState<T, S>();
}

class _ListenableBuilderState<T extends StatefulListenable<S>, S>
    extends State<ListenableBuilder<T, S>> {
  late S _oldState;
  late S _currentState;

  @override
  void initState() {
    super.initState();
    _oldState = widget.listenable.state;
    _currentState = widget.listenable.state;
    widget.listenable.addListener(_handleChange);
  }

  @override
  void didUpdateWidget(covariant ListenableBuilder<T, S> oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.listenable != oldWidget.listenable) {
      oldWidget.listenable.removeListener(_handleChange);
      widget.listenable.addListener(_handleChange);
    }
  }

  @override
  void dispose() {
    widget.listenable.removeListener(_handleChange);
    super.dispose();
  }

  void _handleChange() {
    _oldState = _currentState;
    _currentState = widget.listenable.state;
    final shouldRebuild = widget._buildWhen(_oldState, _currentState);
    if (shouldRebuild) {
      (context as StatefulElement).markNeedsBuild();
    }
  }

  @override
  Widget build(BuildContext context) {
    return widget.builder(context);
  }
}
