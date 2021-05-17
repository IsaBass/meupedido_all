import 'package:MeuPedido/app/modules/endereco/endx_controller.dart';
import 'package:flutter/material.dart';

import 'package:flutter_modular/flutter_modular.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:masked_controller/mask.dart';
import 'package:masked_controller/masked_controller.dart';
import 'package:toast/toast.dart';

import 'package:meupedido_core/meupedido_core.dart';
import 'package:meupedido_core/utils/geolocalizacao.dart';

import 'package:MeuPedido/app/app_module.dart';

class EnderecoPage extends StatefulWidget {
  final String title;
  final EnderecoModel endereco;
  const EnderecoPage({Key key, this.title = "Novo Endereço", this.endereco})
      : super(key: key);

  @override
  _EnderecoPageState createState() => _EnderecoPageState();
}

class _EnderecoPageState extends State<EnderecoPage> {
  ///
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _ruaCont = TextEditingController();
  final TextEditingController _numeroCont = TextEditingController();
  final TextEditingController _complemCont = TextEditingController();
  final TextEditingController _bairroCont = TextEditingController();
  final TextEditingController _cidadeCont = TextEditingController();
  final TextEditingController _ufCont = TextEditingController();
  final MaskedController _cepMaskedCont =
      MaskedController(mask: Mask(mask: 'NN.NNN-NNN'));

  final AuthController _authController = Modular.get<AuthController>();
  //
  final EnderecoController controller =
      Get.put<EnderecoController>(EnderecoController());
  //

  EnderecoModel endereco;
  bool modoEdicao = false;

