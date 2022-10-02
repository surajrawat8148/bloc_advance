// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'counter_cubit.dart';

abstract class CounterState extends Equatable {}

class IncrementedCounter extends CounterState {
  int countervalue;

  IncrementedCounter({
    required this.countervalue,
  });

  @override
  // TODO: implement props
  List<Object?> get props => [this.countervalue];

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'countervalue': countervalue,
    };
  }

  factory IncrementedCounter.fromMap(Map<String, dynamic> map) {
    return IncrementedCounter(
      countervalue: map['countervalue'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory IncrementedCounter.fromJson(String source) =>
      IncrementedCounter.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;
}

class DecrementedCounter extends CounterState {
  int countervalue;

  DecrementedCounter({
    required this.countervalue,
  });

  @override
  // TODO: implement props
  List<Object?> get props => [
        this.countervalue,
      ];

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'countervalue': countervalue,
    };
  }

  factory DecrementedCounter.fromMap(Map<String, dynamic> map) {
    return DecrementedCounter(
      countervalue: map['countervalue'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory DecrementedCounter.fromJson(String source) =>
      DecrementedCounter.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;
}
