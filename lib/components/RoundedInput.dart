import 'package:flutter/material.dart';
import '../constants.dart';

class RoundedInput extends StatelessWidget {
  final String hintText;
  final IconData icon,suffixIcon;
  final TextEditingController controller;
  final bool obscureText;
  final Function onClickedSuffixIcon;
  final TextInputType keyboardType;
  final TextCapitalization capitalization;
  final bool enableSuggesstion;
  final FormFieldSetter<String> onSaved;
  final FormFieldValidator<String> validator;
  final Key key;
  const RoundedInput({
    this.key, //TODO: have a look at these key value
    this.hintText,
    this.controller,
    this.icon = Icons.person,
    this.onSaved,
    this.obscureText = false,
    this.onClickedSuffixIcon,
    this.suffixIcon,
    this.keyboardType,
    this.capitalization = TextCapitalization.none,
    this.enableSuggesstion = false,
    this.validator,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextInputController(
      child: TextFormField(
        controller: controller,
        key: key,
        autocorrect: false,
        textCapitalization: capitalization,
        enableSuggestions: enableSuggesstion,
        obscureText: obscureText,
        keyboardType: keyboardType,
        onSaved: onSaved,
        validator: validator,
        decoration: InputDecoration(
          hintText: hintText,
          icon: Icon(
            icon,
            color: kPrimaryColor,
          ),
          suffixIcon: IconButton(
            icon: Icon(
              suffixIcon,
              color: kPrimaryColor,
            ),
            onPressed: onClickedSuffixIcon,
          ),
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
      width: size.width * 0.8,
      margin: EdgeInsets.symmetric(vertical: 10),
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 0),
      decoration: BoxDecoration(
        color: kPrimaryLightColor,
        borderRadius: BorderRadius.circular(30),
      ),
      child: child,
    );
  }
}
