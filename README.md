# ADLER32 [![Pub](https://img.shields.io/pub/v/adler32.svg)](https://pub.dartlang.org/packages/adler32)

Port of [SheetJS' adler32](https://github.com/SheetJS/js-adler32) written in Dart.

## Instalation

  ```bash
  $ pub get adler32
  ```

## Usage

  Importing this library exposes the class `Adler32` which contains 3 functions.

### buf
  `int buf(List<int> buf, [int seed])`
  
  The `buf` function takes an array of bytes as the first argument

  ##### Example
  ```dart
  Adler32.buf([65,121,121,32,108,109,97,111,33,33,33]) // 381289312
  ```

### bstr
  `int bstr(String bstr, [int seed])`
  
  The `bstr` function takes a binary string the first argument

  ##### Example
  ```dart
  Adler32.bstr("Ayy lmao!!!") // 381289312
  ```

### str
  `int str(String str, [int seed])`
  
  The `str` function takes a string the first argument

  ##### Example
  ```dart
  Adler32.str("Ayy lmao!!!") // 381289312
  ```
### Using `seed`
All 3 functions take a second optional argument for the starting "seed"

```dart
  int adler32 = Adler32.buf([65, 121, 121]);  // 36766004  "Ayy"
  adler32 = Adler32.str(" lmao", adler32);    // 217907965  "Ayy lmao"
  Adler32.bstr("!!!", adler32);               // 381289312 "Ayy lmao!!!"
```

## License
   [Apache 2.0 License](LICENSE)
