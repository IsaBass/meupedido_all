class Rsp<T extends Object> {
  RspType resp;
  T data;
  String error;
}

enum RspType { ok, error }
