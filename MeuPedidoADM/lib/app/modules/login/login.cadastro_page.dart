import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:meupedido_core/meupedido_core.dart';

import '../../app_module.dart';
import 'widgets/wid.login-textfield.dart';
import 'widgets/wid.passwordfield.dart';

class LoginCadastroPage extends StatefulWidget {
  final String title;
  const LoginCadastroPage({Key key, this.title = "Novo Usuário"})
      : super(key: key);

  @override
  _LoginCadastroPageState createState() => _LoginCadastroPageState();
}

class _LoginCadastroPageState extends State<LoginCadastroPage> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _senhaCont = TextEditingController();
  final TextEditingController _nomeCont = TextEditingController();
  final TextEditingController _emailCont = TextEditingController();
  final AuthController _authController = AppModule.to.get<AuthController>();
  // final CartController _cartController = AppModule.to.get<CartController>();

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
                    LoginTextField(
                      textController: _nomeCont,
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
                    LoginTextField(
                      textController: _emailCont,
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
                      textController: _senhaCont,
                      //fieldKey: _passwordFieldKey,
                      helperText: 'mínimo 6 caracteres.',
                      labelText: 'Senha *',
                      hintText: 'cadastre uma senha',
                      validator: (v) {
                        if (!(v.length >= 6)) return 'senha muito curta';
                        return null;
                      },
                    ),
                    SizedBox(height: 7),
                    PasswordField(
                      labelText: 'repita a senha *',
                      hintText: 'digite a senha novamente',
                      validator: (v) {
                        if (!(v.length >= 6)) return 'senha muito curta';
                        if (v != _senhaCont.text) {
                          return 'não confere com a senha digitada acima';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 7),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      padding: EdgeInsets.all(4),
                      child: RaisedButton(
                        color: Theme.of(context).primaryColor,
                        child: _authController.isLoading == true
                            ? Center(
                                child: CircularProgressIndicator(),
                              )
                            : Text(
                                'Cadastrar',
                                style: TextStyle(
                                    color: Theme.of(context)
                                        .primaryTextTheme
                                        .bodyText1
                                        .color),
                              ),
                        onPressed: () {
                          if (_formKey.currentState.validate()) {
                            _authController.userAtual.nome = _nomeCont.text;
                            _authController.userAtual.email = _emailCont.text;
                            _authController.createLoginEmailSenha(
                                pass: _senhaCont.text,
                                onFail: _onFail,
                                onSucces: _onSucces);
                          }
                        },
                      ),
                    ),
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
    _scaffoldKey.currentState.showSnackBar(SnackBar(
      content: Text("Usuário LOGADO com Sucesso"),
      backgroundColor: Colors.blueAccent,
      duration: Duration(milliseconds: 500),
    ));

    Future.delayed(Duration(milliseconds: 500)).then((_) async {
       Modular.to.pushNamedAndRemoveUntil('/home', (route) => false);
      // await _cartController.carregaCarrinhoUser();
      // Modular.to.pop<bool>(true);
    });
  }

  void _onFail() {
    _scaffoldKey.currentState.showSnackBar(SnackBar(
      content: Text("Falha ao Criar Usuário"),
      backgroundColor: Colors.redAccent,
      duration: Duration(seconds: 2),
    ));
  }
}
