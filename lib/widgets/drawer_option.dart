import 'package:flutter/material.dart';

class DrawerOption extends StatelessWidget {
  DrawerOption({
    this.optionName,
    this.onPressed,
    this.remove = false,
    this.update = false,
  });
  final String optionName;
  final Function onPressed;
  final bool remove;
  final bool update;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 24, left: 16),
      child: InkWell(
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        focusColor: Colors.transparent,
        hoverColor: Colors.transparent,
        onTap: onPressed,
        child: Row(
          children: [
            remove
                ? Icon(
                    Icons.remove_circle,
                    color: Theme.of(context).errorColor,
                    size: 28,
                  )
                : update
                    ? Icon(
                        Icons.update,
                        color: Theme.of(context).accentColor,
                        size: 28,
                      )
                    : Icon(
                        Icons.add_circle,
                        color: Colors.green[300],
                        size: 28,
                      ),
            SizedBox(width: 24),
            Text(
              optionName,
              style: Theme.of(context).textTheme.headline5,
            ),
          ],
        ),
      ),
    );
  }
}
