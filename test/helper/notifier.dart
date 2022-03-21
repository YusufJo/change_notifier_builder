import 'package:change_notifier_builder/src/stateful_listenable.dart';

import 'model.dart';

class FakeChangeNotifier extends StatefulListenable<FakeModel> {
  FakeChangeNotifier() : super(initialState: FakeModel.initial());

  void updateName({required String name}) {
    state = state.copyWith(name: name);
  }

  void updateAge({required int age}) {
    state = state.copyWith(age: age);
  }

  @override
  String toString() {
    return 'FakeChangeNotifier{_model: $state}';
  }
}
