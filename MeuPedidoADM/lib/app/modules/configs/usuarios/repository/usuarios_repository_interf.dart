import 'package:cloud_firestore/cloud_firestore.dart';

abstract class IUsuariosRepository {
  //
  Future<List<Map<String, dynamic>>> getAllUsuarios(String cnpj);
  Future salvarUsuario(DocumentReference docRef, Map dados);
  //
}
