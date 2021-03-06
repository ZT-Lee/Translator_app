import 'package:flutter/material.dart';

class ActionButton extends StatefulWidget {
  ActionButton(
      {Key? key, required this.icon, required this.text, required this.onClick})
      : super(key: key);

  final IconData icon;
  final String text;
  final Function onClick;

  @override
  _ActionButtonState createState() => _ActionButtonState();
}

class _ActionButtonState extends State<ActionButton> {
  Widget _displayIcon() {
    if (this.widget.icon != null) {
      return Icon(
        this.widget.icon,
        size: 25,
        color: Colors.orange[200],
      );
    } else {
      return Container();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      child: FlatButton(
        padding: EdgeInsets.only(
          left: 8.0,
          right: 8.0,
          top: 2.0,
          bottom: 2.0,
        ),
        onPressed: () {
          widget.onClick();
        },
        child: Column(
          children: <Widget>[
            _displayIcon(),
            Text(
              this.widget.text,
              style: TextStyle(fontSize: 13),
            ),
          ],
        ),
      ),
    );
  }
}
