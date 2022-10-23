import 'dart:async';
// import 'dart:html';
import 'dart:io';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:sensors_plus/sensors_plus.dart';
import 'package:http/http.dart' as http;
import 'package:csv/csv.dart';
import 'package:path_provider/path_provider.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '16 absolute App',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: const MyHomePage(title: '16 absolute App'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, this.title}) : super(key: key);

  final String? title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

final myController = TextEditingController();

class _MyHomePageState extends State<MyHomePage> {
  bool check = false;
  double ax = 0, ay = 0, az = 0;
  double gx = 0, gy = 0, gz = 0;
  int count = 0;
  List<double>? _accelerometerValues;
  List<double>? _gyroscopeValues;

  Future<http.Response> sendData() {
    print(myController.text);

    final url = Uri.parse(myController.text);
    return http.post(url,
        body: json.encode(
            {'ax': ax, 'ay': ay, 'az': az, 'gx': gx, 'gy': gy, 'gz': gz}));
  }

  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();

    return directory.path;
  }

  // void get_Data() async {
  //   _streamSubscriptions.add(
  //     accelerometerEvents.listen(
  //       (AccelerometerEvent event) {
  //         setState(() {
  //           _accelerometerValues = <double>[event.x, event.y, event.z];
  //           ax = event.x;
  //           ay = event.y;
  //           az = event.z;
  //         });
  //       },
  //     ),
  //   );
  //   _streamSubscriptions.add(
  //     gyroscopeEvents.listen(
  //       (GyroscopeEvent event) {
  //         setState(() {
  //           _gyroscopeValues = <double>[event.x, event.y, event.z];
  //           gx = event.x;
  //           gy = event.y;
  //           gz = event.z;
  //         });
  //       },
  //     ),
  //   );
  //   String csv = const ListToCsvConverter().convert([
  //     [ax, ay, az, gx, gy, gz]
  //   ]);
  //   csv = csv + "\n";
  //   final directory = await getApplicationDocumentsDirectory();
  //   final pathOfTheFileToWrite = directory.path + "/running_1.csv";
  //   File file = await File(pathOfTheFileToWrite);
  //   await file.writeAsString(csv, mode: FileMode.append, flush: true);
  //   // print("*");

  //   // print(pathOfTheFileToWrite);
  //   // print("kkkkkk");

  //   if (count<5000)
  //     {
  //       get_Data();
  //     }
  //      count++;

  // }

  var _streamSubscriptions = <StreamSubscription<dynamic>>[];

  @override
  Widget build(BuildContext context) {
    if (check) {
      final accelerometer = _accelerometerValues
          ?.map((double v) => v.toStringAsFixed(1))
          .toList();
      final gyroscope =
          _gyroscopeValues?.map((double v) => v.toStringAsFixed(1)).toList();
      sendData();

      return Scaffold(
        appBar: AppBar(
          title: const Text('16 absolute App'),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(14.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    'Accelerometer: $accelerometer',
                    style: TextStyle(fontSize: 15.0),
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(14.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text('Gyroscope: $gyroscope',
                      style: TextStyle(fontSize: 15.0)),
                ],
              ),
            ),
            ElevatedButton(
                onPressed: () {
                  setState(() {
                    check = false;
                    _streamSubscriptions = <StreamSubscription<dynamic>>[];
                  });
                },
                style: ElevatedButton.styleFrom(primary: Colors.red),
                child: Text(
                  "Stop",
                  style: TextStyle(fontSize: 20.0),
                ))
          ],
        ),
      );
    } else {
      return Scaffold(
        appBar: AppBar(
          title: const Text('16 absolute App'),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Container(
                width: 550.0,
                child: TextField(
                  controller: myController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Enter a link for server',
                  ),
                )),
            Padding(
              padding: const EdgeInsets.all(14.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text('Accelerometer: ', style: TextStyle(fontSize: 15.0)),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(14.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    'Gyroscope: ', style: TextStyle(fontSize: 15.0),
                    // style:T
                  ),
                ],
              ),
            ),
            ElevatedButton(
                onPressed: () {
                  setState(() {
                    check = true;
                    _streamSubscriptions = <StreamSubscription<dynamic>>[];

                    // get_Data();
                  });
                },
                style: ElevatedButton.styleFrom(primary: Colors.teal),
                child: Text(
                  "Start",
                  style: TextStyle(fontSize: 20.0),
                ))
          ],
        ),
      );
    }
  }

  @override
  void dispose() {
    super.dispose();
    for (final subscription in _streamSubscriptions) {
      subscription.cancel();
    }
  }

  @override
  void initState() {
    super.initState();
    _streamSubscriptions.add(
      accelerometerEvents.listen(
        (AccelerometerEvent event) {
          setState(() {
            _accelerometerValues = <double>[event.x, event.y, event.z];
            child:
            Text(
              "X axis",
              style: TextStyle(fontSize: 20.0),
            );
          });
        },
      ),
    );
    _streamSubscriptions.add(
      gyroscopeEvents.listen(
        (GyroscopeEvent event) {
          setState(() {
            _gyroscopeValues = <double>[event.x, event.y, event.z];
          });
        },
      ),
    );
  }
}
