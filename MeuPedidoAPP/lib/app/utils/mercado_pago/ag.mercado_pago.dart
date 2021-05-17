import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:mercadopago_sdk/mercadopago_sdk.dart';

class AGMercadoPago extends StatefulWidget {
  final List<Map> items;
  final Map payer;

  AGMercadoPago({Key key, this.title = 'OK', this.items, this.payer})
      : super(key: key);

  final String title;

  @override
  _AGMercadoPagoState createState() => _AGMercadoPagoState();
}

class _AGMercadoPagoState extends State<AGMercadoPago> {
  String _publickey = "TEST-124f0130-3003-4cd5-9c6d-a3c3313eb4cb";
  //Access token:TEST-5617891484026182-050813-59e65d753c93194e992d2915fcd91bde-267638834
  String _clientId = "5617891484026182";
  String _clientSecret = "dtLwuCyi9oJ6NmgzsImriPttUrTy478P";

  static const channelMP =
      const MethodChannel("agMeuPedidoOnline.com/mercadoPago");

  String idPreference = '';

  @override
  void initState() {
    super.initState();
    executeMercadoPagoCheckout();
  }

  void mercadoPagoOK(List<String> listResposta) {
    print('RESPOSTA DO PAGAMENTO >>>>>');
    for (var item in listResposta) {
      print(item);
    }
    var mapResposta = {
      "tipoResposta": "PagamentoOK",
      "idPreference": idPreference,
      "idPagamento": listResposta[1],
      "status": listResposta[2],
      "statusDetails": listResposta[3],
      "creditoDebito": listResposta[4],
      "bandeira": listResposta[5],
      "operacao": listResposta[6]
    };
    Modular.to.pop<Map>(mapResposta);

    //[MPagoOK, 25494039, approved, accredited, credit_card, master, regular_payment,
    /*
       arraList.add("MPagoOK");
            arraList.add(paymentId.toString())
            arraList.add(paymentStatus.toString())
            arraList.add(paymentStatusDetails)
            arraList.add(payment.paymentTypeId)
            arraList.add(payment.paymentMethodId)
            arraList.add(payment.operationType)
      */
  }

  void erroIniciarMP() => Modular.to.pop<Map>({"tipoResposta": "erroIniciar"});
  void pagamentoFalhou() =>
      Modular.to.pop<Map>({"tipoResposta": "semPagamento"});

// 25435634
//approved
//rejected

  MP criarMP() {
    //
    return MP(_clientId, _clientSecret);
    //
  }

  void executeMercadoPagoCheckout() async {
    ///

    var mp = criarMP();
    if (mp == null) {
      return erroIniciarMP();
    }

//  result['response']['status'] = result['status'] = 201 = ok
//  result['response']['status'] = result['status'] = 400 = problema
//  result['response']['message']
//  result['response']['error']



    var result = await mp.createPreference(_criarPreference());
    if (result['response']['id'] == null) {
      print(' problema ao gerar o pedido inicial no Preference ');
      return erroIniciarMP();
    }
    var idPreference = result['response']['id'];

    try {
      // const channelMercadoPago =
      //     const MethodChannel("agMeuPedidoOnline.com/mercadoPago");
      final response = await channelMP.invokeListMethod<String>(
          'mercadoPagoPague', <String, dynamic>{
        "publicKey": _publickey,
        "preferenceId": idPreference
      });

      if (response[0] == 'MPagoOK') {
        return mercadoPagoOK(response);
      }

      return pagamentoFalhou();
    } on PlatformException catch (e) {
      print(e.message);
      return erroIniciarMP();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(title: Text(widget.title)),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            CircularProgressIndicator(),
            SizedBox(height: 20),
            Text('Requisitando Mercado Pago...'),
            Text('Aguarde...'),
            SizedBox(height: 20),
            Icon(FontAwesomeIcons.creditCard, size: 80, color: Theme.of(context).accentColor  ),
            // FlatButton(
            //     onPressed: executeMercadoPagoCheckout,
            //     child: Text('Teste Venda')),
          ],
        ),
      ),
    );
  }

  Map _criarPreference() {
    var preference = {
      // "items" : widget.items,
      "items": [
        {
          "title": "Produto Teste",
          "quantity": 3,
          "currency_id": "BRL",
          "unit_price": 10.48
        }
      ],
      // "payer": widget.payer,
      "payer": {"name": "Kekinha", "email": "kekinhagalindo@gmail.com"},
      "payment_methods": {
        "excluded_payment_types": [
          {"id": "ticket"}

          /// para nao permitir boletos
        ]
      },
      "binary_mode": true
    };
    return preference;
  }

  void printToken() async {
    // String token = await mp.getAccessToken();
    // print('Mercadopago token $token');
  }
}

/*
public static class StatusCodes {
        public static final String STATUS_APPROVED = "approved";
        public static final String STATUS_IN_PROCESS = "in_process";
        public static final String STATUS_REJECTED = "rejected";
        public static final String STATUS_PENDING = "pending";
    }


public Boolean isCardPaymentType(String paymentTypeId) {
        return paymentTypeId.equals(PaymentTypes.CREDIT_CARD)
            || paymentTypeId.equals(PaymentTypes.DEBIT_CARD)
            || paymentTypeId.equals(PaymentTypes.PREPAID_CARD);
    }
*/
