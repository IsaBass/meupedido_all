class Rsp<T extends Object> {
  RspType resp;
  T data;
  String error;

  Rsp.ok(this.data) : this.resp = RspType.ok;
  Rsp.error(this.error) : this.resp = RspType.error;
  Rsp.empty() : resp = RspType.empty;
}

enum RspType { ok, error, empty }
