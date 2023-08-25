import 'package:flutter/material.dart';

class FormHelper {
  static Widget textInput(
    BuildContext context,
    Object initalValue,
    Function onChanged, {
    bool isTextArea = false,
    bool isNumberInput = false,
    obscureText = false,
    Function? onValidate,
    Widget? prefixIcon,
    Widget? suffixIcon,
  }) {
    return TextFormField(
        initialValue: initalValue != null ? initalValue.toString() : "",
        decoration: fieldDecoration(
          context,
          "",
          "",
          suffixIcon: suffixIcon,
        ),
        obscureText: obscureText,
        maxLines: !isTextArea ? 1 : 2,
        keyboardType: isNumberInput ? TextInputType.number : TextInputType.text,
        onChanged: (String value) {
          return onChanged(value);
        },
        validator: (value) {
          if (value == null) return null;

          final validator = onValidate;
          if (validator == null) return null;

          return validator(value.toString());
        });
  }

  static InputDecoration fieldDecoration(
    BuildContext context,
    String hintText,
    String helpertext, {
    Widget? prefixIcon,
    Widget? suffixIcon,
  }) {
    return InputDecoration(
        contentPadding: const EdgeInsets.all(6),
        hintText: hintText,
        helperText: helpertext,
        prefixIcon: prefixIcon,
        suffixIcon: suffixIcon,
        enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
          color: Theme.of(context).primaryColor,
          width: 1,
        )),
        border: OutlineInputBorder(
            borderSide: BorderSide(
          color: Theme.of(context).primaryColor,
          width: 1,
        )));
  }

  static Widget fieldLabel(String labelName) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 5, 0, 10),
      child: Text(
        labelName,
        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15.0),
      ),
    );
  }

  static Widget saveButton(String buttonText, Function onTap,
      {String? color, String? textColor, bool? fullWidth}) {
    return Container(
      height: 50.0,
      width: 150,
      child: GestureDetector(
        onTap: () {
          onTap();
        },
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.redAccent,
              style: BorderStyle.solid,
              width: 1.0,
            ),
            color: Colors.redAccent,
            borderRadius: BorderRadius.circular(30.0),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Center(
                child: Text(
                  buttonText,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 1,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  static void showMessage(
    BuildContext context,
    String title,
    String message,
    String buttonText,
    Function onPressed,
  ) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () {
                return onPressed();
              },
              child: Text(buttonText),
            )
          ],
        );
      },
    );
  }
}
