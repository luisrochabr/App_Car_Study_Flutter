class ApiReponse<T>{
  bool ok;
  String msg;
  T result;

  ApiReponse.ok(this.result){
    ok = true;
  }

  ApiReponse.erro(this.msg){
    ok = false;
  }

}