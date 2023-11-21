import 'dart:io';

import 'package:cookie_clicker_client/app/cookie_client.dart';
import 'package:flutter/material.dart';

class ConnectionPage extends StatelessWidget {
  final CookieClient client;
  final Widget child;

  ConnectionPage({
    super.key,
    required this.client,
    required this.child,
  });

  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _addressController =
      TextEditingController(text: InternetAddress.loopbackIPv4.address);
  final TextEditingController _portController =
      TextEditingController(text: '6789');

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: client.connection,
      builder: (context, snap) {
        if (!snap.hasData || snap.data == false) {
          return Scaffold(
            appBar: AppBar(
              title: const Text('Connect'),
            ),
            body: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextField(
                  controller: _usernameController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Username',
                  ),
                ),
                const SizedBox(height: 8),
                TextField(
                  controller: _addressController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Address',
                  ),
                ),
                TextField(
                  controller: _portController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Port',
                  ),
                ),
                const SizedBox(height: 8),
                ElevatedButton(
                  onPressed: () {
                    final address = InternetAddress(_addressController.text);
                    final port = int.parse(_portController.text);
                    client.connect(
                      address: address,
                      port: port,
                    );
                  },
                  child: const Text('Connect'),
                ),
              ],
            ),
          );
        }
        return child;
      },
    );
  }
}
