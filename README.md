[![RU](https://user-images.githubusercontent.com/9499881/27683795-5b0fbac6-5cd8-11e7-929c-057833e01fb1.png)](https://github.com/r57zone/Steering-wheel-for-PC-with-OpenTrack-and-Android/blob/master/README.md) 
[![EN](https://user-images.githubusercontent.com/9499881/33184537-7be87e86-d096-11e7-89bb-f3286f752bc6.png)](https://github.com/r57zone/Steering-wheel-for-PC-with-OpenTrack-and-Android/blob/master/README.EN.md) 
# Руль для ПК, OpenTrack, Android, XInput
Руль для ПК, эмулирующий Xbox геймпад, с использованием Android смартфона (с гироскопом) и OpenTrack, по Wi-Fi или USB. Эмулируются левый и правый триггеры, а также левый стик, обычно этого достаточно для гонок. 
Наклон вперед активирует правый триггер (движение вперед), а наклон назад левый триггер (движение назад). Наклонами влево и вправо активируется левый стик (движения влево, вправо). Наклоны плавно изменяют значения триггеров и стика.
## Настройка
Загрузите и установите последнюю версию [OpenTrack](https://github.com/opentrack/opentrack/releases) и запустите её. Установите FreePie IMU на Android из архива.
<br><br>
В настройках OpenTrack необходимо выбрать источник данных: "FreePie UDP receiver", а выходной интерфейс: "freetrack 2.0 Enhanced". Далее нажать кнопку "Запустить".
<br><br>
Запустите приложение "XInputTest.exe" для проверки, из загруженного архива. Попробуйте наклонить смартфон в разные стороны.
<br><br>
Значение Pitch ("Игровые данные" в OpenTrack) отвечает за поворот руля влево и вправо. Значение Roll ("Игровые данные" в OpenTrack) отвечает за движение вперед и назад. Возможно, что вам придется обменять местами Yaw, Pitch или Roll, в настройках профиля OpenTrack. 
<br><br>
В "WheelSetup.ini" можно изменить слепую зону (для отсутствия какого-либо движения), максимальные и минимальные углы для активирования триггеров. Более подробно описано в конфигурационном файле. Углы можно посмотреть в OpenTrack ("Игровые данные").
<br><br>
После настройки необходимо скопировать файлы "xinput1_3.dll" (для 32 битных игр, а для 64 битных скопировать "xinput1_3x64.dll" и переименовать в "xinput1_3.dll") и "WheelSetup.ini" в папку с игрой, и запустить игру.  Возможно, для некоторых старых игр, придется переименовать "xinput1_3.dll" в одно из названий: "xinput1_4.dll" (Windows 8 / metro apps only), "xinput1_2.dll", "xinput1_1.dll" или "xinput9_1_0.dll".
<br><br>
После запуска игры нажать "F9" и запустить приложение FreePie для Android, ввести IP адрес компьютера и нажать кнопку. Кнопка "F10" отключит руль.
## Загрузка
>Версия для Windows XP, 7, 8.1, 10.<br>
**[Загрузить](https://github.com/r57zone/Steering-wheel-for-PC-with-OpenTrack-and-Android/releases)**<br>
## Обратная связь
`r57zone[собака]gmail.com`