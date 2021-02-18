import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

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
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Flutter Notifcation'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var initializationSettingsAndroid,
      flutterLocalNotificationsPlugin,
      initializationSettingsIOS,
      initializationSettings;
  String title, desc;
  @override
  void initState() {
    super.initState();

    initializationSettingsAndroid = new AndroidInitializationSettings(
        'icon'); //for android should be in res/drawable
    initializationSettingsIOS = new IOSInitializationSettings();
    initializationSettings = new InitializationSettings(
        android: initializationSettingsAndroid, iOS: initializationSettingsIOS);
    flutterLocalNotificationsPlugin = new FlutterLocalNotificationsPlugin();
    flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }

  @override
  Widget build(BuildContext context) {
    Future<dynamic> _showNotificationWithSound() async {
      var androidPlatformChannelSpecifics = new AndroidNotificationDetails(
          'your channel id', 'your channel name', 'your channel description',
          importance: Importance.high, priority: Priority.high);

      var iOSPlatformChannelSpecifics =
          new IOSNotificationDetails(sound: "slow_spring_board.aiff");

      var platformChannelSpecifics = new NotificationDetails(
          android: androidPlatformChannelSpecifics,
          iOS: iOSPlatformChannelSpecifics);

      await flutterLocalNotificationsPlugin.show(
        0,
        title,
        desc,
        platformChannelSpecifics,
        payload: 'No_Sound',
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Container(
        child: Padding(
            padding: EdgeInsets.all(20),
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              TextField(
                decoration: InputDecoration(hintText: "Enter Title"),
                onChanged: (value) {
                  setState(() {
                    title = value;
                  });
                },
              ),
              SizedBox(
                height: 20,
              ),
              TextField(
                  onChanged: (value) {
                    setState(() {
                      desc = value;
                    });
                  },
                  decoration: InputDecoration(
                    hintText: "Enter Description",
                  )),
              SizedBox(
                height: 20,
              ),
              FlatButton(
                  color: Colors.blue,
                  textColor: Colors.white,
                  onPressed: () {
                    _showNotificationWithSound();
                  },
                  child: Text('Show Notification')),
            ])),
      ),
    );
  }
}
