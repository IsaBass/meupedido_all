import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:intl/intl.dart';
import 'package:meupedidoADM/app/app_module.dart';
import 'package:meupedidoADM/app/modules/configs/widgets/wid.login-textfield.dart';
import 'package:meupedido_core/meupedido_core.dart';


class TabConfigCadastro extends StatefulWidget {
  @override
  _TabConfigCadastroState createState() => _TabConfigCadastroState();
}

class _TabConfigCadastroState extends State<TabConfigCadastro> {
  var _scaffoldKey = new GlobalKey<ScaffoldState>();
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _dateCont = TextEditingController();
  final TextEditingController _nomeCont = TextEditingController();
  final TextEditingController _emailCont = TextEditingController();
  AuthController _controller = AppModule.to.get();

  DateTime _selectedDataNascimento;

  @override
  void initState() {
    _nomeCont.text = _controller.userAtual.nome;
    _emailCont.text = _controller.userAtual.email;
    _selectedDataNascimento = _controller.userAtual.dataNascimento;
    if (_selectedDataNascimento != null)
      _dateCont.text = DateFormat(DateFormat.YEAR_NUM_MONTH_DAY, 'pt_Br')
          .format(_selectedDataNascimento);
    // formatDate(_selectedDataNascimento, ['dd', '/', 'mm', '/', 'yyyy']);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Container(
            padding: EdgeInsets.all(8),
            margin: EdgeInsets.symmetric(vertical: 2, horizontal: 2),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                _fotoUsuario(),
                SizedBox(height: 7),
                _editNome(),
                SizedBox(height: 5),
                _editEmail(),
                SizedBox(height: 5),
                _linhaDtNascimento(),
                SizedBox(height: 10),
                _linhaPerfil(),
                SizedBox(height: 7),
                Observer(
                  builder: (_) => Container(
                    height: 50,
                    width: MediaQuery.of(context).size.width,
                    padding: EdgeInsets.all(4),
                    child: _controller.isLoading == true
                        ? Container(
                            child: Center(child: CircularProgressIndicator()))
                        : _botaoSalvar(context),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _linhaPerfil() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
      decoration: BoxDecoration(
        border: Border.all(width: 1, color: Colors.grey),
        borderRadius: BorderRadius.all(Radius.circular(12)),
      ),
      //padding: EdgeInsets.all(8),
      child: Text(
        'Perfil de Acesso: ${_controller.userAtual.perfilString().toUpperCase()}',
        style: TextStyle(fontSize: 16),
      ),
    );
  }

  Widget _linhaDtNascimento() {
    return Container(
      width: double.infinity,
      //height: 180,
      child: Row(
        children: <Widget>[
          Expanded(
            flex: 3,
            child: MyTextField(
              enabled: false,
              textController: _dateCont,
              keyboarType: TextInputType.text,
              iconData: Icons.date_range,
              hintText: 'seleciona a data de Nascimento',
              labelText: 'Data Nascimento',
            ),
          ),
          Expanded(
            flex: 2,
            child: FlatButton.icon(
              shape: Border.all(color: Colors.grey, width: 0.5),
              onPressed: _selectDataNascimento,
              icon: Icon(Icons.date_range),
              label: Text('Escolher'),
            ),
          ),
        ],
      ),
    );
  }

  // //  Expanded(
  // //     flex: 1,
  // // child:
  // FlatButton.icon(
  //     onPressed: _selectDataNascimento,
  //     icon: Icon(Icons.date_range),
  //     label: Text('Selecione')),
  // // ),

  Widget _fotoUsuario() {
    return Center(
      child: GestureDetector(
        child: Observer(
          builder: (_) => Container(
              width: 140.0,
              height: 140.0,
              child: ClipOval(
                // clipper: ,
                child: agImageProvider(
                  imgTipo: 'EXT',
                  imgUrl: _controller.userAtual.urlImg,
                  fit: BoxFit.cover,
                ),
              )),

          //  Container(
          //   height: 150.0,
          //   width: 150.0,
          //   decoration: BoxDecoration(
          //     shape: BoxShape.circle,
          //     image: DecorationImage(
          //       image: _controller.userAtual.urlImg != null
          //           ? // FileImage(File(_editedContact.img))
          //           NetworkImage(_controller.userAtual.urlImg)
          //           : //AssetImage("images/person.png"),
          //           NetworkImage(
          //               'https://picsum.photos/150/150'), //('https://placehold.it/100'),
          //       fit: BoxFit.cover,
          //     ),
          //   ),
          // ),
        ),
        onTap: () async {
          //  showOptionsFotoCadastro(context);
          await showOptionsFotoCadastro(
            ctx: context,
            inicioArquivo: _controller.userAtual.firebasebUser.uid,
            onSimExcluir: () {
              setState(() {
                return _controller.userAtual.urlImg = '';
              });
              _controller.saveUserData(alterarLoading: true);
            },
            onNovoArquivo: (novaUrl) {
              if (novaUrl == null || novaUrl.isEmpty) return;
              //
              setState(() {
                _controller.userAtual.urlImg = novaUrl;
              });
              _controller.saveUserData(alterarLoading: true);
              return;
            },
          );
        },
      ),
    );
  }

  Widget _editEmail() {
    return MyTextField(
      enabled: false,
      textController: _emailCont,
      keyboarType: TextInputType.emailAddress,
      iconData: Icons.email,
      hintText: 'Seu endereço de e-mail',
      labelText: 'E-mail*',
      // helperText: 'seu -email cadastrado',
      validator: (v) {
        if (!v.contains('@') || !v.contains('.')) return 'e-mail inválido';
        return null;
      },
    );
  }

  Widget _editNome() {
    return MyTextField(
      textController: _nomeCont,
      keyboarType: TextInputType.emailAddress,
      iconData: Icons.person,
      hintText: 'Seu nome',
      labelText: 'Nome*',
      //helperText: 'seu -email cadastrado',
      validator: (v) {
        if (!(v.length >= 6)) return 'nome muito curto';
        return null;
      },
    );
  }

  _selectDataNascimento() {
    showDatePicker(
            context: context,
            helpText: 'DATA DE NASCIMENTO',
            // locale: Locale('pt'),
            initialDate: _selectedDataNascimento != null
                ? _selectedDataNascimento
                : DateTime.now(),
            firstDate: DateTime(1900),
            lastDate: DateTime(DateTime.now().year + 1))
        .then(
      (newDate) {
        _selectedDataNascimento = newDate;
        return _dateCont.text =
            DateFormat(DateFormat.YEAR_NUM_MONTH_DAY, 'pt_Br').format(newDate);

        //  formatDate(newDate, ['dd', '/', 'mm', '/', 'yyyy']);
      },
    );
  }

  RaisedButton _botaoSalvar(BuildContext context) {
    return RaisedButton(
      color: Theme.of(context).primaryColor,
      child: Text('Salvar', style: TextStyle(color: Colors.white)),
      onPressed: () {
        if (_formKey.currentState.validate()) {
          _controller.userAtual.nome = (_nomeCont.text);
          _controller.userAtual.email = (_emailCont.text);
          _controller.userAtual.dataNascimento = (_selectedDataNascimento);
          _controller.saveUserData(alterarLoading: true).then((value) {
            mySnackBar(context,
                texto: "Cadastro salvo com sucesso.",
                color: Colors.indigo[900],
                miliseconds: 1500);
          });
        }
      },
    );
  }
}
