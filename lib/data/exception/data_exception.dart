// ignore_for_file: annotate_overrides

class DataException implements Exception {
  final String? statusCode;
  final String? message;

  const DataException({
    this.message,
    this.statusCode,
  });

  String toString() => '${message.toString()}: $message';
}
