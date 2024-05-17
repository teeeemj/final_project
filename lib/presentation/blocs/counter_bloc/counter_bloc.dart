import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'counter_event.dart';
part 'counter_state.dart';

class CounterBloc extends Bloc<CounterEvent, int> {
  CounterBloc() : super(0) {
    on<Increment>((event, emit) {
      if (state < 10) {
        emit(state + (event.incrementValue));
      }
    });

    on<Decrement>((event, emit) {
      if (state > 0) {
        emit(state - (event.decrementValue));
      }
    });
  }
}
