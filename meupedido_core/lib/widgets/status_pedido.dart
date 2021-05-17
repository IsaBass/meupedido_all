import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class StatusPedido extends StatelessWidget {
  final String status;

  const StatusPedido(this.status, {Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return widgetStatus();
  }

  Widget widgetStatus() {
    /////////////////////////////////////////
    return Column(
      children: [
        Container(
          alignment: Alignment.center,
          width: 40,
          height: 40,
          child: Center(child: _iconStatus()),
          decoration: BoxDecoration(
            color: _colorFundoStatus(),
            borderRadius: BorderRadius.circular(40),
          ),
        ),
        ////
        SizedBox(height: 7),
        Text(
          _textStatus().toUpperCase(),
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 11),
        ),

        ///
      ],
    );
    /////////////////////////////////////////
  }

  // Color get corFundo => _colorFundoStatus(status);
  // Icon get icone => _iconStatus(status);
  // String get text => _textStatus(status);

  Color _colorFundoStatus() {
    switch (status) {
      case "0":
        return Colors.blue[900];
        break;
      case "PREP":
        return Colors.teal[300];
        break;
      case "TRANSP":
        return Colors.teal[800];
        break;
      case "OK":
        return Colors.green[700];
        break;
      case "CANCEL":
        return Colors.grey;
        break;
      case "CANCEL.P":
        return Colors.yellow;
        break;
      default:
        return Colors.red;
    }
  }

  Icon _iconStatus() {
    switch (status) {
      case "0":
        return Icon(FontAwesomeIcons.clock, color: Colors.white);
        break;
      case "PREP":
        return Icon(FontAwesomeIcons.industry, color: Colors.white);
        break;
      case "TRANSP":
        return Icon(FontAwesomeIcons.truck,
            color: Colors.yellow[300], size: 20);
        break;
      case "OK":
        return Icon(FontAwesomeIcons.check, color: Colors.white);
        break;
      case "CANCEL":
        return Icon(FontAwesomeIcons.times, color: Colors.white);
        break;
      case "CANCEL.P":
        return Icon(FontAwesomeIcons.times, color: Colors.grey);
        break;
      default:
        return Icon(FontAwesomeIcons.question, color: Colors.white);
    }
  }

  String _textStatus() {
    switch (status) {
      case "0":
        return "Aguardando";
        break;
      case "PREP":
        return "Em preparo";
        break;
      case "TRANSP":
        return 'Despachado';
        break;
      case "OK":
        return "Concluído";
        break;
      case "CANCEL":
        return 'Cancelado';
        break;
      case "CANCEL.P":
        return 'CancelaM.\nPENDENTE';
        break;
      default:
        return "Desconhecido\n$status";
    }
  }
}
