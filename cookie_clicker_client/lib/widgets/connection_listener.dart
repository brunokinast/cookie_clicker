import 'dart:io';

import 'package:cookie_clicker_client/cookie_client.dart';
import 'package:flutter/material.dart';

class ConnectionListener extends StatefulWidget {
  final CookieClient client;
  final Widget child;

  const ConnectionListener({
    super.key,
    required this.client,
    required this.child,
  });

  @override
  State<ConnectionListener> createState() => _ConnectionListenerState();
}

class _ConnectionListenerState extends State<ConnectionListener> {
  InternetAddress _address = InternetAddress.loopbackIPv4;
  int _port = 6789;

  void _onConnectionError(BuildContext context, String error) {
    showDialog(
      context: context,
      builder: (context) {
        TextEditingController addressController = TextEditingController();
        TextEditingController portController = TextEditingController();

        return Dialog(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(error),
              TextField(
                controller: addressController,
                decoration: const InputDecoration(
                  labelText: 'Address',
                ),
              ),
              TextField(
                controller: portController,
                decoration: const InputDecoration(
                  labelText: 'Port',
                ),
              ),
              TextButton(
                onPressed: () {
                  _address = InternetAddress(addressController.text);
                  _port = int.parse(portController.text);
                  Navigator.of(context).pop();
                  setState(() {});
                },
                child: const Text('Connect'),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: widget.client.connect(address: _address, port: _port),
      builder: (context, snap) {
        if (snap.hasError) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            _onConnectionError(context, '${snap.error}');
          });
        } else if (snap.connectionState == ConnectionState.done) {
          return widget.child;
        }
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }
}
