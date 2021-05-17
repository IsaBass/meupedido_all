import 'package:MeuPedido/app/app_controller.dart';
import 'package:MeuPedido/app/modules/login/widgets/wid.passwordfield.dart';
import 'package:MeuPedido/app/utils/card_type/cadrtype_model.dart';
import 'package:MeuPedido/app/utils/card_type/cardtype_repository.dart';
import 'package:cielo_ecommerce/cielo_ecommerce.dart';

import 'package:flutter/material.dart';

import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:masked_controller/mask.dart';
import 'package:masked_controller/masked_controller.dart';
import 'package:meupedido_core/meupedido_core.dart';
import 'package:meupedido_core/utils/janela.pergunta.dart';

import '../carrinho_controller.dart';

class PainelCartaoCielo extends StatefulWidget {
  const PainelCartaoCielo({Key key}) : super(key: key);

  @override
  _PainelCartaoCreditoState createState() => _PainelCartaoCreditoState();
}

class _PainelCartaoCreditoState extends State<PainelCartaoCielo> {
  final _formKey = GlobalKey<FormState>();
  final CarrinhoController _carrinhoController =
      Modular.get<CarrinhoController>();
  final CartController _cartController = Modular.get<CartController>();
  final AppController _appController = Modular.get<AppController>();
  final TextEditingController _nomeCliCont = TextEditingController();
  final MaskedController _numCartaoMaskedCont =
      MaskedController(mask: Mask(mask: 'NNNN.NNNN.NNNN.NNNN'));
  final MaskedController _codSecretoCont =
      MaskedController(mask: Mask(mask: 'NNNNN'));
  final MaskedController _mesVencCont =
      MaskedController(mask: Mask(mask: 'NNN'));
  final MaskedController _anoVencCont =
      MaskedController(mask: Mask(mask: 'NNNNN'));

  bool verificouCartao = false;
  CardType cartaoType;
  String codeName = 'Código';
  bool isVerificando = false;
  //
  CieloEcommerce cielo;
  CnpjConfigsModel configs;

  @override
  void initState() {
    super.initState();

    inicieCielo();
  }

