import 'dart:io';

import 'package:cookie_clicker_client/app/cookie_client.dart';
import 'package:cookie_clicker_client/app/cookie_manager.dart';
import 'package:cookie_clicker_client/widgets/stone_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ConnectionPage extends StatelessWidget {
  final CookieClient client;
  final CookieManager manager;
  final Widget child;

  ConnectionPage({
    super.key,
    required this.client,
    required this.manager,
    required this.child,
  });

  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _addressController =
      TextEditingController(text: InternetAddress('10.0.2.2').address);
  final TextEditingController _portController =
      TextEditingController(text: '6789');

  TextField _buildTextField({
    required TextEditingController controller,
    required String labelText,
    required String hintText,
  }) {
    return TextField(
      controller: controller,
      // Black input box with white text
      style: const TextStyle(color: Colors.white),
      decoration: InputDecoration(
        fillColor: Colors.black54,
        filled: true,
        labelText: labelText,
        labelStyle: const TextStyle(color: Colors.white),
        hintText: hintText,
        hintStyle: const TextStyle(color: Colors.white),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final connected = client.connected.value;
      if (!connected) {
        return Scaffold(
          body: Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/background.jpg'),
                repeat: ImageRepeat.repeat,
              ),
            ),
            child: SafeArea(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    color: Colors.black54,
                    child: const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          Text(
                            'Cookie Clicker',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 32,
                              fontWeight: FontWeight.bold,
                              fontStyle: FontStyle.italic,
                              color: Colors.white,
                            ),
                          ),
                          Text(
                            'Multiplayer',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 20,
                              fontStyle: FontStyle.italic,
                              color: Colors.white,
                              height: 1,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(30),
                    child: Column(
                      children: [
                        _buildTextField(
                          controller: _usernameController,
                          labelText: 'Username',
                          hintText: 'Enter a username',
                        ),
                        const SizedBox(height: 30),
                        _buildTextField(
                          controller: _addressController,
                          labelText: 'Address',
                          hintText: 'Enter an address',
                        ),
                        const SizedBox(height: 8),
                        _buildTextField(
                          controller: _portController,
                          labelText: 'Port',
                          hintText: 'Enter a port',
                        ),
                        const SizedBox(height: 8),
                        ValueBuilder<bool?>(
                          initialValue: true,
                          builder: (enabled, setEnabled) => StoneButton(
                            enabled: enabled ?? true,
                            onPressed: () async {
                              if (_usernameController.text.isEmpty) {
                                showDialog(
                                  context: context,
                                  builder: (context) => AlertDialog(
                                    title:
                                        const Text('Please enter a username'),
                                    actions: [
                                      TextButton(
                                        onPressed: () => Navigator.pop(context),
                                        child: const Text('OK'),
                                      ),
                                    ],
                                  ),
                                );
                              } else {
                                final address =
                                    InternetAddress(_addressController.text);
                                final port = int.parse(_portController.text);
                                setEnabled(false);
                                try {
                                  await client.connect(
                                    address: address,
                                    port: port,
                                  );
                                  manager.register(_usernameController.text);
                                } catch (e) {
                                  if (context.mounted) {
                                    showDialog(
                                      context: context,
                                      builder: (context) => AlertDialog(
                                        title: const Text('Error'),
                                        content: Text(e.toString()),
                                        actions: [
                                          TextButton(
                                            onPressed: () =>
                                                Navigator.pop(context),
                                            child: const Text('OK'),
                                          ),
                                        ],
                                      ),
                                    );
                                  }
                                } finally {
                                  setEnabled(true);
                                }
                              }
                            },
                            child: const Padding(
                              padding: EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 20),
                              child: Text(
                                'Connect',
                                style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                  fontStyle: FontStyle.italic,
                                  color: Colors.black54,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      }
      return child;
    });
  }
}
