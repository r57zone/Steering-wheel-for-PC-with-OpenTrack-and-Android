# Руль для ПК, OpenTrack, Android, XInput (Ru)
Руль для ПК, эмулирующий Xbox геймпад, с использованием Android смартфона (с гироскопом) и OpenTrack, по Wi-Fi или USB. Эмулируются левый и правый триггеры, а также левый стик, обычно этого достаточно для гонок. 
Наклон вперед активирует правый триггер (движение вперед), а наклон назад левый триггер (движение назад). Наклонами влево и вправо активируется левый стик (движения влево, вправо). Наклоны плавно изменяют значения триггеров и стика.
## Настройка
Загрузите и установите последнюю версию [OpenTrack](https://github.com/opentrack/opentrack/releases) и запустите её. Установите FreePie IMU на Android из архива.
<br><br>
В настройках OpenTrack необходимо выбрать источник данных: "FreePie UDP receiver", а выходной интерфейс: "UDP over network". Далее нажать кнопку "Запустить".
<br><br>
Запустите приложение "XInputTest.exe" для проверки, из загруженного архива. Попробуйте наклонить смартфон в разные стороны.
<br><br>
Значение Pitch ("Игровые данные" в OpenTrack) отвечает за поворот руля влево и вправо. Значение Roll ("Игровые данные" в OpenTrack) отвечает за движение вперед и назад. Возможно, что вам придется обменять местами Yaw, Pitch или Roll, в настройках профиля OpenTrack. 
<br><br>
В "WheelSetup.ini" можно изменить слепую зону (для отсутствия какого-либо движения), максимальные и минимальные углы для активирования триггеров. Углы можно посмотреть в OpenTrack ("Игровые данные"). 
<br><br>
После настройки необходимо скопировать файлы "xinput1_3.dll"   и "WheelSetup.ini" в папку с игрой, и запустить игру. Возможно, для некоторых старых игр, придется переименовать "xinput1_3.dll" в одно из названий: "xinput1_4.dll" (Windows 8 / metro apps only), "xinput1_2.dll", "xinput1_1.dll" или "xinput9_1_0.dll".
<br><br>
После запуска игры нажать "F9" и запустить приложение FreePie для Android, ввести IP адрес компьютера и нажать кнопку. Кнопка "F10" отключит руль.## Фильтры
## Загрузка
>Версия для Windows XP, 7, 8.1, 10.<br>
**[Загрузить](https://github.com/r57zone/Steering-wheel-for-PC-with-OpenTrack-and-Android/releases)**<br>
## Обратная связь
`r57zone[собака]gmail.com`

# Steering wheel for PC, OpenTrack, Android, XInput (En)
Steering wheel for PC, emulating Xbox gamepad, using Android smartphone (with gyroscope) and OpenTrack over Wi-Fi or USB. Emulated left and right triggers, as well as left stick, usually this is enough for racing.
The forward slope activates the right trigger (forward motion), and the backward slope of the left trigger (backward movement). The left stick (left, right) is activated by tilting left and right. Slopes smoothly change the values of triggers and stick.
## Setup
Download and install the latest version of [OpenTrack](https://github.com/opentrack/opentrack/releases) and run it. Install FreePie IMU on Android from the archive.
<br><br>
In OpenTrack settings, you must select the data source: "FreePie UDP receiver", and the output interface: "UDP over network". Then click the "Run" button.
<br><br>
Run the application "XInputTest.exe" to check, from the downloaded archive. Try to tilt the smartphone in different directions.
<br><br>
The value of Pitch ("Game data" in OpenTrack) is responsible for turning the rudder to the left and right. The value of Roll ("Game data" in OpenTrack) is responsible for moving forward and backward. It is possible that you will have to exchange Yaw, Pitch or Roll in the OpenTrack profile settings.
<br><br>
In "WheelSetup.ini" you can change the blind zone (for lack of any movement), the maximum and minimum angles for activating the triggers. The angles can be seen in OpenTrack ("Game data").
<br><br>
After the configuration, you need to copy the files "xinput1_3.dll" and "WheelSetup.ini" to the folder with the game, and run the game. Perhaps for some older games, you will have to rename "xinput1_3.dll" to one of the names: "xinput1_4.dll" (Windows 8 / metro apps only), "xinput1_2.dll", "xinput1_1.dll" or "xinput9_1_0.dll" .
<br><br>
After starting the game, press "F9" and run the FreePie application for Android, enter the IP address of the computer and press the button. The "F10" button turns off the steering wheel.
## Download
>Version for Windows XP, 7, 8.1, 10.<br>
**[Download](https://github.com/r57zone/Steering-wheel-for-PC-with-OpenTrack-and-Android/releases)**<br>
## Feedback
`r57zone[at]gmail.com`
