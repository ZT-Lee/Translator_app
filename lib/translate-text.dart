// ignore_for_file: file_names, prefer_const_constructors_in_immutables, sized_box_for_whitespace, prefer_const_constructors

import 'package:flutter/material.dart';
import 'action-button.dart';
import 'record_page.dart';
import 'translate_provider.dart';
import 'language.dart';

class TranslateText extends StatefulWidget {
  TranslateText({
    Key? key,
    required this.onTextTouched,
    required this.firstLanguage,
    required this.secondLanguage,
  }) : super(key: key);
  final Function(bool) onTextTouched;
  Language firstLanguage;
  Language secondLanguage;
  @override
  _TranslateTextState createState() => _TranslateTextState();
}

class _TranslateTextState extends State<TranslateText> {
  late TranslateProvider _translateProvider;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      margin: EdgeInsets.all(0.0),
      elevation: 2.0,
      child: Container(
        height: 150.0,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Expanded(
              child: InkWell(
                onTap: () {
                  this.widget.onTextTouched(true);
                },
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.only(left: 16.0, right: 16.0, top: 16.0),
                  child: Text(
                    "Enter text",
                    style: TextStyle(
                      color: Colors.grey[700],
                    ),
                  ),
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                ActionButton(
                  onClick: () async {
                    var result = await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => RecordPage(
                            firstLanguage: this.widget.firstLanguage,
                            secondLanguage: this.widget.secondLanguage),
                      ),
                    );

                    if (result != null && result != "") {
                      _translateProvider.setTextToTranslate(result);
                      _translateProvider.setIsTranslating(true);
                    }
                  },
                  icon: Icons.keyboard_voice,
                  text: "Speak",
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
