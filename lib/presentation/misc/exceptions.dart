class AppException {
  final dynamic e;
  final String debugInfo;
  AppException(this.e, this.debugInfo);

  @override
  String toString() {
    return super.toString() + " e[$e] d[$debugInfo]";
  }
}

class JsonParsingException extends AppException {
  JsonParsingException(e, debugInfo) : super(e, debugInfo);
}

class NetworkException extends AppException {
  NetworkException(e, debugInfo) : super(e, debugInfo);
}

class DataLoadingException extends AppException {
  DataLoadingException(e, debugInfo) : super(e, debugInfo);
}
