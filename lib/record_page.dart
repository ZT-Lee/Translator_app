import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'translate_provider.dart';
import 'package:provider/provider.dart';
import 'package:speech_to_text/speech_to_text.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_recognition_error.dart';
import 'package:translator/translator.dart';
import 'language.dart';

class RecordPage extends StatefulWidget {
  RecordPage({
    Key? key,
    required this.firstLanguage,
    required this.secondLanguage,
  }) : super(key: key);
  Language firstLanguage;
  Language secondLanguage;
  @override
  _RecordPageState createState() => _RecordPageState();
}

class _RecordPageState extends State<RecordPage> {
  GoogleTranslator _translator = new GoogleTranslator();

  late TranslateProvider _translateProvider;
  var _speech = SpeechToText();

  String _speechText = "";
  String _textTranslated = '';

  @override
  void initState() {
    super.initState();
    _initSpeechToText();
  }

  @override
  void deactivate() {
    _speech.cancel();
    _speech.stop();

    super.deactivate();
  }

  @override
  void dispose() {
    _speech.cancel();
    _speech.stop();

    super.dispose();
  }

  Future<void> _initSpeechToText() async {
    bool available = await _speech.initialize(
        onStatus: _statusListener, onError: _errorListener);

    if (available) {
      _speech.listen(
        onResult: _resultListener,
      );
    } else {
      print("The user has denied the use of speech recognition.");
    }
  }

  void _resultListener(SpeechRecognitionResult result) {
    if (!result.finalResult && _speech.lastStatus != "notListening") {
      setState(() {
        _speechText = result.recognizedWords;
        if (_speechText != "") {
          _translator
              .translate(_speechText,
                  from: this.widget.firstLanguage.code,
                  to: this.widget.secondLanguage.code)
              .then((translatedText) {
            this.setState(() {
              this._textTranslated = translatedText.toString();
            });
          });
        } else {
          this.setState(() {
            this._textTranslated = "";
          });
        }
      });
    }
  }

  void _errorListener(SpeechRecognitionError error) {
    print("${error.errorMsg} - ${error.permanent}");
  }

  void _statusListener(String status) {
    print("$status");
  }

  @override
  Widget build(BuildContext context) {
    _translateProvider = Provider.of<TranslateProvider>(context, listen: true);

    return Scaffold(
      backgroundColor: Colors.white,
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.dark,
        child: Container(
          margin: EdgeInsets.only(
            top: kToolbarHeight,
            left: 16,
            right: 16,
            bottom: 16,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Expanded(
                child: Text(
                  _speechText != '' ? _speechText : 'Talk now',
                  style: TextStyle(
                    color: Colors.black54,
                    fontSize: 22,
                    fontWeight: FontWeight.w300,
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(bottom: 8),
                height: 180,
                child: Stack(
                  children: <Widget>[
                    Align(
                      alignment: Alignment.bottomLeft,
                      child: IconButton(
                        icon: Icon(
                          Icons.close,
                          color: Colors.black54,
                        ),
                        onPressed: () {
                          Navigator.pop(context, _speechText);
                        },
                      ),
                    ),
                    Center(
                      child: Column(
                        children: <Widget>[
                          Container(
                            margin: EdgeInsets.only(top: 12),
                            child: Text(
                              this._textTranslated,
                              style: TextStyle(
                                color: Colors.black45,
                                fontSize: 30,
                                fontWeight: FontWeight.w300,
                              ),
                            ),
                          ),
                        ],
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
}
