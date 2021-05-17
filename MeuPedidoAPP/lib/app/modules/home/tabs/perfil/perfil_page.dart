import 'package:MeuPedido/app/app_controller.dart';
import 'package:MeuPedido/app/app_module.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:meupedido_core/meupedido_core.dart';

class PerfilPage extends StatefulWidget {
  @override
  _PerfilPageState createState() => _PerfilPageState();
}

class _PerfilPageState extends State<PerfilPage> {
  final AuthController _authController = AppModule.to.get<AuthController>();
  final AppController _appController = AppModule.to.get<AppController>();
  final CartController _cartController = AppModule.to.get<CartController>();
  final shapeCards =
      RoundedRectangleBorder(borderRadius: BorderRadius.circular(10));

  final double elevCards = 4.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Perfil'), centerTitle: true),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Observer(
                builder: (_) =>
                    exibeCarregandoLinha(isLoading: _authController.isLoading),
              ),
              Observer(
                builder: (_) =>
                    _cardUsuario(context, _authController.userAtual),
              ),
              _cardEndereco(context),
              _cardCartoes(context),
              _cardDarkMode(context),
              _cardLogout(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _cardUsuario(BuildContext ctx, UserModel user) => Card(
        elevation: elevCards,
        shape: shapeCards, //    ,
        child: Container(
          constraints: BoxConstraints(minHeight: 150),
          // margin: EdgeInsets.symmetric(horizontal: 10, vertical: 0),
          child: Stack(
            children: [
              Container(
                constraints: BoxConstraints(minHeight: 150),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    _fotoUser(ctx),
                    //SizedBox(width: 10),
                    Flexible(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(user.nome,
                              maxLines: 2,
                              textAlign: TextAlign.center,
                              overflow: TextOverflow.ellipsis),
                          Text(user.email,
                              maxLines: 2,
                              textAlign: TextAlign.center,
                              overflow: TextOverflow.ellipsis),
                          Text(user.telefone,
                              maxLines: 2,
                              textAlign: TextAlign.center,
                              overflow: TextOverflow.ellipsis),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              //Positioned(top: 5, child: FaIcon(FontAwesomeIcons.user)),
              Positioned(
                  right: 5,
                  bottom: 0,
                  child: IconButton(
                    icon: Icon(FontAwesomeIcons.edit, color: Colors.grey),
                    onPressed: () async {
                      if ((await Modular.to.pushNamed('home/editusuario')) ==
                          true) {
                        mySnackBar(ctx,
                            texto: "Cadastro salvo com sucesso.",
                            color: Colors.indigo[900],
                            miliseconds: 1500);
                      }
                    },
                  )),
            ],
          ),
        ),
      );

  Widget _fotoUser(BuildContext ctx) {
    return InkWell(
      child: Container(
          width: 120.0,
          height: 120.0,
          child: ClipOval(
            // clipper: ,
            child: agImageProvider(
              imgTipo: 'EXT',
              imgUrl: _authController.userAtual.urlImg,
              fit: BoxFit.cover,
            ),
          )),
      onLongPress: () async {
        await showOptionsFotoCadastro(
          ctx: ctx,
          inicioArquivo: _authController.userAtual.firebasebUser.uid,
          onSimExcluir: () {
            setState(() {
              return _authController.userAtual.urlImg = '';
            });
            _authController.saveUserData(alterarLoading: true);
          },
          onNovoArquivo: (novaUrl) {
            if (novaUrl == null || novaUrl.isEmpty) return;
            //
            setState(() {
              _authController.userAtual.urlImg = novaUrl;
            });
            _authController.saveUserData(alterarLoading: true);
            return;
          },
        );
      },
    );
  }

  Widget _cardEndereco(BuildContext context) => Card(
        elevation: elevCards,
        shape: shapeCards, //    ,
        child: Container(
          constraints: BoxConstraints(minHeight: 50),
          // margin: EdgeInsets.symmetric(horizontal: 10, vertical: 0),
          child: ListTile(
            title: Text('Endereços'),
            leading: Icon(FontAwesomeIcons.mailBulk,
                color: Theme.of(context).accentColor),
            trailing: IconButton(
              icon: Icon(FontAwesomeIcons.chevronRight),
              onPressed: () {
                Modular.to.pushNamed('home/listenderecos');
              },
            ),
          ),
        ),
      );

  Widget _cardDarkMode(BuildContext context) => Card(
        elevation: elevCards,
        shape: shapeCards, //    ,
        child: Container(
          constraints: BoxConstraints(minHeight: 50),
          //margin: EdgeInsets.symmetric(horizontal: 10, vertical: 0),
          child: SwitchListTile(
            title: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(5, 0, 28, 0),
                  child: Icon(FontAwesomeIcons.adjust,
                      color: Theme.of(context).accentColor),
                ),
                Text('Modo Escuro'),
              ],
            ),
            value: _appController.temaDark ?? false,
            onChanged: _appController.setTemaDark,
          ),
        ),
      );

  Widget _cardCartoes(BuildContext context) => Card(
        elevation: elevCards,
        shape: shapeCards, //    ,
        child: Container(
          constraints: BoxConstraints(minHeight: 50),
          // margin: EdgeInsets.symmetric(horizontal: 10, vertical: 0),
          child: ListTile(
            title: Text('Cartões de Crédito'),
            leading: Icon(FontAwesomeIcons.creditCard,
                color: Theme.of(context).accentColor),
            trailing: IconButton(
              icon: Icon(FontAwesomeIcons.chevronRight),
              onPressed: () {},
            ),
          ),
        ),
      );

  Widget _cardLogout(BuildContext context) => Card(
        elevation: elevCards,
        shape: shapeCards, //    ,
        child: Container(
          constraints: BoxConstraints(minHeight: 50),
          // margin: EdgeInsets.symmetric(horizontal: 10, vertical: 0),
          child: ListTile(
            title: Text('Sair'),
            leading: Icon(FontAwesomeIcons.userAltSlash,
                color: Theme.of(context).accentColor),
            trailing: IconButton(
              icon: Icon(FontAwesomeIcons.doorOpen),
              onPressed: () {
                _cartController.limparCarrinho();
                _authController.signOut();
              },
            ),
          ),
        ),
      );
}
