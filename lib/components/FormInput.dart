import 'package:flutter/material.dart';
import '../constants.dart';

class FormInput extends StatelessWidget {
  final String hintText;
  final TextInputType keyboardType;
  final TextCapitalization capitalization;
  final bool enableSuggesstion;
  final FormFieldSetter<String> onSaved;
  final FormFieldValidator<String> validator;
  final Key key;
  final int maxlines;
  final int maxlength;
  final bool autofocus;
  const FormInput({
    this.key, //TODO: have a look at these key value
    this.hintText,
    this.onSaved,
    this.keyboardType,
    this.capitalization = TextCapitalization.none,
    this.enableSuggesstion = false,
    this.validator,
    this.maxlines,
    this.maxlength,
    this.autofocus = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextInputController(
      child: TextFormField(
        key: key,
        autocorrect: false,
        autofocus: autofocus,
        textCapitalization: capitalization,
        enableSuggestions: enableSuggesstion,
        keyboardType: keyboardType,
        onSaved: onSaved,
        validator: validator,
        maxLength: maxlength,
        maxLines: maxlines,
        decoration: InputDecoration(
          hintText: hintText,
          border: InputBorder.none,
        ),
      ),
    );
  }
}

class TextInputController extends StatelessWidget {
  final Widget child;
  const TextInputController({
    Key key,
    this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Container(
      width: size.width * 0.9,
      margin: EdgeInsets.symmetric(vertical: 10),
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 0),
      decoration: BoxDecoration(
        color: kPrimaryLightColor,
        borderRadius: BorderRadius.circular(20),
      ),
      child: child,
    );
  }
}
