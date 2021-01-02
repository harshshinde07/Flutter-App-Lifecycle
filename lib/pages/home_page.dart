import 'package:app_lifecycle/pages/new_page.dart';
import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with WidgetsBindingObserver {

  AppLifecycleState _appLifecycleState;

  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    super.initState();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    setState(() {
      _appLifecycleState = state;
    });
    if(state == AppLifecycleState.paused) {
      print('AppLifecycleState state: Paused video playback');
    }
    if(state == AppLifecycleState.resumed) {
      print('AppLifecycleState state: Resumed video playback');
    }
    print('AppLifecycleState state:  $state');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: OrientationBuilder(
        builder: (context, orientation) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  'Orientation: $orientation',
                ),
                SizedBox(height: 8.0,),
                Text(
                  'Previous app state: $_appLifecycleState',
                ),
                SizedBox(height: 8.0,),
                ElevatedButton(
                  child: Text('Navigate to new route'),
                  onPressed: () {
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(
                        builder: (context) => NewPage(),
                      ),
                    );
                  },
                )
              ],
            ),
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }
}

