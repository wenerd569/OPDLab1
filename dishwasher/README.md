
### App.java

точка входа ar[0] - порт на котором запустится ws server

### Dishwasher.java
```
WashMode:
[eco, hygiene, intense]

Dishwasher(File dirty_file_dir, File clean_file_dir);
public start() //сканирует папку dirty_file и чистит их и переносит в clean_file
public setMode(WashMode mode) //установить режим очистки
```
### DishwashControler

Принимает максимум одно соединение, запускает Dishwasher

### WSoket

Костыль и велосипед

Самописный websoket на протоколе главное что работает