  void inicieCielo() async {
    ///
    configs = await _appController.getCnpjConfigs();
    // var mechaid = configs.cieloMerchanId;
    // var merchakey = configs.cieloMerchanKey;

    var mechaid = "1f471d59-7c77-4531-afe9-47a5e41620e4";
    var merchakey = "ICFGKQEZSABSKBTNEORUNYQFOFWBZPHAZSOYTRQU";

    //inicia objeto da api
    cielo = CieloEcommerce(
        environment: Environment.sandbox, // ambiente de desenvolvimento
        merchant: Merchant(
          merchantId: mechaid,
          merchantKey: merchakey,
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Observer(builder: (_) {
      if (!(_carrinhoController.formaPagamento == 'ONLINE' &&
          _carrinhoController.tipoPagamento == 'CTCRED')) return Container();
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 8),
        child: Card(
          elevation: 4,
          child: Form(
            key: _formKey,
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 8, horizontal: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  exibeCarregandoLinha(
                      isLoading: _carrinhoController.isLoading),
                  Text('Dados do Cartão de Crédito:'),
                  SizedBox(height: 10),
                  _editNumCartao(),
                  SizedBox(height: 7),
                  _editNomeCli(),
                  SizedBox(height: 7),
                  _editCodSecreto(),
                  SizedBox(height: 7),
                  _vencimento(),
                  SizedBox(height: 20),
                  _botaoPagar(context),
                ],
              ),
            ),
          ),
        ),
      );
    });
  }

  Widget _editNumCartao() {
    /// icone do cartao
    IconData iconCard() {
      switch (cartaoType?.type?.toLowerCase() ?? '') {
        case 'visa':
          return FontAwesomeIcons.ccVisa;
          break;
        case 'mastercard':
          return FontAwesomeIcons.ccMastercard;
          break;
        case 'american-express':
          return FontAwesomeIcons.ccAmex;
          break;
        case 'diners-club':
          return FontAwesomeIcons.ccDinersClub;
          break;
        case 'discover':
          return FontAwesomeIcons.ccDiscover;
          break;
        case 'jcb':
          return FontAwesomeIcons.ccJcb;
          break;
        case 'unionpay':
          return FontAwesomeIcons.creditCard;
          break;
        case 'maestro':
          return FontAwesomeIcons.creditCard;
          break;
        case 'mir':
          return FontAwesomeIcons.creditCard;
          break;
        case 'elo':
          return FontAwesomeIcons.creditCard;
          break;
        case 'hiper':
          return FontAwesomeIcons.creditCard;
          break;
        case 'hipercard':
          return FontAwesomeIcons.creditCard;
          break;
        default:
          return FontAwesomeIcons.creditCard;
      }
    }

    return isVerificando
        ? Container(
            height: 50,
            child: Center(child: CircularProgressIndicator()),
          )
        : DefaultTextFormField(
            textController: _numCartaoMaskedCont,
            // enabled: !modoEdicao,
            keyboarType: TextInputType.number,
            iconData: iconCard(),
            hintText: 'Número do Cartão',
            labelText: 'Número do Cartão*',
            //helperText: 'seu -email cadastrado',
            onchanged: (v) async {
              if ((_numCartaoMaskedCont.unmaskedText.length < 6)) {
                verificouCartao = false;
              } else {
                /////
                await verifiqueCartao(); // <<<<<<
                ///
                if (cartaoType == null) {
                  return await showPergunta(
                    title: 'Cartão Inválido',
                    desc:
                        'O cartão foi considerado inválido pelo nosso sistema.',
                    botaoNao: 'OK',
                    botaoSim: '',
                    context: context,
                  );
                }
              }
            },
            validator: (v) {
              if ((cartaoType == null)) {
                return 'Cartão Inválido';
              }
              return null;
            },
          );
  }

  Widget _editCodSecreto() {
    return Container(
      width: 270,
      child: PasswordField(
        textController: _codSecretoCont,
        keyboarType: TextInputType.number,
        hintText: 'Secreto',
        labelText: codeName,
        //helperText: '000',
        validator: (v) {
          if ((v.length != 3)) return 'Inválido';
          return null;
        },
      ),
    );
  }

  DefaultTextFormField _editNomeCli() {
    return DefaultTextFormField(
      textController: _nomeCliCont,
      textCapitalization: TextCapitalization.characters,
      // enabled: !modoEdicao,
      keyboarType: TextInputType.text,
      iconData: FontAwesomeIcons.userTag,
      hintText: 'Nome impresso no cartão',
      labelText: 'Nome do Cliente*',
      //helperText: 'conforme impresso no cartão',
      validator: (v) {
        if ((v.length < 10)) return 'Inválido';
        return null;
      },
    );
  }

  Widget _vencimento() {
    return Row(
      children: [
        Icon(FontAwesomeIcons.calendarCheck, color: Colors.grey),
        SizedBox(width: 20),
        Text('Vencimento:'),
        Container(
          width: 70,
          child: DefaultTextFormField(
            textController: _mesVencCont,

            keyboarType: TextInputType.number,
            //iconData: FontAwesomeIcons.mailBulk,
            hintText: 'MM',
            labelText: 'Mês*',
            // helperText: 'conforme impresso no cartão',
            validator: (v) {
              if ((v.length != 2)) return 'Inválido';
              var mes = int.parse(v);
              if (!(mes >= 1 && mes <= 12)) return 'Inválido';
              return null;
            },
          ),
        ),
        Text('/', style: TextStyle(fontSize: 20)),
        Container(
          width: 70,
          child: DefaultTextFormField(
            textController: _anoVencCont,
            keyboarType: TextInputType.number,
            //iconData: FontAwesomeIcons.mailBulk,
            hintText: 'AAAA',
            labelText: 'Ano*',
            // helperText: 'conforme impresso no cartão',
            validator: (v) {
              if ((v.length != 4)) return 'Inválido';
              return null;
            },
          ),
        ),
      ],
    );
  }

  Container _botaoPagar(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.symmetric(vertical: 0, horizontal: 5),
      child: RaisedButton.icon(
        color: Theme.of(context).primaryColor,
        icon: Icon(
          FontAwesomeIcons.creditCard,
          color: Theme.of(context).primaryTextTheme.bodyText1.color,
        ),
        label: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            'Pagar com Cartão\ne finalizar Pedido',
            style: TextStyle(
              color: Theme.of(context).primaryTextTheme.bodyText1.color,
            ),
          ),
        ),
        onPressed: () async {
          if (!_formKey.currentState.validate()) return;

          var idPedido = await _carrinhoController.gravarPedidoTemporario();
          var pedido =
              _carrinhoController.criarPedido(pedido: Pedido(docId: idPedido));

          var retorno = {};
          try {
            //
            retorno = await chamaCielo(pedido);
          } catch (e) {
            await showPergunta(
              title: 'Não deu!',
              desc:
                  'Problema ao processar o pagamento. Tente corrigir alguma informação e tente novamente.',
              botaoNao: 'OK',
              botaoSim: '',
              context: context,
            );
            //
            _carrinhoController.excluirPedidoTemporario(idPedido);
            return;
          }

          if (retorno["resposta"] != 'OK') {
            await showPergunta(
              title: 'Não deu!',
              desc:
                  'Infelizmente o pagamento não foi aprovado. Corrija alguma informação e tente novamente.\n'
                  'Mensagem: ${retorno["returnCode"]} ${retorno["returnMessage"]}',
              botaoNao: 'OK',
              botaoSim: '',
              context: context,
            );
            //
            _carrinhoController.excluirPedidoTemporario(idPedido);
            return;
          }

          // return;
          // aqui manda informacoes do cartao, incluindo o idPedido

          pedido.pagamentos[0].codPag = 'Cielo';
          pedido.pagamentos[0].mecanismoCartao = 'Cielo';
          pedido.pagamentos[0].descricao = 'Cartão Crédito';
          pedido.pagamentos[0].tipo = 'CTCRED';
          //
          pedido.pagamentos[0].idVendaCartao = retorno["paymentId"];
          pedido.pagamentos[0].codAutorizacao = retorno["authorizationCode"];
          pedido.pagamentos[0].numNSU = retorno["proofOfSale"];
          pedido.pagamentos[0].bandeira =
              retorno["brand"].toString().toUpperCase();
          pedido.pagamentos[0].parcelas = retorno["installments"];
          pedido.pagamentos[0].finalCartao = retorno["cardNumber"];
          //
          var nPed = await _carrinhoController.gravarPedido(pedido);
          if (nPed == null) {
            // não conseguiu gravar pedido
            ///
            cielo.enableVoid(retorno["paymentId"]); // cancela na cielo
            //
            await showPergunta(
              title: 'Pedido Não Concluído',
              desc:
                  'Não foi possível gerar o seu pedido.\n Por favor tente novamente.',
              botaoNao: 'OK',
              botaoSim: '',
              context: context,
            );

            ///
            _carrinhoController.excluirPedidoTemporario(idPedido);
            return;
          }

          //
          cielo.enableCapture(retorno["paymentId"]); // confirma captura cielo
          // DONE: CHAMAR TELA DE FINALIZAÇÃO DA VENDA / CONFIRMADO
          await showPergunta(
            title: 'Pedido Confirmado',
            desc: 'Seu Pedido ${pedido.codpedido} foi confirmado com Sucesso.' +
                '\nAcompanhe-o pelo menu de pedidos',
            botaoNao: 'OK',
            botaoSim: '',
            context: context,
          );

          Modular.to.popUntil(ModalRoute.withName('/home'));
        },
      ),
    );
  }

  Future<Map> chamaCielo(Pedido pedido) async {
    //Objeto de venda
    Sale sale = Sale(
        merchantOrderId: pedido.docId, // id único de sua venda
        customer: Customer(
          //objeto de dados do usuário
          // name: "Comprador crédito simples"
          name: pedido.usuario.nome,
          email: pedido.usuario.email,
          // mobile: '55' + pedido.usuario.telefone,
        ),
        payment: Payment(
            // objeto para de pagamento
            type: TypePayment.creditCard, //tipo de pagamento
            // valor da compra em centavos
            amount: (_cartController.cartAtual.valorTotal * 100).toInt(),
            installments: 1, // número de parcelas
            //DONE  PEGAR DA BASE  //descrição que aparecerá no extrato do usuário. Apenas 15 caracteres
            softDescriptor: configs.nomeFaturaCartao.length > 15
                ? configs.nomeFaturaCartao.substring(0, 14)
                : configs.nomeFaturaCartao,
            creditCard: CreditCard(
              //objeto de Cartão de crédito
              cardNumber: _numCartaoMaskedCont.unmaskedText, //número do cartão
              holder: _nomeCliCont.text, //nome do usuário impresso no cartão
              expirationDate: "${_mesVencCont.text}/${_anoVencCont.text}",
              securityCode: _codSecretoCont.unmaskedText, // código de segurança
              brand: cartaoType.niceType, //"Visa", // bandeira
            )));

    try {
      ///
      var response = await cielo.createSale(sale);

      ///
      print('paymentId: ' + response.payment.paymentId);
      print('authenticate: ' + response.payment.authenticate.toString());
      print('authorizationCode: ' +
          response.payment.authorizationCode.toString());
      // print('assignor: ' + (response.payment.assignor ?? ''));
      // print('instructions: ' + (response.payment.instructions ?? ''));
      print('cod de retorno : ' + (response.payment.returnCode ?? ''));
      print('returnMessage: ' + (response.payment.returnMessage ?? ''));
      print('proofOfSale: ' + (response.payment.proofOfSale ?? ''));
      ////
      var retorno = {
        'paymentId': response.payment.paymentId,
        'authenticate': response.payment.authenticate.toString(),
        'authorizationCode': response.payment.authorizationCode.toString(),
        'returnCode': (response.payment.returnCode ?? ''),
        'returnMessage': (response.payment.returnMessage ?? ''),
        'proofOfSale': (response.payment.proofOfSale ?? ''),
        'brand': (response.payment.creditCard.brand ?? ''),
        'cardNumber': (response.payment.creditCard.cardNumber ?? ''),
        'installments': (response.payment.installments ?? 1)
      };
      if (response.payment.returnCode == "00" // << esse é produção
              ||
              response.payment.returnCode == "4" // << esse é teste
              ||
              response.payment.returnCode == "6" // << esse é teste
          ) {
        retorno["resposta"] = 'OK';
      } else {
        retorno["resposta"] = 'NAO';
      }
      //
      return retorno;

      ///

    } catch (e) {
      print('erro message: ' + e.errors[0].message);
      print('erro code: ' + e.errors[0].code.toString());
      return {"resposta": "erro", "returnMessage": e.errors[0].message};
    }
  }

  Future verifiqueCartao() async {
    if (verificouCartao) return;

    setState(() => isVerificando = true);

    ///
    cartaoType = await CardTypeRepository()
        .getCardType(_numCartaoMaskedCont.unmaskedText);

    verificouCartao = !(cartaoType == null);

    if (verificouCartao) {
      codeName = cartaoType.codeName;
      switch (cartaoType.codeSize) {
        case 2:
          _codSecretoCont.mask = Mask(mask: 'NNN');
          break;
        case 3:
          _codSecretoCont.mask = Mask(mask: 'NNNN');
          break;
        case 4:
          _codSecretoCont.mask = Mask(mask: 'NNNNN');
          break;
        case 5:
          _codSecretoCont.mask = Mask(mask: 'NNNNNN');
          break;
        default:
          _codSecretoCont.mask = Mask(mask: 'NNNN');
      }

      int tamanho = 0;
      for (var item in cartaoType.lengths) {
        if (item > tamanho) tamanho = item;
      }

      String mascara = '';
      for (var i = 0; i < tamanho; i++) {
        if (cartaoType.gaps.contains(i)) {
          mascara = mascara + '.';
        }
        mascara = mascara + 'N';
      }
      _numCartaoMaskedCont.mask = Mask(mask: mascara);
    }

    setState(() => isVerificando = false);
  }
}

