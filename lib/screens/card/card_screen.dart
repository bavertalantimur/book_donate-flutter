import 'package:flutter/material.dart';

class CardScreen extends StatelessWidget {
  const CardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Stripe Example'),
      ),
      body: ListView(
        children: [
          ListTile(
            onTap: () {
              /* Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => CardFormScreen()),
              );*/
            },
            title: const Text('Go to the Card Form'),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: const [
                Icon(Icons.chevron_right_rounded),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
