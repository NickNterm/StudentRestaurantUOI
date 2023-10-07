import 'dart:io';

String fixture(String name) => File(
      'test/fixture/json/$name',
    ).readAsStringSync();
