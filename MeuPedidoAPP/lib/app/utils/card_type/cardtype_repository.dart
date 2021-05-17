import 'package:MeuPedido/app/utils/card_type/cadrtype_model.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:dio/dio.dart';

class CardTypeRepository extends Disposable {
  Future<CardType> getCardType(String numberCard) async {
    try {
      Response response = await Dio().post(
          "https://us-central1-meupedido-237bd.cloudfunctions.net/api/utils/cardtype",
          data: {"numcard": numberCard, "simpleKey": "minhachavesimples"});
      print(response);
      if (response.statusCode != 200) return null;

      return CardType.fromJson(response.data);
    } catch (e) {
      print(e);
      return null;
    }
  }

  //dispose will be called automatically
  @override
  void dispose() {}
}
