import 'package:flutter_modular/flutter_modular.dart';

// import 'endereco_controller.dart';
import 'endereco_page.dart';
import 'endx_controller.dart';
import 'repository/endereco_repository.dart';

class EnderecoModule extends Module {
  @override
  List<Bind> get binds => [
        Bind((i) => EnderecoRepository()),
        Bind((i) => EnderecoController()),
      ];

  @override
  List<ModularRoute> get routers => [
        //Router('/', child: (_, args) => EnderecoPage()),
        ChildRoute('/edit',
            child: (_, args) => EnderecoPage(
                  endereco: args.data['endereco'],
                )),
        ChildRoute('/novo', child: (_, args) => EnderecoPage()),
      ];

  // static Inject get to => Inject<EnderecoModule>.of();
}
