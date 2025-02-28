abstract class Failure {
  Failure(this.message);
  final String message;
}

class ApiResponseFailureModel extends Failure {
  ApiResponseFailureModel({String message = ''}) : super(message);

  @override
  String toString() => message;
}

class GenericFailure extends Failure {
  GenericFailure({String message = ''}) : super(message);

  @override
  String toString() => message;
}

class DatabaseFailure extends Failure {
  DatabaseFailure({String message = ''}) : super(message);

  @override
  String toString() => message;
}
