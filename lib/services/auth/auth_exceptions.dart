// ignore_for_file: camel_case_types
//login exceptions
class userNotFoundAuthException implements Exception {}

class wrongPasswordAuthException implements Exception {}

//register exceptions
class weakPasswordAuthException implements Exception {}

class emailAlreadyInUseAuthException implements Exception {}

class invalidEmailAuthException implements Exception {}

//generic exceptions
class genericAuthException implements Exception {}

class userNotLogedInFoundAuthException implements Exception {}
