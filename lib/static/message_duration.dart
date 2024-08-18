import "dart:math";

const imageDelay = Duration(seconds: 1);

double logBase(num x, num base) => log(x) / log(base);
double log10(num x) => logBase(x, 10);

Duration durationFromText(String text) {
  final ms = log10(text.length) * 1400;
  return Duration(milliseconds: ms.round());
}
