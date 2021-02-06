import 'package:flrx_validator/flrx_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class TextDataField extends StatefulWidget {
  final TextEditingController controller;
  final String labelName;
  final String initialValue;
  final String hintText;
  final int maxLength;
  final bool autofocus;
  final Function onSaved;
  final Validator validator;
  final TextInputType keyboardType;
  final Widget suffixIcon;
  final List<TextInputFormatter> inputFormatters;

  TextDataField({
    this.controller,
    this.labelName,
    this.initialValue,
    this.autofocus = false,
    this.onSaved,
    this.validator,
    this.hintText,
    this.keyboardType = TextInputType.text,
    this.suffixIcon,
    this.inputFormatters,
    this.maxLength,
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
          autofocus: widget.autofocus,
          maxLength: widget.maxLength,
          controller: widget.controller,
          keyboardType: widget.keyboardType == TextInputType.number
              ? TextInputType.number
              : widget.keyboardType,
          inputFormatters: widget.inputFormatters ??
              (widget.keyboardType == TextInputType.number
                  ? [FilteringTextInputFormatter.digitsOnly]
                  : null),
          initialValue: widget.initialValue,
          onSaved: widget.onSaved,
          validator: widget.validator,
          decoration: InputDecoration(
            counterText: "",
            hintText: widget.hintText,
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
