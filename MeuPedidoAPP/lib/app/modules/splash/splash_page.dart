import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'package:meupedido_core/meupedido_core.dart';
import 'package:MeuPedido/app/app_module.dart';

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
  final CNPJSController _cnpjsController = AppModule.to.get<CNPJSController>();

  @override
  void initState() {
    print('inistate do splash_page');
   // _authController.setLoading();
    super.initState();

    // // SystemChrome.setEnabledSystemUIOverlays([]);  // ---ocupa toda tela
    Future.delayed(Duration(milliseconds: 100)).then((_) async {
      //
      await carregaEmpresaAtiva();
      //

      //await carregaUsuario();
      //
      //SystemChrome.setEnabledSystemUIOverlays(SystemUiOverlay.values); // ---retira ocupa toda tela
      Modular.to.pushNamedAndRemoveUntil('/home', (route) => false);
    });
  }

  // Future<void> carregaUsuario() async {
  //   _authController.setLoading();
  //   // await Future.delayed(Duration(seconds: 10));
  //   await _authController.loadCurrentUser().then((_) {
  //     if (_authController.estaLogado) {
  //       print('na tela splach:: estaLogado com sucesso');
  //       AppModule.to.get<CartController>().carregaCarrinhoUser();
  //     }
  //     _authController.setNoLoading();

  //     /// SystemChrome.setEnabledSystemUIOverlays(SystemUiOverlay.values);// ---retira ocupa toda tela
  //     if (_authController.estaLogado || MyConst.permiteSemLogar == true) {
  //       Modular.to.pushNamedAndRemoveUntil('/home', (route) => false);
  //     } else {
  //       Modular.to.pushNamedAndRemoveUntil('/login', (route) => false);
  //     }
  //   }).catchError((e) {
  //     print('erro ao logar na tela splach');
  //     _authController.setNoLoading();
  //     if (MyConst.permiteSemLogar == true) {
  //       Modular.to.pushNamedAndRemoveUntil('/home', (route) => false);
  //     } else {
  //       Modular.to.pushNamedAndRemoveUntil('/login', (route) => false);
  //     }
  //   });
  // }

  Future<void> carregaEmpresaAtiva() async {
    if (widget.identificador == null || widget.identificador == '') {
      // if na web
      // manda pra pag de erro ou de escolher qual cliente
      // else , ou seja...em app mobile..sempre tem empresafixa
      _cnpjsController.cnpjAtivo =
          await _cnpjsController.getCnpjM(MyConst().cnpjEmpresaFixa);
      print(
          'na tela splach:: empresa ativa = ${_cnpjsController.cnpjAtivo.descricao}');
    } else {
      var cnpj =
          await _cnpjsController.getCnpjMIdentificador(widget.identificador);
      if (cnpj != null) {
        _cnpjsController.cnpjAtivo = cnpj;
      } else {
        // direcionar pra pag de erro...empresa nao encontrada
      }
    }
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
            onTap: () =>
                Modular.to.pushNamedAndRemoveUntil('/home', (route) => false),
            child: Image.asset('assets/logoagsystem.png'),
          ),
        ],
      ),
    );
  }
}
