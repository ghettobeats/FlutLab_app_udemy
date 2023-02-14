import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AdaptiveFlatButton extends StatelessWidget {
  final VoidCallback handler;
  final String text;

  AdaptiveFlatButton(this.handler, this.text);

  @override
  Widget build(BuildContext context) => Platform.isAndroid
      ? CupertinoButton(
          child: Text(
            text,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          onPressed: handler,
        )
      : TextButton(
          onPressed: handler,
          child: Text(
            text,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          style: TextButton.styleFrom(primary: Theme.of(context).primaryColor),
        );
}
