import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';

class CustomDialog extends StatelessWidget {
  final primaryColor = const Color(0xFF2DACFE);
  final grayColor = const Color(0xFF939393);

  final String title, description, primaryButtonText, secondaryButtonText;
  final VoidCallback primaryButton, secondaryButton;

  CustomDialog(
      {@required this.title,
      @required this.description,
      @required this.primaryButtonText,
      @required this.primaryButton,
      this.secondaryButtonText,
      this.secondaryButton});

  static const double padding = 20.0;

  @override
  Widget build(BuildContext context) {
    final elevatedButtonStyle = ElevatedButton.styleFrom(
      primary: primaryColor,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
    );
    return Dialog(
      shape:
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(padding)),
      child: Stack(
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(padding),
            decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.circular(padding),
                boxShadow: [
                  BoxShadow(
                      color: Colors.black,
                      blurRadius: 10.0,
                      offset: const Offset(1.0, 10.0))
                ]),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                SizedBox(height: 24.0),
                AutoSizeText(
                  title,
                  maxLines: 2,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontFamily: "Poppins-Medium",
                      color: Color(0xFF65c6f4),
                      fontSize: 20.0),
                ),
                SizedBox(height: 18.0),
                AutoSizeText(
                  description,
                  maxLines: 4,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: grayColor,
                      fontSize: 16.0,
                      fontFamily: "Poppins-Medium"),
                ),
                SizedBox(height: 18.0),
                ElevatedButton(
                  style: elevatedButtonStyle,
                  onPressed: () {
                    primaryButton();
                  },
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                    child: AutoSizeText(
                      primaryButtonText,
                      maxLines: 1,
                      style: TextStyle(
                          fontSize: 18,
                          color: Colors.white,
                          fontFamily: "Poppins-Medium"),
                    ),
                  ),
                ),
                SizedBox(height: 10.0),
                showSecondaryButton(context),
              ],
            ),
          ),
        ],
      ),
    );
  }

  showSecondaryButton(BuildContext context) {
    if (secondaryButton != null && secondaryButtonText != null) {
      return TextButton(
        child: AutoSizeText(
          secondaryButtonText,
          maxLines: 1,
          style: TextStyle(
              fontSize: 18,
              color: Color(0xFF65c6f4),
              fontWeight: FontWeight.w400),
        ),
        onPressed: () {
          secondaryButton();
        },
      );
    } else {
      return SizedBox(height: 10.0);
    }
  }
}
