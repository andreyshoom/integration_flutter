import 'package:int_flutter/platform/service.dart';
import 'platform/dummy/platform_view_dummy.dart'
    if (dart.library.html) 'platform/web/platform_view_web.dart'
    if (dart.library.io) 'platform/mobile/platform_view_mobile.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final service = getService();

  @override
  Widget build(BuildContext context) {
    final style = Theme.of(context).textTheme.headline6;
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'UI componetn from platform',
            ),
            Center(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: PlatformWidget(),
              ),
            ),
            Text(
              'stream from platform:',
              style: style,
            ),
            StreamBuilder<String>(
              stream: service.getStream(),
              builder: (context, snapshot) => Text(
                '${snapshot.hasData ? snapshot.data : 'No data'}',
                style: style,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
