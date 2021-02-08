class ProviderException implements Exception {
  ProviderException(this.message);

  final String message;

  @override
  String toString() {
    return message;
  }
}
