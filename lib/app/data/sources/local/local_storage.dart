import 'package:deeznote/config/main_config.dart';

extension SaveString on String {
  /// save data by key from local storage
  void save(String key) => MainConfig.storage.write(key, this);
}

extension SaveNum on num {
  /// save data by key from local storage
  void save(String key) => MainConfig.storage.write(key, this);
}

extension SaveMap on Map {
  /// save data by key from local storage
  void save(String key) => MainConfig.storage.write(key, this);
}

extension SaveList on List {
  /// save data by key from local storage
  void save(String key) => MainConfig.storage.write(key, this);
}

extension SaveBool on bool {
  /// save data by key from local storage
  void save(String key) => MainConfig.storage.write(key, this);
}

extension ReadRemoveData on String {
  /// Load data by key from local storage
  dynamic load() => MainConfig.storage.read(this);

  /// remove data by key from local storage
  dynamic remove() => MainConfig.storage.remove(this);
}
