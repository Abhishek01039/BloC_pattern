// BLoC pattern

import 'dart:async';

import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:rxdart/rxdart.dart';

class BlocPattern implements BlocBase {
  int counter = 0;

  Stream<int> get counterStream => _counterStreamSubject.stream;
  final _counterStreamSubject = BehaviorSubject<int>();

  BlocPattern() {
    // counter = 0;

    _counterStreamSubject.sink.add(0);
  }

  increment() {
    _counterStreamSubject.sink.add(++counter);
  }

  @override
  void addListener(listener) {
    _counterStreamSubject.stream.listen((event) {
      _counterStreamSubject.sink.add(counter);
    });
  }

  @override
  void dispose() {
    _counterStreamSubject?.close();
  }

  @override
  bool get hasListeners => null;

  @override
  void notifyListeners() {}

  @override
  void removeListener(listener) {}
}
