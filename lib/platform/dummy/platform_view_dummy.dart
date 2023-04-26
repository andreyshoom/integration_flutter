import 'package:flutter/material.dart';

class PlatformWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      height: 20,
      width: 200,
      child: Text('Platform is not supported!'),
    );
  }
}
