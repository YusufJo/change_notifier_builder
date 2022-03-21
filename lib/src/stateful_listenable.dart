// Copyright (c) Abdulhamid Yusuf. All rights reserved.
// Licensed under the MIT license. See LICENSE file in the project root for details.

import 'package:flutter/foundation.dart';

abstract class StatefulListenable<S> extends ChangeNotifier {
  StatefulListenable({required S initialState}) : _state = initialState;

  S _state;

  S get state => _state;

  set state(S state) {
    _state = state;
    notifyListeners();
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is StatefulListenable &&
          runtimeType == other.runtimeType &&
          _state == other._state;

  @override
  int get hashCode => _state.hashCode;
}
