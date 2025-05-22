import 'package:throttling/throttling.dart';

final Throttling throttling = Throttling(duration: const Duration(seconds: 2));

void throttle(Function action) {
  throttling.throttle(() => action());
}

