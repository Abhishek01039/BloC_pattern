import 'dart:async';

import 'package:flutter/material.dart';
import 'package:bloc_pattern/bloc_pattern.dart';

main(List<String> args) {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      blocs: [
        Bloc((i) => BlocPattern()),
      ],
      child: MaterialApp(
        home: Home(),
      ),
    );
  }
}

// BLoC pattern

class BlocPattern implements BlocBase {
  int counter;
  StreamController<int> _streamController = StreamController<int>();
  StreamSink get _sink => _streamController.sink;
  Stream get _stream => _streamController.stream;

  BlocPattern() {
    counter = 0;
    _sink.add(counter);
    // _streamController.stream.listen(increment());
  }

  increment() {
    counter++;
    print(counter);
    _sink.add(counter);
  }

  @override
  void addListener(listener) {
    _stream.listen((event) {
      print(event);
    });
  }

  @override
  void dispose() {
    _streamController?.close();
  }

  @override
  bool get hasListeners => null;

  @override
  void notifyListeners() {}

  @override
  void removeListener(listener) {}
}

// final bloc = BlocPattern();

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final BlocPattern bloc1 = BlocProvider.getBloc<BlocPattern>();
    return Scaffold(
      appBar: AppBar(
        title: Text("BLoC pattern"),
        centerTitle: true,
      ),
      body: Center(
        child: StreamBuilder(
            stream: bloc1._stream,
            // initialData: bloc.counter,
            builder: (context, snapshot) {
              return Container(
                child:
                    Text("You have pressed ${snapshot.data.toString()} times"),
              );
            }),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: bloc1.increment,
        child: Icon(Icons.add),
      ),
    );
  }
}
