import 'package:flutter/material.dart';

class CustomTextField extends StatefulWidget {
  final String hint;
  final String label;
  final String fontFamily;
  final double fontSize;
  final Stream stream;
  final Color textColor;
  final Color baseColor;
  final Color errorColor;
  final TextInputType inputType;
  final bool obscureText;
  final ValueChanged<String> onChanged;

  CustomTextField({
      this.hint,
      this.label,
      this.fontFamily,
      this.fontSize,
      this.stream,
      this.textColor,
      this.onChanged,
      this.baseColor,
      this.errorColor,
      this.inputType = TextInputType.text,
      this.obscureText = false,
  });

  @override
  _CustomTextFieldState createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  Color currentColor;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return StreamBuilder(
      stream: widget.stream,
      builder: (context, snapshot) {
        return TextField(
          onChanged: widget.onChanged,
          keyboardType: widget.inputType,
          obscureText: widget.obscureText,
          decoration: InputDecoration(
              hintText: widget.hint,
              labelText: widget.label,
              errorText: snapshot.error
          ),
          style: TextStyle(
            color: widget.textColor,
            fontSize: widget.fontSize,
            fontWeight: FontWeight.w600,
            fontFamily: widget.fontFamily
          ),
        );
      },
    );
  }
}
