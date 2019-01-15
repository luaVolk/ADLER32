import "package:test/test.dart";
import 'package:adler32/adler32.dart';

void main() {
  test("Takes an array of bytes and gets the checksum", () {
    expect(Adler32.buf([65,121,121,32,108,109,97,111,33,33,33]), equals(381289312));
  });

  test("Takes a binary string and gets the checksum", () {
    expect(Adler32.bstr("Ayy lmao!!!"), equals(381289312));
  });

  test("Takes a string and gets the checksum", () {
    expect(Adler32.str("Ayy lmao!!!"), equals(381289312));
  });
}
