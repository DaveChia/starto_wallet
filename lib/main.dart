import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'views/create_wallet.dart' as CreateWallet;
import 'views/transactions.dart' as Transactions;
import 'views/wallets.dart' as Wallets;
import 'views/settings.dart' as Settings;

SharedPreferences sp;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
          // This is the theme of your application.
          //
          // Try running your application with "flutter run". You'll see the
          // application has a blue toolbar. Then, without quitting the app, try
          // changing the primarySwatch below to Colors.green and then invoke
          // "hot reload" (press "r" in the console where you ran "flutter run",
          // or simply save your changes to "hot reload" in a Flutter IDE).
          // Notice that the counter didn't reset back to zero; the application
          // is not restarted.
          primaryColor: Colors.white),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  Color nav_border_color = Color(0xFF24324A1A);
  Color selected_nav_color = Color(0xFF0472FF);
  Color unselected_nav_color = Color(0xFF616C7D);

  String selected_page = 'transaction';

  @override
  void initState() {
    super.initState();
    print('333 I AM STARTING');
    _loadCounter();
  }

  _loadCounter() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _counter = (prefs.getInt('counter') ?? '');
    });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
        elevation: 0,
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          // Column is also a layout widget. It takes a list of children and
          // arranges them vertically. By default, it sizes itself to fit its
          // children horizontally, and tries to be as tall as its parent.
          //
          // Invoke "debug painting" (press "p" in the console, choose the
          // "Toggle Debug Paint" action from the Flutter Inspector in Android
          // Studio, or the "Toggle Debug Paint" command in Visual Studio Code)
          // to see the wireframe for each widget.
          //
          // Column has various properties to control how it sizes itself and
          // how it positions its children. Here we use mainAxisAlignment to
          // center the children vertically; the main axis here is the vertical
          // axis because Columns are vertical (the cross axis would be
          // horizontal).
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Expanded(
              child: Container(),
            ),
            Container(
                decoration: BoxDecoration(
                  border: Border(
                    top: BorderSide(
                      width: 1.0,
                      color: nav_border_color,
                    ),
                  ),
                ),
                height: 72,
                child: Row(
                  children: [
                    Expanded(
                      child: GestureDetector(
                        child: Padding(
                          padding: EdgeInsets.only(top: 16),
                          child: Column(
                            children: [
                              Text(
                                '21 Nov',
                                style: TextStyle(
                                  color: selected_page == 'transaction'
                                      ? selected_nav_color
                                      : unselected_nav_color,
                                  fontSize: 14.0,
                                ),
                              ),
                              Container(
                                height: 4,
                              ),
                              Icon(
                                Icons.circle,
                                size: 8,
                                color: selected_page == 'transaction'
                                    ? selected_nav_color
                                    : Colors.transparent,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Wallets.Wallets()),
                          );
                        },
                        child: Padding(
                          padding: EdgeInsets.only(top: 12),
                          child: Column(
                            children: [
                              Icon(
                                Icons.folder_open_rounded,
                                size: 24,
                                color: selected_page == 'wallet'
                                    ? selected_nav_color
                                    : unselected_nav_color,
                              ),
                              Container(
                                height: 4,
                              ),
                              Icon(
                                Icons.circle,
                                size: 8,
                                color: selected_page == 'wallet'
                                    ? selected_nav_color
                                    : Colors.transparent,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Settings.Settings()),
                          );
                        },
                        child: Padding(
                          padding: EdgeInsets.only(top: 12),
                          child: Column(
                            children: [
                              Icon(
                                Icons.settings,
                                size: 24,
                                color: selected_page == 'setting'
                                    ? selected_nav_color
                                    : unselected_nav_color,
                              ),
                              Container(
                                height: 4,
                              ),
                              Icon(
                                Icons.circle,
                                size: 8,
                                color: selected_page == 'setting'
                                    ? selected_nav_color
                                    : Colors.transparent,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ))
          ],
        ),
      ),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () {
      //     Navigator.push(
      //       context,
      //       //  MaterialPageRoute(builder: (context) => CreateWallet.Wallet()),
      //       // MaterialPageRoute(builder: (context) => Wallets.Wallets()),
      //       MaterialPageRoute(
      //           builder: (context) => Transactions.Transactions()),
      //       // MaterialPageRoute(builder: (context) => Settings.Settings()),
      //     );
      //   },
      //   // onPressed: _incrementCounter,
      //   tooltip: 'Increment',
      //   child: Icon(Icons.add),
      // ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  _incrementCounter() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int counter = (prefs.getInt('counter') ?? 0) + 1;
    print('Pressed $counter times.');
    await prefs.setInt('counter', counter);
  }
}
