import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:change_notifier_builder/change_notifier_builder.dart';
import 'helper/model.dart';
import 'helper/notifier.dart';

void main() {
  group('listenable builder', () {
    late FakeChangeNotifier fakeChangeNotifier;

    setUp(() {
      fakeChangeNotifier = FakeChangeNotifier();
    });

    tearDown(() {
      fakeChangeNotifier.dispose();
    });

    testWidgets('rebuilds on change', (tester) async {
      int buildCount = 0;
      await tester.pumpWidget(
        ListenableBuilder(
          listenable: fakeChangeNotifier,
          builder: (_) {
            buildCount++;
            return Container();
          },
        ),
      );

      fakeChangeNotifier.updateName(name: 'medo');
      await tester.pump();
      expect(buildCount, 2);
    });

    testWidgets('doesn\'t rebuild when buildWhen is false', (tester) async {
      int buildCount = 0;
      await tester.pumpWidget(
        ListenableBuilder(
          listenable: fakeChangeNotifier,
          buildWhen: (_, __) => false,
          builder: (_) {
            buildCount++;
            return Container();
          },
        ),
      );

      fakeChangeNotifier.updateName(name: 'medo');
      await tester.pump();
      expect(buildCount, 1);
    });

    testWidgets('rebuilds when buildWhen returns true', (tester) async {
      int buildCount = 0;
      await tester.pumpWidget(
        ListenableBuilder<FakeChangeNotifier, FakeModel>(
          listenable: fakeChangeNotifier,
          buildWhen: (oldModel, newModel) => oldModel.age != newModel.age,
          builder: (_) {
            buildCount++;
            return Container();
          },
        ),
      );
      fakeChangeNotifier.updateAge(age: 10);
      await tester.pump();
      fakeChangeNotifier.updateAge(age: 20);
      await tester.pump();
      fakeChangeNotifier.updateAge(age: 30);
      await tester.pump();
      expect(buildCount, 4);
    });
  });
}
