import 'package:flutter/cupertino.dart';

printError(final text) {
  debugPrint('\x1B[31m$text\x1B[0m');
}

printWarning(final text) {
  debugPrint('\x1B[33m$text\x1B[0m');
}
