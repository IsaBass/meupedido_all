abstract class IAppRepository {
  Future<Map<String, dynamic>> getCnpjConfigs(String cnpj);
}
