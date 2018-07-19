[![RU](https://user-images.githubusercontent.com/9499881/27683795-5b0fbac6-5cd8-11e7-929c-057833e01fb1.png)](https://github.com/r57zone/Steering-wheel-for-PC-with-OpenTrack-and-Android/blob/master/README.md) 
[![EN](https://user-images.githubusercontent.com/9499881/33184537-7be87e86-d096-11e7-89bb-f3286f752bc6.png)](https://github.com/r57zone/Steering-wheel-for-PC-with-OpenTrack-and-Android/blob/master/README.EN.md) 
# Steering wheel for PC, OpenTrack, Android, XInput
Steering wheel for PC, emulating Xbox gamepad, using Android smartphone (with gyroscope) and OpenTrack over Wi-Fi or USB. Emulated left and right triggers, as well as left stick, usually this is enough for racing.
The forward slope activates the right trigger (forward motion), and the backward slope of the left trigger (backward movement). The left stick (left, right) is activated by tilting left and right. Slopes smoothly change the values of triggers and stick.
## Setup
Download and install the latest version of [OpenTrack](https://github.com/opentrack/opentrack/releases) and run it. Install FreePie IMU on Android from the archive.
<br><br>
In OpenTrack settings, you must select the data source: "FreePie UDP receiver", and the output interface: "freetrack 2.0 Enhanced". Then click the "Run" button.
<br><br>
Run the application "XInputTest.exe" to check, from the downloaded archive. Try to tilt the smartphone in different directions.
<br><br>
The value of Pitch ("Game data" in OpenTrack) is responsible for turning the rudder to the left and right. The value of Roll ("Game data" in OpenTrack) is responsible for moving forward and backward. It is possible that you will have to exchange Yaw, Pitch or Roll in the OpenTrack profile settings.
<br><br>
In "WheelSetup.ini" you can change the blind zone (for lack of any movement), the maximum and minimum angles for activating the triggers. More details are described in the configuration file. The angles can be seen in OpenTrack ("Game data").
<br><br>
After the configuration, you need to copy the files "xinput1_3.dll" (for 32 bit games, and for 64 bit copy "xinput1_3x64.dll" and rename to "xinput1_3.dll") and "WheelSetup.ini" to the folder with the game, and run the game. Perhaps for some older games, you will have to rename "xinput1_3.dll" to one of the names: "xinput1_4.dll" (Windows 8 / metro apps only), "xinput1_2.dll", "xinput1_1.dll" or "xinput9_1_0.dll" .
<br><br>
After starting the game, press "F9" and run the FreePie application for Android, enter the IP address of the computer and press the button. The "F10" button turns off the steering wheel.
## Download
>Version for Windows XP, 7, 8.1, 10.<br>
**[Download](https://github.com/r57zone/Steering-wheel-for-PC-with-OpenTrack-and-Android/releases)**<br>
## Feedback
`r57zone[at]gmail.com`
