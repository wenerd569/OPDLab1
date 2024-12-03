
### App.java - точка входа ar[0] - порт на котором запустится ws server

### Dishwasher.java
WashMode:
[eco, hygiene, intense]

Dishwasher(String dirty_file_dir, String clean_file_dir);
public start() - сканирует папку dirty_file и чистит их и переносит в clean_file
public setMode(WashMode mode) - установить режим очистки

### DishwashControler:
обычный ws server в зависимости ввода запускает посудомойку с разными режимами
