import 'package:flutter/material.dart';

class IconBadge extends StatefulWidget {
  final IconData icon;
  final double size;
  final int numero;

  IconBadge(
      {Key key,
      @required this.icon,
      @required this.size,
      @required this.numero})
      : super(key: key);

  @override
  _IconBadgeState createState() => _IconBadgeState();
}

class _IconBadgeState extends State<IconBadge> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Icon(
          widget.icon,
          size: widget.size,
          //color: Theme.of(context).accentColor,
        ),
        Positioned(
          right: 0,
          top: -1,
          child: widget.numero == 0
              ? Container()
              : Container(
                  padding: EdgeInsets.all(1),
                  decoration: BoxDecoration(
                    color: Colors.green,
                    border: Border.all(width: 0.3),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  constraints: BoxConstraints(minWidth: 13, minHeight: 13),
                  child: Padding(
                    padding: EdgeInsets.only(top: 1),
                    child: Text(
                      '${widget.numero}',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.w500),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
        ),
      ],
    );
  }
}
