import 'package:get/get.dart';
import 'package:get/get_rx/src/rx_workers/utils/debouncer.dart';

extension DebouncerInt on int {
  Debouncer get millisecondDebouncer => Debouncer(delay: milliseconds);
}
