import 'package:flrx_validator/flrx_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class TextDataField extends StatefulWidget {
  final TextEditingController controller;
  final String labelName;
  final String initialValue;
  final String hintText;
  final Function onSaved;
  final Validator validator;
  final TextInputType keyboardType;
  final Widget suffixIcon;
  final List<TextInputFormatter> inputFormatters;

  TextDataField({
    this.controller,
    this.labelName,
    this.initialValue,
    this.onSaved,
    this.validator,
    this.hintText,
    this.keyboardType,
    this.suffixIcon,
    this.inputFormatters,
  });

  @override
  _TextDataFieldState createState() => _TextDataFieldState();
}

class _TextDataFieldState extends State<TextDataField> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '${widget.labelName}',
          style: Theme.of(context).textTheme.headline2.copyWith(fontSize: 16),
        ),
        SizedBox(
          height: 6,
        ),
        TextFormField(
          controller: widget.controller,
          keyboardType: widget.keyboardType == TextInputType.number
              ? TextInputType.number
              : TextInputType.text,
          inputFormatters: widget.inputFormatters ??
              (widget.keyboardType == TextInputType.number
                  ? [FilteringTextInputFormatter.digitsOnly]
                  : null),
          initialValue: widget.initialValue,
          onSaved: widget.onSaved,
          validator: widget.validator,
          decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(
              horizontal: 10,
              vertical: 17.6,
            ),
            hintText: widget.hintText,
            hintStyle: Theme.of(context).textTheme.headline2,
            isDense: true,
            filled: true,
            fillColor: Theme.of(context).cardColor,
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5),
              borderSide: BorderSide(
                color: Colors.transparent,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5),
              borderSide: BorderSide(
                color: Colors.transparent,
              ),
            ),
            suffixIcon: widget.suffixIcon,
          ),
        ),
        SizedBox(
          height: 21,
        ),
      ],
    );
  }
}
