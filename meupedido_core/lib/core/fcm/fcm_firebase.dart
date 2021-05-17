import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

import 'package:flutter_modular/flutter_modular.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:dio/dio.dart';

class FCMFirebase extends Disposable {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();

  FCMFirebase() {
    //inicializeFCM();
    //getToken().then((value) => print('token = $value'));
  }

  Future<String> getToken() async => await _firebaseMessaging.getToken();

  void inicializeFCM(BuildContext context) {
    _firebaseMessaging.configure(
      onMessage: (Map<String, dynamic> message) async {
        print("onMessage: $message");
        _showItemDialog(message, context);
      },
      onLaunch: (Map<String, dynamic> message) async {
        print("onLaunch: $message");
        // _navigateToItemDetail(message);
        //  _showItemDialog(message, context);
      },
      onResume: (Map<String, dynamic> message) async {
        print("onResume: $message");
        // _navigateToItemDetail(message);
        //  _showItemDialog(message, context);
      },
    );
    _firebaseMessaging.requestNotificationPermissions(
      const IosNotificationSettings(
          sound: true, badge: true, alert: true, provisional: true),
    );
    _firebaseMessaging.onIosSettingsRegistered
        .listen((IosNotificationSettings settings) {
      print("Settings registered: $settings");
    });
  }

  void _showItemDialog(
      Map<String, dynamic> message, BuildContext context) async {
    Alert(
      context: context,
      type: AlertType.info,
      title: message['notification']['title'],
      desc: message['notification']['body'],
      buttons: [
        DialogButton(
          width: 120,
          child: Text(
            'OK',
            style: TextStyle(
              color: Theme.of(context).accentTextTheme.bodyText2.color,
              fontSize: 17,
            ),
          ),
          //color: Theme.of(context).primaryColor,
          onPressed: () => Navigator.of(context).pop(),
        ),
      ],
    ).show();
  }

  Future<void> fcmAdministradores(
      {String cnpj, String titulo, String body}) async {
    //

    try {
      //Response response =
      await Dio().post(
        "https://us-central1-meupedido-237bd.cloudfunctions.net/api/fcm/pushadmins",
        data: {
          "titulo": titulo,
          "corpo": body,
          "simpleKey": "minhachavesimples",
          "cnpj": cnpj
          // "appname": "br.com.agsystem.meupedidoADM"
        },
      );
    } catch (e) {}
    //
  }

  //dispose will be called automatically
  @override
  void dispose() {}
}

/*
PARA ENVIAR POR DIO

POST EM https://fcm.googleapis.com/fcm/send

-- NO HEADER:
coloca essa chave
Authorization
com esse valor 
key=<CHAVE>
key=AAAA-JG8VzA:APA91bF7iFgRzXQ9moFviz1syAVoIHmKMFC5QQuBF2dSlPAZxsvcfqUQ6s4_PX4pN9XeEV93-YR1lu5ZDfbFipOZlMS5WUqxVZgNaJIlLSneqmpMyUy_-kQUFY4ih8YnplgK6BCLv9Hh

BODY ENVIA ESSE JSON:
{
     "notification": {
         "body": "Corpo da notificação",
         "title": "Aqui o titulo"
     },
     "priority": "high",
     "data": {
         "click_action": "FLUTTER_NOTIFICATION_CLICK"
     },
     --- AQUI O TOKEN PRA O CELULAR QUE QUER ENVIAR
     "to": "cEWaGFxDMic:APA91bFD5TVs_MI4WkaXDBmpcLFeGJsrvK5pucgo1IJZDjaYMKf7SQk6r3oeyO0VZiBvAxHY9EE_rl9efGyIyKMRkPDavi-lRb8fvdGQFj4CVXian7u_ynRmOUvmoQYT697g4j7xZEFc"
 }



*/
