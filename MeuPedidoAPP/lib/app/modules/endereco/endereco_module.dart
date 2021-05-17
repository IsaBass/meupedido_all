import 'package:flutter_modular/flutter_modular.dart';

// import 'endereco_controller.dart';
import 'endereco_page.dart';
import 'endx_controller.dart';
import 'repository/endereco_repository.dart';

class EnderecoModule extends ChildModule {
  @override
  List<Bind> get binds => [
        Bind((i) => EnderecoRepository()),
        Bind((i) => EnderecoController()),
      ];

  @override
  List<ModularRouter> get routers => [
        //Router('/', child: (_, args) => EnderecoPage()),
        ModularRouter('/edit',
            child: (_, args) => EnderecoPage(
                  endereco: args.data['endereco'],
                )),
        ModularRouter('/novo', child: (_, args) => EnderecoPage()),
      ];

  static Inject get to => Inject<EnderecoModule>.of();
}
