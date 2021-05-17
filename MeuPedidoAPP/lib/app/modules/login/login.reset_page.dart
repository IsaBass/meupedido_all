import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'package:meupedido_core/meupedido_core.dart';
import 'package:MeuPedido/app/app_module.dart';

import 'widgets/wid.login-textfield.dart';

class LoginResetPage extends StatefulWidget {
  final String title;
  const LoginResetPage({Key key, this.title = "Login Reset"}) : super(key: key);

  @override
  _LoginResetPageState createState() => _LoginResetPageState();
}

class _LoginResetPageState extends State<LoginResetPage> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final _formKey = GlobalKey<FormState>();
  final AuthController _authController = AppModule.to.get<AuthController>();
  final _contEmail = TextEditingController();

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
                      textController: _contEmail,
                      keyboarType: TextInputType.emailAddress,
                      iconData: Icons.email,
                      hintText: 'Seu endereço de e-mail',
                      labelText: 'E-mail*',
                      helperText: 'seu -email cadastrado',
                      validator: (v) {
                        if (!v.contains('@') || !v.contains('.'))
                          {return 'e-mail inválido';}
                        return null;
                      },
                    ),
                    SizedBox(height: 7),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      padding: EdgeInsets.all(4),
                      child: RaisedButton(
                        color: Theme.of(context).primaryColor,
                        child: Text('Redefinir Senha',
                            style: TextStyle(color: Theme.of(context).primaryTextTheme.bodyText1.color)),
                        onPressed: () {
                          if (_formKey.currentState.validate()) {
                            _authController.recoveryPass(
                                email: _contEmail.text,
                                onFail: _onFail,
                                onSucces: _onSucces);
                          }
                        },
                      ),
                    ),
                    SizedBox(height: 2),
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
      content: Text("O e-mail para redefinir senha foi enviado."),
      backgroundColor: Colors.blueAccent,
      duration: Duration(milliseconds: 1000),
    ));

    Future.delayed(Duration(milliseconds: 1000)).then((_) {
      Modular.to.pushNamedAndRemoveUntil('/login', (route) => false);
    });
  }

  void _onFail() {
    _scaffoldKey.currentState.showSnackBar(SnackBar(
      content: Text("Falha ao localizar Usuário"),
      backgroundColor: Colors.redAccent,
      duration: Duration(seconds: 2),
    ));
  }
}
