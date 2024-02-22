import 'package:deeznote/config/main_config.dart';

extension SaveData on dynamic {
  /// save data by key from local storage
  void save(String key) => MainConfig.storage.write(key, this);
}

extension ReadRemoveData on String {
  /// Load data by key from local storage
  dynamic load() => MainConfig.storage.read(this);

  /// remove data by key from local storage
  dynamic remove() => MainConfig.storage.remove(this);
}
