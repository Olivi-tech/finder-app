class ErrorHandling {
  static handleErrors({dynamic error}) {
    if (error is NoInternetException) {
      throw NoInternetException('No Internet');
    } else if (error is NoServiceFoundException) {
      throw NoServiceFoundException('No Service Found');
    } else if (error is InvalidFormatException) {
      throw InvalidFormatException('Invalid Data Format');
    } else {
      throw UnknownException('Unknown Exception found');
    }
  }
}

class NoInternetException {
  String message;
  NoInternetException(this.message);
}

class NoServiceFoundException {
  String message;
  NoServiceFoundException(this.message);
}

class InvalidFormatException {
  String message;
  InvalidFormatException(this.message);
}

class UnknownException {
  String message;
  UnknownException(this.message);
}
