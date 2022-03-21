# Change Notifier Builder

---

A simple state management solution for flutter that rebuilds widgets whenever an instance
of [`Listenable`](https://api.flutter.dev/flutter/foundation/Listenable-class.html) emits an event.

## Example

```dart

final counter = CounterChangeNotifier();


class CounterWidget extends StatelessWidget {
  const CounterWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder<CounterChangeNotifier>(
      listenable: counter,
      // optional parameter to improve performance.
      buildWhen: (context, counter) => counter.value % 2 == 0,
      builder: (context) {
        return Text('${counter.value}');
      },
    );
  }
}
```