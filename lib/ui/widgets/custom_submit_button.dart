import 'package:flutter/material.dart';

class CustomSubmitButton extends StatelessWidget {
  final String title;
  final Color textColor;
  final double borderRadius;
  final double fontSize;
  final Stream stream;
  final FontWeight fontWeight;
  final VoidCallback onPressed;
  final Color buttonColor;
  final Color splashColor;
  final Color borderColor;
  final double borderWidth;
  final double elevation;

  CustomSubmitButton({
      this.title,
      this.textColor,
      this.borderRadius,
      this.fontSize,
      this.stream,
      this.fontWeight,
      this.onPressed,
      this.buttonColor,
      this.splashColor,
      this.borderColor,
      this.borderWidth,
      this.elevation,
  });


  @override
  Widget build(BuildContext context) {
    return StreamBuilder<Object>(
      stream: stream,
      builder: (context, snapshot) {
        return Material(
          elevation: elevation,
          borderRadius: BorderRadius.circular(borderRadius),
          color: buttonColor,
          child: MaterialButton(
            minWidth: MediaQuery.of(context).size.width,
            padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
            splashColor: splashColor,
            onPressed: snapshot.hasData ? onPressed : null,
            child: Text(title, //"S I G N  I N"
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: textColor,
                  fontWeight: FontWeight.bold
                )
            ),
          ),
        );
      }
    );
  }

}




