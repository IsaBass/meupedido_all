import 'package:flutter_modular/flutter_modular.dart';

class TestenovoModule extends Module {
  @override
  final List<Bind> binds = [];

  @override
  final List<ModularRoute> routes = [ModuleRoute(routerName, module: module)];
}
