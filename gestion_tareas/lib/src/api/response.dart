class Respuesta {
  int statusCode = 0;
  String message = "";
  bool ok = false;
  dynamic data;

  Respuesta(bool ok, int statusCode, String message, {this.data}) {
    this.ok = ok;
    this.statusCode = statusCode;
    this.message = message;
  }
}