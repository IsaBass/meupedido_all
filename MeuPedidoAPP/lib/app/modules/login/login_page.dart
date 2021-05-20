import 'package:MeuPedido/app/app_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';

import 'package:meupedido_core/meupedido_core.dart';

import 'widgets/wid.login-textfield.dart';
import 'widgets/wid.passwordfield.dart';

class LoginPage extends StatefulWidget {
  final String title;
  const LoginPage({Key key, this.title = "Login"}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final _formKey = GlobalKey<FormState>();
  // final AuthController _authController = Modular.get<AuthController>();
  final AppController _appController = Modular.get();
  final CartController _cartController = Modular.get<CartController>();
  final _contSenha = TextEditingController();
  final _contEmail = TextEditingController();

  final GlobalKey<FormFieldState<String>> _passwordFieldKey =
      GlobalKey<FormFieldState<String>>();

  @override
  Widget build(BuildContext context) {
    // print('vou desenhar scaffold inteiro');
    return Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: SingleChildScrollView(
          padding: EdgeInsets.all(4),
          child: Center(
              child: ConstrainedBox(
            constraints: MyConst.boxConstraints,
            child: Form(
              key: _formKey,
              child: Container(
                padding: EdgeInsets.all(8),
                child: Column(
                  children: <Widget>[
                    LoginTextField(
                      textController: _contEmail,
                      keyboarType: TextInputType.emailAddress,
                      iconData: Icons.email,
                      hintText: 'Seu endereço de e-mail',
                      labelText: 'E-mail*',
                      helperText: 'seu -email cadastrado',
                      validator: (v) {
                        if (!v.contains('@') || !v.contains('.')) {
                          return 'e-mail inválido';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 7),
                    PasswordField(
                      textController: _contSenha,
                      fieldKey: _passwordFieldKey,
                      helperText: 'mínimo 6 caracteres.',
                      labelText: 'Senha *',
                      hintText: 'digite sua senha',
                      validator: (v) {
                        if (!(v.length >= 6)) return 'senha muito curta';
                        return null;
                      },
                      // onFieldSubmitted: (String value) {
                      //   setState(() {
                      //     this._password = value;
                      //   });
                      // },
                    ),
                    SizedBox(height: 7),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      padding: EdgeInsets.all(4),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: Theme.of(context).primaryColor,
                        ),
                        child: Text(
                          'Entrar com e-mail',
                          style: TextStyle(
                              color: Theme.of(context)
                                  .primaryTextTheme
                                  .bodyText1
                                  .color),
                        ),
                        onPressed: () {
                          if (_formKey.currentState.validate()) {
                            _appController.loginEmailSenha(
                                email: _contEmail.text,
                                pass: _contSenha.text,
                                onFail: _onFail,
                                onSucces: _onSucces);
                          }
                        },
                      ),
                    ),
                    SizedBox(height: 2),
                    Observer(
                      builder: (_) => Container(
                        width: MediaQuery.of(context).size.width,
                        padding: EdgeInsets.all(4),
                        child: _appController.isLoading
                            ? Center(child: CircularProgressIndicator())
                            : SignInButton(
                                Buttons.Google,
                                text: 'Login com Google',
                                onPressed: () async {
                                  var resposta =
                                      await _appController.logarGoogle(
                                    onFail: _onFail,
                                    onSucces: _onSucces,
                                  );
                                  if (resposta == 'NOVO') {
                                    Modular.to
                                        .pushNamed('/login/cadastrogoogle');
                                  }
                                },
                              ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(4),
                      height: 25,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          TextButton(
                            onPressed: () {
                              Modular.to.pushNamed('/login/cadastro');
                            },
                            child: Text(
                              'Ainda não sou cadastrado',
                              style:
                                  TextStyle(color: Colors.blue, fontSize: 12),
                            ),
                          ),
                          TextButton(
                            onPressed: () {
                              Modular.to.pushNamed('/login/reset');
                            },
                            child: Text(
                              'Esqueci minha senha',
                              style:
                                  TextStyle(color: Colors.blue, fontSize: 12),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          )),
        ));
  }

  void _onSucces() async {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text("Usuário LOGADO com Sucesso"),
      backgroundColor: Colors.blueAccent,
      duration: Duration(milliseconds: 500),
    ));

    // Future.delayed(Duration(milliseconds: 500)).then((_) {
    //Modular.to.pushNamedAndRemoveUntil('/home', (route) => false);
    await _cartController.carregaCarrinhoUser();
    Modular.to.pop<bool>(true);
    //  });
  }

  void _onFail() {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text("Falha ao LOGAR Usuário"),
      backgroundColor: Colors.redAccent,
      duration: Duration(seconds: 2),
    ));
  }
}
