import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../provider/extras_provider.dart';

import '../../components/FormInput.dart' as formInput;
import '../../components/RoundedInput.dart';
import '../../constants.dart';

import '../../screens/signup/signup_org.dart';

import '../../theme/text_styles.dart';
import '../../theme/extention.dart';

class EditDataField extends StatefulWidget {
  final IconData icon, suffixIcon;
  final String dataText;
  final TextInputType keyboardType;
  final void Function(String) onChanged;
  final Function onSaved;
  final Function onClickedSuffixIcon;
  final FormFieldValidator<String> validator;
  final String type;

  EditDataField(
      {@required this.icon,
      @required this.dataText,
      this.keyboardType = TextInputType.name,
      this.suffixIcon,
      this.onChanged,
      this.onSaved,
      this.onClickedSuffixIcon,
      this.validator,
      this.type = 'normal'});

  @override
  _EditDataFieldState createState() => _EditDataFieldState();
}

class _EditDataFieldState extends State<EditDataField> {
  bool _isEditable = false;

  void toggleEditability() {
    setState(() {
      _isEditable = !_isEditable;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: _isEditable ? _editingData() : _currentData(),
    );
  }

  Widget _currentData() {
    return Row(
      children: [
        Icon(
          widget.icon,
          color: Colors.black,
        ),
        SizedBox(
          width: 10,
        ),
        Text(
          widget.dataText,
          style: TextStyles.body.copyWith(fontWeight: FontWeight.w400),
        ),
        Spacer(),
        FlatButton(
          child: Row(
            children: [
              Icon(
                Icons.edit,
                color: Colors.blue,
                size: 15,
              ),
              SizedBox(width: 3),
              Text('Edit',
                  style: TextStyle(
                      fontSize: FontSizes.bodySm,
                      fontWeight: FontWeight.w300,
                      color: Colors.blue,
                      decoration: TextDecoration.underline)),
            ],
          ),
          onPressed: toggleEditability,
        )
      ],
    ).ps(x: 20);
  }

  Widget _editingData() {
    return Row(
      children: [
        if (widget.type == 'normal')
          Flexible(
            child: RoundedInput(
              icon: widget.icon,
              initialValue: widget.dataText,
              autofocus: true,
              keyboardType: widget.keyboardType,
              onChanged: widget.onChanged,
              validator: widget.validator,
            ),
          ),
        if (widget.type == 'date')
          Flexible(
            child: RoundedInput(
              icon: widget.icon,
              initialValue: widget.dataText,
              autofocus: false,
              suffixIcon: widget.suffixIcon,
              validator: widget.validator,
            ).ripple(() {
              showDatePicker(
                      context: context,
                      initialDate: DateTime.parse(widget.dataText),
                      firstDate: DateTime(2000),
                      lastDate: DateTime.now())
                  .then((date) {
                var _pickedDate = DateFormat("yyyy-MM-dd")
                    .format(DateTime.parse(date.toString()));

                widget.onChanged(_pickedDate);
              });
            }),
          ),
        if (widget.type == 'type')
          Flexible(
            child: TextInputController(
              child: DropdownButtonFormField(
                value: widget.dataText,
                icon: Icon(
                  Icons.arrow_drop_down,
                  color: kPrimaryColor,
                ),
                decoration: InputDecoration(
                  prefixIcon: Icon(
                    widget.icon,
                    color: kPrimaryColor,
                  ),
                ),
                items: organizationType
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onChanged: widget.onChanged,
              ),
            ),
          ),
        FlatButton(
          padding: EdgeInsets.all(10),
          child: Row(
            children: [
              Icon(
                Icons.done,
                color: Colors.green,
                size: 15,
              ),
              SizedBox(width: 3),
              Text('Save',
                  style: TextStyle(
                      fontSize: FontSizes.bodySm,
                      fontWeight: FontWeight.w300,
                      color: Colors.green,
                      decoration: TextDecoration.underline)),
            ],
          ),
          onPressed: () {
            widget.onSaved();
            toggleEditability();
          },
        )
      ],
    ).ps(x: 15);
  }
}

class DescriptionSection extends StatefulWidget {
  final String description;
  final String id;

  DescriptionSection(this.description, this.id);

  @override
  _DescriptionSectionState createState() => _DescriptionSectionState();
}

class _DescriptionSectionState extends State<DescriptionSection> {
  bool isEditable = false;

  toggleEditability() {
    setState(() {
      isEditable = !isEditable;
    });
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<ExtrasProvider>(context);

    if (widget.id == user.id) {
      return Container(
          child: !isEditable
              ? Container(
                  child: user.description == null || user.description == ''
                      ? FlatButton(
                          onPressed: toggleEditability,
                          textColor: Colors.blue,
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text('Add a Description'),
                                SizedBox(width: 3),
                                Icon(
                                  Icons.edit,
                                  size: 15,
                                )
                              ]))
                      : Column(children: [
                          Text(
                            user.description,
                            textAlign: TextAlign.justify,
                            style: TextStyle(
                              fontSize: FontSizes.bodySm,
                              fontWeight: FontWeight.w400,
                              height: 1.8,
                              letterSpacing: 0.4,
                            ),
                          ).ps(x: 15),
                          FlatButton(
                              textColor: Colors.blue,
                              onPressed: toggleEditability,
                              child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text('Edit'),
                                    SizedBox(width: 3),
                                    Icon(
                                      Icons.edit,
                                      size: 15,
                                    )
                                  ])),
                        ]))
              : Column(children: [
                  formInput.FormInput(
                    hintText: 'Add your description',
                    value: user.description,
                    onChanged: (value) {
                      user.changeDescription(value.trim());
                    },
                    capitalization: TextCapitalization.sentences,
                    autofocus: true,
                    maxlines: 3,
                    maxlength: 200,
                  ),
                  FlatButton(
                    textColor: Colors.blue,
                    onPressed: () {
                      user.saveDescription();
                      toggleEditability();
                    },
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.save,
                            size: 15,
                          ),
                          SizedBox(width: 3),
                          Text('Save'),
                        ]),
                  )
                ]));
    } else {
      return Text(
        widget.description == null || widget.description == '' ? '' : widget.description ,
        textAlign: TextAlign.justify,
        style: TextStyle(
          fontSize: FontSizes.bodySm,
          fontWeight: FontWeight.w400,
          height: 1.8,
          letterSpacing: 0.4,
        ),
      ).ps(x: 15);
    }
  }
}