  @override
  void initState() {
    if (widget.endereco != null) {
      endereco = widget.endereco;
      modoEdicao = true;

      _cepMaskedCont.text = endereco.cep;
      _ruaCont.text = endereco.logradouro;
      _numeroCont.text = endereco.numero;
      _complemCont.text = endereco.complemento;
      _bairroCont.text = endereco.bairro;
      _cidadeCont.text = endereco.cidade;
      _ufCont.text = endereco.uf;
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text(modoEdicao ? 'Alterando' : "Novo Endereço"),
      ),
      body: Align(
        alignment: Alignment.topCenter,
        child: ConstrainedBox(
          constraints: MyConst.boxConstraints,
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 8, horizontal: 10),
                child: Column(
                  children: <Widget>[
                    Obx(() => exibeCarregandoLinha(
                        isLoading: controller.isLoading.value)),
                    Row(
                      children: [
                        Expanded(child: _editCEP()),
                        Container(
                          width: 150,
                          child:
                              !modoEdicao ? _btnBuscaCep(context) : Container(),
                        ),
                      ],
                    ),
                    SizedBox(height: 7),
                    _editRua(),
                    SizedBox(height: 7),
                    _editNumero(),
                    SizedBox(height: 7),
                    _editComplemento(),
                    SizedBox(height: 7),
                    _editBairro(),
                    SizedBox(height: 7),
                    Row(
                      children: [
                        Expanded(child: _editCidade()),
                        Container(width: 80, child: _editUF()),
                      ],
                    ),
                    SizedBox(height: 7),
                    SizedBox(height: 7),
                    SizedBox(height: 7),
                    _botaoSalvar(context),
                    SizedBox(height: 7),
                    SizedBox(height: 7),
                    // FlatButton(
                    //   onPressed: () async {
                    //     // var doc = await Firestore.instance.collection('CNPJS')
                    //     // .document('00801558557')
                    //     // .collection('cadastro')
                    //     // .document('00801558557')
                    //     // .get();

                    //     // print(jsonEncode( doc.data));

                    //   },
                    //   child: Text(' json empresa'),
                    // ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _btnBuscaCep(BuildContext context) {
    return FlatButton.icon(
      icon: Icon(FontAwesomeIcons.searchLocation),
      label: Text('completar...'),
      onPressed: () async {
        var resp = await controller.buscaCEP(_cepMaskedCont.unmaskedText);
        if (resp['erro'] != null) {
          Toast.show('CEP não encontrado', context,
              gravity: Toast.TOP, backgroundColor: Colors.red);
          return;
        }
        _ruaCont.text = resp['logradouro'];
        //_complemCont.text = resp['complemento'];
        _bairroCont.text = resp['bairro'];
        _cidadeCont.text = resp['localidade'];
        _ufCont.text = resp['uf'];
      },
    );
  }

  DefaultTextFormField _editCEP() {
    return DefaultTextFormField(
      textController: _cepMaskedCont,
      enabled: !modoEdicao,
      keyboarType: TextInputType.text,
      iconData: FontAwesomeIcons.mailBulk,
      hintText: 'CEP',
      labelText: 'CEP*',
      //helperText: 'seu -email cadastrado',
      validator: (v) {
        if ((v.length != 10)) return 'CEP Inválido';
        return null;
      },
    );
  }

  DefaultTextFormField _editRua() {
    return DefaultTextFormField(
      textController: _ruaCont,
      keyboarType: TextInputType.text,
      iconData: FontAwesomeIcons.road,
      hintText: 'Rua/Avendida',
      labelText: 'Logradouro*',
      //enabled: false,
      //helperText: 'seu -email cadastrado',
    );
  }

  DefaultTextFormField _editNumero() {
    return DefaultTextFormField(
      textController: _numeroCont,
      keyboarType: TextInputType.text,
      iconData: FontAwesomeIcons.mapMarkerAlt,
      hintText: 'Núm',
      labelText: 'Número*',
      // helperText: 'seu -email cadastrado',
      validator: (v) {
        if (v.isEmpty) return 'Número Inválido';
        return null;
      },
    );
  }

  DefaultTextFormField _editComplemento() {
    return DefaultTextFormField(
      textController: _complemCont,
      keyboarType: TextInputType.text,
      iconData: FontAwesomeIcons.mapMarker,
      hintText: 'Complemento',
      labelText: 'Complemento*',
      // helperText: 'casa/apartamento',
    );
  }

  DefaultTextFormField _editBairro() {
    return DefaultTextFormField(
      textController: _bairroCont,
      keyboarType: TextInputType.text,
      //iconData: Icons.email,
      hintText: 'Seu endereço de e-mail',
      labelText: 'Bairro*',
      enabled: false,
      // helperText: 'seu-email cadastrado',
    );
  }

  DefaultTextFormField _editCidade() {
    return DefaultTextFormField(
      textController: _cidadeCont,
      keyboarType: TextInputType.text,
      //iconData: Icons.email,
      hintText: 'Cidade',
      labelText: 'Cidade*',
      enabled: false,
      // helperText: 'seu -email cadastrado',
    );
  }

  DefaultTextFormField _editUF() {
    return DefaultTextFormField(
      textController: _ufCont,
      keyboarType: TextInputType.text,
      iconData: null,
      hintText: 'Estado',
      labelText: 'UF*',
      enabled: false,
      //helperText: 'seu -email cadastrado',
    );
  }

  Container _botaoSalvar(BuildContext context) {
    _acaoSalvarNovo() async {
      double lat;
      double long;

      controller.isLoading.value = true;
      var locs = await getGEO_DoEndereco(
          " ${_ruaCont.text}, ${_numeroCont.text}, ${_bairroCont.text}, ${_cidadeCont.text}, ${_ufCont.text}  ");
      if (locs != null) {
        lat = locs[0];
        long = locs[1];
      }

      var novoId = await controller.gravaEndereco(
        EnderecoModel(
          cep: _cepMaskedCont.unmaskedText,
          logradouro: _ruaCont.text,
          numero: _numeroCont.text,
          complemento: _complemCont.text,
          bairro: _bairroCont.text,
          cidade: _cidadeCont.text,
          uf: _ufCont.text,
          coordLat: lat,
          coordLong: long,
        ),
      );
      Toast.show("Salvo com Sucesso", context);
      Modular.to.pop<String>(novoId);
    }

    _acaoSalvarAlteracao() async {
      controller.isLoading.value = true;
      var locs = await getGEO_DoEndereco(
          " ${_ruaCont.text}, ${_numeroCont.text}, ${_bairroCont.text}, ${_cidadeCont.text}, ${_ufCont.text}  ");
      if (locs != null) {
        endereco.coordLat = locs[0];
        endereco.coordLong = locs[1];
      }

      endereco.numero = _numeroCont.text;
      endereco.complemento = _complemCont.text;

      await controller.alteraEndereco(endereco);

      //Toast.show("Salvo com Sucesso", context);
      //Modular.to.pop();
      //
      Get.back();
      Get.snackbar("Salvo com Sucesso", "OK",
          snackPosition: SnackPosition.BOTTOM);
    }

    return Container(
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.symmetric(vertical: 0, horizontal: 5),
      child: RaisedButton.icon(
        color: Theme.of(context).primaryColor,
        icon: Icon(
          FontAwesomeIcons.save,
          color: Theme.of(context).primaryTextTheme.bodyText1.color,
        ),
        label: _authController.isLoading == true
            ? Center(
                child: CircularProgressIndicator(),
              )
            : Text(
                modoEdicao ? " Salvar" : ' Cadastrar',
                style: TextStyle(
                    fontSize: 18,
                    color: Theme.of(context).primaryTextTheme.bodyText1.color),
              ),
        onPressed: () async {
          if (!_formKey.currentState.validate()) return;

          if (modoEdicao) {
            await _acaoSalvarAlteracao();
          } else {
            await _acaoSalvarNovo();
          }
        },
      ),
    );
  }

  // void _onSucces() {
  //   _scaffoldKey.currentState.showSnackBar(SnackBar(
  //     content: Text("Usuário LOGADO com Sucesso"),
  //     backgroundColor: Colors.blueAccent,
  //     duration: Duration(milliseconds: 500),
  //   ));

  //   Future.delayed(Duration(milliseconds: 500)).then((_) {
  //     Modular.to.pushReplacementNamed('/home');
  //   });
  // }

  // void _onFail() {
  //   _scaffoldKey.currentState.showSnackBar(SnackBar(
  //     content: Text("Falha ao Criar Usuário"),
  //     backgroundColor: Colors.redAccent,
  //     duration: Duration(seconds: 2),
  //   ));
  // }
}
