import 'package:flutter/material.dart';

class BtnsCarrinho extends StatelessWidget {
  final IconData icone;
  final String buttomLabel;
  final Function onPressed;

  const BtnsCarrinho({Key key, this.icone, this.buttomLabel, this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8),
      width: MediaQuery.of(context).size.width,
      height: 60,
      child: RaisedButton.icon(
        icon: Icon(
          icone,
          color: Theme.of(context).primaryTextTheme.bodyText1.color,
        ),
        label: Padding(
          padding: const EdgeInsets.all(5.0),
          child: Text(
            buttomLabel,
            style: TextStyle(
              color: Theme.of(context).primaryTextTheme.bodyText1.color,
            ),
          ),
        ),
        color: Theme.of(context).primaryColor,
        onPressed: onPressed,
      ),
    );
  }
}