// ss.initech@gmail.com
// mechaid  1f471d59-7c77-4531-afe9-47a5e41620e4
// merchakey ICFGKQEZSABSKBTNEORUNYQFOFWBZPHAZSOYTRQU

// import 'package:flutter_cielo/flutter_cielo.dart';

// ...
// //inicia objeto da api
// final CieloEcommerce cielo = CieloEcommerce(
//       environment: Environment.SANDBOX, // ambiente de desenvolvimento
//       merchant: Merchant(
//         merchantId: "SEU_MERCHANT_ID",
//         merchantKey: "SEU_MERCHANT_KEY",
//       ));

// ...
//     //Objeto de venda
//     Sale sale = Sale(
//       merchantOrderId: "123", // id único de sua venda
//       customer: Customer( //objeto de dados do usuário
//         name: "Comprador crédito simples"
//       ),
//       payment: Payment(    // objeto para de pagamento
//         type: TypePayment.creditCard, //tipo de pagamento
//         amount: 7777, // valor da compra em centavos
//         installments: 1, // número de parcelas
//         softDescriptor: "Cielo", //descrição que aparecerá no extrato do usuário. Apenas 15 caracteres
//         creditCard: CreditCard( //objeto de Cartão de crédito
//           cardNumber: "1234123412341231", //número do cartão
//           holder: "Teste Holder", //nome do usuário impresso no cartão
//           expirationDate: "12/2030", // data de expiração
//           securityCode: "123", // código de segurança
//           brand: "Visa", // bandeira
//         )
//       )
//     );

//   try{
//     var response = await cielo.createSale(sale);
//     print(response.payment.paymentId);
//     } catch(e){
//       print(e);
//     }
