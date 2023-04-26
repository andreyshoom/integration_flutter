import 'package:flutter/material.dart';

class PlatformWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: const [
        SizedBox(
          height: 50,
          width: 185,
          child: HtmlElementView(
            viewType: 'web-input',
            onPlatformViewCreated: _onPlatformViewCreated,
          ),
        ),
        SizedBox(
          height: 10,
        ),
        SizedBox(
          height: 50,
          width: 180,
          child: HtmlElementView(
            viewType: 'web-button',
            onPlatformViewCreated: _onPlatformViewCreated,
          ),
        ),
      ],
    );
  }
}

void _onPlatformViewCreated(int id) {
  print('PlatfromView with id:$id created');
}
