import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:foodie/todolistv2/data_provider.dart';
import 'package:foodie/todolistv2/model.dart';
import 'package:foodie/todolistv2/projects_screen.dart';
import 'package:redux/redux.dart';

void main() {
  final store = Store<CategoryState>(stateReducer,
      initialState: CategoryState([
        Category(0, Icons.person, Colors.blue, "CZ1007 - Data Structures", [
          Task(0, "Sumbit week 3 lams", false),
           Task(0, "assignment 1", false),
        ]),
        Category(1, Icons.content_paste, Colors.blue[100], "Work", [])
      ]));
  runApp(FlutterReduxApp(store: store));
}

class FlutterReduxApp extends StatelessWidget {
  final Store<CategoryState> store;
  const FlutterReduxApp({Key key, this.store}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreProvider<CategoryState>(
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
            primarySwatch: Colors.blue,
            textTheme: TextTheme(
              body1: TextStyle(color: Colors.white, fontSize: 28.0),
              body2: TextStyle(color: Colors.white54, fontSize: 14.0),
              display1: TextStyle(color: Colors.black87, fontSize: 36.0),
              caption: TextStyle(
                  color: Colors.white,
                  fontSize: 12.0,
                  fontWeight: FontWeight.bold),
              subhead: TextStyle(color: Colors.black54, fontSize: 12.0),
            )),
        home: MyHomePageToDo(title: 'Flutter Demo Home Page'),
      ),
      store: store,
    );
  }
}

class MyHomePageToDo extends StatefulWidget {
  final store = Store<CategoryState>(stateReducer,
       initialState: CategoryState([
         Category(0, Icons.person, Colors.blue, "CZ1007 - Data Structures", [
           Task(0, "Sumbit week 3 lams", false),
           Task(1, "assignment 1", false), 
         ]),
         Category(1, Icons.content_paste, Colors.blue[100], "Work", [])
       ]));

  MyHomePageToDo({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePageToDo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
          title: new Text('ToDo'),
          ),
      body: StoreConnector<CategoryState, Color>(
          converter: (store) => store.state.categories[0].color,
          builder: (context, color) => ProjectsScreen(
                backgroundColor: color,
              )),
    );
  }
}
