import 'package:MeuPedido/app/app_controller.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:flutter_modular/flutter_modular.dart';

class SplashPage extends StatefulWidget {
  final String title;
  final String identificador;
  const SplashPage({Key key, this.title = "Splash", this.identificador})
      : super(key: key);

  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  // final AuthController _authController = AppModule.to.get<AuthController>();
  // final CNPJSController _cnpjsController = Modular.get<CNPJSController>();
  final _appController = Modular.get<AppController>();

  @override
  void initState() {
    print('inistate do splash_page');
    // _authController.setLoading();
    super.initState();

    // // SystemChrome.setEnabledSystemUIOverlays([]);  // ---ocupa toda tela

    logaEmpresaEUsuario();
  }

  void logaEmpresaEUsuario() {
    Future.delayed(Duration(milliseconds: 2000)).then((_) async {
      //
      var resp = await _appController.carregaEmpresaAtiva(widget.identificador);
      //
      if (resp == false) {
        // carrega pagina critica..nao pode entrar no sistema
        // OU chama tela de escolher qual loja (1ª opção é o padrao)
      }

      resp = await _appController.loadCurrentUser();

      // WidgetsBinding.instance.addPostFrameCallback((_) {
      //   if (resp == true || MyConst.permiteSemLogar == true) {
      //     Modular.to.pushNamedAndRemoveUntil('/home', (route) => false);
      //   } else {
      //     Modular.to.pushNamedAndRemoveUntil('/login', (route) => false);
      //   }
      // });

      //
    });
  }

  @override
  Widget build(BuildContext context) {
    print('build splash_page');
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(5),
            height: 50,
            child: Center(child: CircularProgressIndicator()),
          ),
          SizedBox(height: 15),
          GestureDetector(
            onTap: () {
              //  Modular.to
              //   .pushNamedAndRemoveUntil('/home', ModalRoute.withName('/home'));
              Modular.to.navigate('/home');
            },
            child: Image.asset('assets/logoagsystem.png'),
          ),
        ],
      ),
    );
  }
}
