class FakeModel {
  const FakeModel({required this.name, required this.age});

  factory FakeModel.initial() => const FakeModel(name: '', age: 0);
  final String name;
  final int age;

  FakeModel copyWith({
    String? name,
    int? age,
  }) {
    return FakeModel(
      name: name ?? this.name,
      age: age ?? this.age,
    );
  }

  @override
  String toString() {
    return 'FakeModel{name: $name, age: $age}';
  }
}
