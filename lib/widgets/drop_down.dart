import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class DropDown<T> extends StatefulWidget {
  final T value;
  final ValueChanged<T> onChanged;
  final String hintText;
  final String labelText;
  final List<T> list;
  final FormFieldValidator<T> validator;
  final FormFieldSetter<T> onSaved;
  final Widget prefixIcon;

  const DropDown({
    Key key,
    this.value,
    @required this.onChanged,
    this.hintText,
    this.labelText,
    @required this.list,
    @required this.validator,
    @required this.onSaved,
    this.prefixIcon,
  }) : super(key: key);

  @override
  _DropDownState<T> createState() => _DropDownState<T>();
}

class _DropDownState<T> extends State<DropDown<T>> {
  FocusNode _focus = new FocusNode();

  @override
  void initState() {
    super.initState();
    _focus.addListener(_onFocusChange);
  }

  void _onFocusChange() {
    if (mounted) setState(() {});
  }

  @override
  void dispose() {
    _focus?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.labelText,
          style: Theme.of(context).textTheme.headline2.copyWith(fontSize: 16),
        ),
        SizedBox(height: 6),
        DropdownButtonFormField<T>(
          icon: Padding(
            padding: EdgeInsets.only(right: 5.0),
            child: SvgPicture.asset('assets/svg/arrow_downward.svg'),
          ),
          value: widget.value,
          onChanged: widget.onChanged,
          hint: Text(
            widget.hintText,
            style: Theme.of(context).textTheme.headline2.copyWith(fontSize: 16),
          ),
          focusNode: _focus,
          validator: widget.validator,
          onSaved: widget.onSaved,
          items: widget.list
              ?.map((T e) => DropdownMenuItem<T>(value: e, child: Text('$e')))
              ?.toList(),
          decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(
              horizontal: 10,
              vertical: 17.6,
            ),
            hintStyle:
                Theme.of(context).textTheme.headline2.copyWith(fontSize: 16),
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
          ),
        ),
        SizedBox(
          height: 21,
        ),
      ],
    );
  }
}
