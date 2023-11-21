import 'package:cookie_clicker_client/cookie_client.dart';
import 'package:cookie_clicker_client/cookie_manager.dart';
import 'package:cookie_clicker_client/widgets/connection_listener.dart';
import 'package:flutter/material.dart';

final CookieClient cookieClient = CookieClient();
final CookieManager cookieManager = CookieManager(cookieClient);

void main() {
  runApp(const CookieClicker());
}

class CookieClicker extends StatelessWidget {
  const CookieClicker({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Cookie Clicker Multiplayer',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: ConnectionListener(
        client: cookieClient,
        child: const CookiePage(),
      ),
    );
  }
}

class CookiePage extends StatefulWidget {
  const CookiePage({super.key});

  @override
  State<CookiePage> createState() => _CookiePageState();
}

class _CookiePageState extends State<CookiePage> {
  int _counter = 0;

  @override
  void initState() {
    cookieManager.count.listen((count) {
      setState(() {
        _counter = count;
      });
    });
    super.initState();
  }

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Cookie Clicker Multiplayer'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
