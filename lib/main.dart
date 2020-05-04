import 'package:bloc_pattern_app/bloc.dart';

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
          stream: bloc1.counterStream,
          // initialData: initialData ,
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            return Container(
              child: snapshot.hasData
                  ? Text(snapshot.data.toString())
                  : CircularProgressIndicator(),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          bloc1.increment();
        },
        child: Icon(Icons.ac_unit),
      ),
    );
  }
}
