/// Signed ADLER-32 algorithm implementation in Dart
library adler32;

import 'dart:math';
import 'src/util.dart';

/// Main class that contains all 3 functions
abstract class Adler32 {
  /// Get checksum from a binary string
  static int bstr(String bstr, [int? seed]) {
    int a = 1, b = 0, L = bstr.length, M = 0;
    if (seed != null) {
      a = seed & 0xFFFF;
      b = zfrs(seed, 16);
    }
    for (int i = 0; i < L;) {
      M = min(L - i, 3850) + i;
      for (; i < M; i++) {
        a += bstr.codeUnitAt(i) & 0xFF;
        b += a;
      }
      a = (15 * zfrs(a, 16) + (a & 65535));
      b = (15 * zfrs(b, 16) + (b & 65535));
    }
    return ((b % 65521) << 16) | (a % 65521);
  }

  /// Get checksum from a array of bites
  static int buf(List<int> buf, [int? seed]) {
    int a = 1, b = 0, L = buf.length, M = 0;
    if (seed != null) {
      a = seed & 0xFFFF;
      b = zfrs(seed, 16) & 0xFFFF;
    }
    for (int i = 0; i < L;) {
      M = min(L - i, 3850) + i;
      for (; i < M; i++) {
        a += buf[i] & 0xFF;
        b += a;
      }
      a = (15 * zfrs(a, 16) + (a & 65535));
      b = (15 * zfrs(b, 16) + (b & 65535));
    }
    return ((b % 65521) << 16) | (a % 65521);
  }

  /// Get checksum from a regular string
  static int str(String str, [int? seed]) {
    int a = 1, b = 0, L = str.length, M = 0, c = 0, d = 0;
    if (seed != null) {
      a = seed & 0xFFFF;
      b = zfrs(seed, 16);
    }
    for (int i = 0; i < L;) {
      M = min(L - i, 3850);
      while (M > 0) {
        c = str.codeUnitAt(i++);
        if (c < 0x80) {
          a += c;
        } else if (c < 0x800) {
          a += 192 | ((c >> 6) & 31);
          b += a;
          --M;
          a += 128 | (c & 63);
        } else if (c >= 0xD800 && c < 0xE000) {
          c = (c & 1023) + 64;
          d = str.codeUnitAt(i++) & 1023;
          a += 240 | ((c >> 8) & 7);
          b += a;
          --M;
          a += 128 | ((c >> 2) & 63);
          b += a;
          --M;
          a += 128 | ((d >> 6) & 15) | ((c & 3) << 4);
          b += a;
          --M;
          a += 128 | (d & 63);
        } else {
          a += 224 | ((c >> 12) & 15);
          b += a;
          --M;
          a += 128 | ((c >> 6) & 63);
          b += a;
          --M;
          a += 128 | (c & 63);
        }
        b += a;
        --M;
      }
      a = (15 * zfrs(a, 16) + (a & 65535));
      b = (15 * zfrs(b, 16) + (b & 65535));
    }
    return ((b % 65521) << 16) | (a % 65521);
  }
}