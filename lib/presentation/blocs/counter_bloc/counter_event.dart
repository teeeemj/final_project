part of 'counter_bloc.dart';

@immutable
sealed class CounterEvent {}

class Increment extends CounterEvent {
  final int incrementValue;

  Increment({required this.incrementValue});
}

class Decrement extends CounterEvent {
  final int decrementValue;

  Decrement({required this.decrementValue});
}
