class Rsp<T extends Object> {
  RspType resp;
  T data;
  String error;

  Rsp.ok(this.data) : this.resp = RspType.ok;
  Rsp.error(this.error) : this.resp = RspType.error;
  Rsp.empty() : resp = RspType.empty;
}

enum RspType { ok, error, empty }



/*

 Future<void> rspExecute<TFunc, TRet>({
    Function functionMain,
    void respOk(TRet data),
    void respError(String erro),
    void respEmpty(),
  }) async {
    TFunc resp = await functionMain();
    String r;

    // if(ok) {
    //   respOk(resp);
    // }
    // if (erro) {
    //   respErro(messag erro);
    // }
    // if( empty) {
    //   respEmpty();
    // }
  }

  teste() async {
    //
    await rspExecute<Map<String, dynamic>, String>(
      functionMain: () {},
      respOk: (str) {
        print(str);
        return;
      },
      respError: (err) {
        print(err);
      },
      respEmpty: () {},
    );
    //
  }

*/
