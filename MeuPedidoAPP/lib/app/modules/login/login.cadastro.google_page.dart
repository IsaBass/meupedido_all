import 'package:MeuPedido/app/app_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';

import 'package:meupedido_core/meupedido_core.dart';

import 'widgets/wid.login-textfield.dart';

class LoginCadastroGooglePage extends StatefulWidget {
  final String title;
  const LoginCadastroGooglePage({Key key, this.title = "Novo Usuário Google"})
      : super(key: key);

  @override
  _LoginCadastroPageState createState() => _LoginCadastroPageState();
}

class _LoginCadastroPageState extends State<LoginCadastroGooglePage> {
  //
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final _formKey = GlobalKey<FormState>();
  //
  final TextEditingController _nomeContr = TextEditingController();
  //
  final AppController _appController = Modular.get();
  //

  @override
  void initState() {
    super.initState();
    _nomeContr.text = _appController.userAtual.nome;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Align(
        alignment: Alignment.topCenter,
        child: ConstrainedBox(
          constraints: MyConst.boxConstraints,
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Container(
                padding: EdgeInsets.all(8),
                child: Column(
                  children: <Widget>[
                    _appController.userAtual.urlImg.isEmpty
                        ? Container(height: 0)
                        : Container(
                            height: 50,
                            child: Image.network(
                              _appController.userAtual.urlImg,
                              width: 150,
                              height: 150,
                            ),
                          ),
                    Container(
                      alignment: Alignment.center,
                      height: 50,
                      child: Text(
                        'Olá, ${_appController.userAtual.nome}\n'
                        'Este é seu primeiro acesso\nPor favor confirme seu nome para identificação',
                        textAlign: TextAlign.center,
                      ),
                    ),
                    LoginTextField(
                      textController: _nomeContr,
                      keyboarType: TextInputType.text,
                      iconData: Icons.person,
                      hintText: 'Seu nome',
                      labelText: 'Nome*',
                      //helperText: 'seu -email cadastrado',
                      validator: (v) {
                        if (!(v.length >= 6)) return 'nome muito curto';
                        return null;
                      },
                    ),
                    SizedBox(height: 7),
                    Observer(
                      builder: (_) => Container(
                        width: MediaQuery.of(context).size.width,
                        padding: EdgeInsets.all(4),
                        child: _appController.isLoading
                            ? Center(child: CircularProgressIndicator())
                            : SignInButton(
                                Buttons.Google,
                                text: 'Cadastrar com Google',
                                onPressed: () async {
                                  if (_formKey.currentState.validate()) {
                                    _appController.userAtual.nome =
                                        _nomeContr.text;
                                    await _appController.saveUserData();
                                    await _appController.loadCurrentUser();
                                    _onSucces();
                                  }
                                },
                              ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _onSucces() {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text("Usuário LOGADO com Sucesso"),
      backgroundColor: Colors.blueAccent,
      duration: Duration(milliseconds: 500),
    ));

    Future.delayed(Duration(milliseconds: 500)).then((_) {
      Modular.to.pop<bool>(true);
    });
  }
}
