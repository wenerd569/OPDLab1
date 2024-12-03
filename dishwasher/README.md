
### App.java
точка входа ar[0] - порт на котором запустится ws server

### Dishwasher.java
Посудомойка заменяет рандомные символы в файле на пробелы
#### class Dishwasher
```
WashMode:
[eco, hygiene, intense]

public Dishwasher(String dirty_file_dir, String clean_file_dir)
public start() //сканирует папку dirty_file и чистит их и переносит в clean_file
public setMode(WashMode mode) // установить режим очистки

private washFile(Fiel in, File out) //заменяет рандомные символы в в файле на пробелы
```
### DishwashControler:
обычный ws server без шифрования. В зависимости от комманды клиента запускает посудомойку с разными режимами
