library Project1;

{
https://github.com/r57zone/Steering-wheel-for-PC-with-OpenTrack-and-Android
https://r57zone.github.io
}

uses
  Windows, SysUtils, Forms, Classes, IdSocketHandle,
  IdUDPServer, IniFiles;

{$R *.res}

const
  // Constants for gamepad buttons
  XINPUT_GAMEPAD_DPAD_UP          = 1;
  XINPUT_GAMEPAD_DPAD_DOWN        = 2;
  XINPUT_GAMEPAD_DPAD_LEFT        = 4;
  XINPUT_GAMEPAD_DPAD_RIGHT       = 8;
  XINPUT_GAMEPAD_START            = 16;
  XINPUT_GAMEPAD_BACK             = 32;
  XINPUT_GAMEPAD_LEFT_THUMB       = 64;
  XINPUT_GAMEPAD_RIGHT_THUMB      = 128;
  XINPUT_GAMEPAD_LEFT_SHOULDER    = 256;
  XINPUT_GAMEPAD_RIGHT_SHOULDER   = 512;
  XINPUT_GAMEPAD_A                = 4096;
  XINPUT_GAMEPAD_B                = 8192;
  XINPUT_GAMEPAD_X                = 16384;
  XINPUT_GAMEPAD_Y                = 32768;

  //Flags for battery status level
  BATTERY_TYPE_DISCONNECTED       = $00;

  //User index definitions
  XUSER_MAX_COUNT                 = 4;
  XUSER_INDEX_ANY                 = $000000FF;

  //Other
  ERROR_DEVICE_NOT_CONNECTED = 1167;
  ERROR_SUCCESS = 0;

  //Types and headers taken from XInput.pas
  //https://casterprojects.googlecode.com/svn/Delphi/XE2/Projects/DX/DirectXHeaders/Compact/XInput.pas

  type
  //Structures used by XInput APIs
    PXInputGamepad = ^TXInputGamepad;
    _XINPUT_GAMEPAD = record
    wButtons: Word;
    bLeftTrigger: Byte;
    bRightTrigger: Byte;
    sThumbLX: Smallint;
    sThumbLY: Smallint;
    sThumbRX: Smallint;
    sThumbRY: Smallint;
  end;
  XINPUT_GAMEPAD = _XINPUT_GAMEPAD;
  TXInputGamepad = XINPUT_GAMEPAD;

  PXInputState = ^TXInputState;
  _XINPUT_STATE = record
    dwPacketNumber: DWORD;
    Gamepad: TXInputGamepad;
  end;
  XINPUT_STATE = _XINPUT_STATE;
  TXInputState = XINPUT_STATE;

  PXInputVibration = ^TXInputVibration;
  _XINPUT_VIBRATION = record
    wLeftMotorSpeed:  word;  //incorrect data
    wRightMotorSpeed: word;  //incorrect data
  end;
  XINPUT_VIBRATION = _XINPUT_VIBRATION;
  TXInputVibration = _XINPUT_VIBRATION;

  PXInputCapabilities = ^TXInputCapabilities;
  _XINPUT_CAPABILITIES = record
    _Type: Byte;
    SubType: Byte;
    Flags: Word;
    Gamepad: TXInputGamepad;
    Vibration: TXInputVibration;
  end;
  XINPUT_CAPABILITIES = _XINPUT_CAPABILITIES;
  TXInputCapabilities = _XINPUT_CAPABILITIES;

  PXInputBatteryInformation = ^TXInputBatteryInformation;
  _XINPUT_BATTERY_INFORMATION = record
    BatteryType: Byte;
    BatteryLevel: Byte;
  end;
  XINPUT_BATTERY_INFORMATION = _XINPUT_BATTERY_INFORMATION;
  TXInputBatteryInformation = _XINPUT_BATTERY_INFORMATION;

  PXInputKeystroke = ^TXInputKeystroke;
  _XINPUT_KEYSTROKE = record
    VirtualKey: Word;
    Unicode: WideChar;
    Flags: Word;
    UserIndex: Byte;
    HidCode: Byte;
  end;
  XINPUT_KEYSTROKE = _XINPUT_KEYSTROKE;
  TXInputKeystroke = _XINPUT_KEYSTROKE;

type
  TUDPServer = class
  private
  IdUDPServer: TIdUDPServer;
  procedure IdUDPServerUDPRead(ASender: TObject;AData: TStream; ABinding: TIdSocketHandle);
  public
  constructor Create; reintroduce;
  destructor Destroy; override;
end;

type TOpenTrackPacket = record
    X: double;
    Y: double;
    Z: double;
    Yaw: double;
    Pitch: double;
    Roll: double;
end;

var
  Yaw, Pitch, Roll: double;
  WheelOn: boolean;
  WheelAngle, MinAngleLT, MaxAngleLT, MinAngleRT, MaxAngleRT: integer;

function DllMain(Inst: LongWord; Reason: DWORD; const Reserved): boolean;
begin
  Result:=true;
end;

function ToLeftStick(Data: double): integer;
begin
  Result:=Round(32767 / WheelAngle * Data);
  if Result < -32767 then Result:=-32767;
  if Result > 32767 then Result:=32767;
end;

function LeftTrigger(Data: double): integer;
begin
  if Data < MinAngleRT then begin
    Result:=Round((255 / (MaxAngleLT - MinAngleLT)) * (Data - MinAngleLT));
    if Result > 255 then Result:=255;
    if Result < 0 then Result:=0;
  end else
    Result:=0;
end;

function RightTrigger(Data: double): integer;
begin
  if Data > MinAngleRT then begin
    Result:=Round((255 / (MaxAngleRT - MinAngleRT)) * (Data - MinAngleRT));
    if Result > 255 then Result:=255;
    if Result < 0 then Result:=0;
  end else
    Result:=0;
end;

function XInputGetState(
    dwUserIndex: DWORD;      //Index of the gamer associated with the device
    out pState: TXInputState //Receives the current state
 ): DWORD; stdcall;
var
  keys: DWORD;
begin
  pState.Gamepad.bRightTrigger:=0;
  pState.Gamepad.bLeftTrigger:=0;
  pState.Gamepad.sThumbLX:=0;
  pState.Gamepad.sThumbLY:=0;
  pState.Gamepad.sThumbRX:=0;
  pState.Gamepad.sThumbRY:=0;
  keys:=0;

  if WheelOn then begin
    pState.Gamepad.sThumbLX:=ToLeftStick(Pitch*-1);
    pState.Gamepad.bRightTrigger:=RightTrigger(Roll);
    pState.Gamepad.bLeftTrigger:=LeftTrigger(Roll);
  end;

  if GetAsyncKeyState(VK_F9) <> 0 then WheelOn:=true;
  if GetAsyncKeyState(VK_F10) <> 0 then begin
    WheelOn:=false;
    Yaw:=0;
    Pitch:=0;
    Roll:=0;
  end;

  pState.dwPacketNumber:=GetTickCount;
  pState.Gamepad.wButtons:=keys;

  if dwUserIndex = 0 then
    Result:=ERROR_SUCCESS
  else
    Result:=ERROR_DEVICE_NOT_CONNECTED;
end;

function XInputSetState(
    dwUserIndex: DWORD;
    const pVibration: TXInputVibration  //The vibration information to send to the controller
 ): DWORD; stdcall;
begin
  if dwUserIndex = 0 then
    Result:=ERROR_SUCCESS
  else
    Result:=ERROR_DEVICE_NOT_CONNECTED;
end;

function XInputGetCapabilities(
    dwUserIndex: DWORD;
    dwFlags: DWORD;                         //Input flags that identify the device type
    out pCapabilities: TXInputCapabilities  //Receives the capabilities
 ): DWORD; stdcall;
begin
  if dwUserIndex = 0 then
    Result:=ERROR_SUCCESS
  else
    Result:=ERROR_DEVICE_NOT_CONNECTED;
end;

procedure XInputEnable(
    enable: BOOL     //Indicates whether xinput is enabled or disabled.
 ); stdcall;
begin

end;

function XInputGetDSoundAudioDeviceGuids(
    dwUserIndex: DWORD;
    out pDSoundRenderGuid: TGUID; //DSound device ID for render
    out pDSoundCaptureGuid: TGUID //DSound device ID for capture
 ): DWORD; stdcall;
begin
  if dwUserIndex = 0 then
    Result:=ERROR_SUCCESS
  else
    Result:=ERROR_DEVICE_NOT_CONNECTED;
end;

function XInputGetBatteryInformation(
    dwUserIndex: DWORD;
    devType: Byte;               //Which device on this user index
    out pBatteryInformation: TXInputBatteryInformation //Contains the level and types of batteries
 ): DWORD; stdcall;
begin
  Result:=BATTERY_TYPE_DISCONNECTED;
end;

function XInputGetKeystroke(
    dwUserIndex: DWORD;
    dwReserved: DWORD;                // Reserved for future use
    var pKeystroke: TXInputKeystroke  //Pointer to an XINPUT_KEYSTROKE structure that receives an input event.
 ): DWORD; stdcall;
begin
  if dwUserIndex = 0 then
    Result:=ERROR_SUCCESS
  else
    Result:=ERROR_DEVICE_NOT_CONNECTED;
end;

function XInputGetStateEx(
    dwUserIndex: DWORD;
    out pState: TXInputState
 ): DWORD; stdcall;
begin
  if dwUserIndex = 0 then
    Result:=ERROR_SUCCESS
  else
    Result:=ERROR_DEVICE_NOT_CONNECTED;
end;

function XInputWaitForGuideButton(
    dwUserIndex: DWORD;
    dwFlags: DWORD;
    const LPVOID
 ): DWORD; stdcall;
begin
  if dwUserIndex = 0 then
    Result:=ERROR_SUCCESS
  else
    Result:=ERROR_DEVICE_NOT_CONNECTED;
end;

function XInputCancelGuideButtonWait(
    dwUserIndex: DWORD               
): DWORD; stdcall;
begin
  if dwUserIndex = 0 then
    Result:=ERROR_SUCCESS
  else
    Result:=ERROR_DEVICE_NOT_CONNECTED;
end;

function XInputPowerOffController(
    dwUserIndex: DWORD
): DWORD; stdcall;
begin
  if dwUserIndex = 0 then
    Result:=ERROR_SUCCESS
  else
    Result:=ERROR_DEVICE_NOT_CONNECTED;
end;

exports
  //XInput 1.3
  DllMain index 1, XInputGetState index 2, XInputSetState index 3, XInputGetCapabilities index 4, XInputEnable index 5,
  XInputGetDSoundAudioDeviceGuids index 6, XInputGetBatteryInformation index 7, XInputGetKeystroke index 8,
  //XInput 1.3 undocumented
  XInputGetStateEx index 100, XInputWaitForGuideButton index 101, XInputCancelGuideButtonWait index 102, XInputPowerOffController index 103;

{ TUDPServer }

constructor TUDPServer.Create;
begin
  idUDPServer:=TIdUDPServer.Create(nil);
  idUDPServer.DefaultPort:=4242;
  idUDPServer.BufferSize:=8192;
  idUDPServer.BroadcastEnabled:=false;
  idUDPServer.OnUDPRead:=IdUDPServerUDPRead;
  IdUDPServer.ThreadedEvent:=true;
  IdUDPServer.Active:=true;
end;

destructor TUDPServer.Destroy;
begin
  IdUDPServer.Active:=false;
  IdUDPServer.Free;
  inherited destroy;
end;

procedure TUDPServer.IdUDPServerUDPRead(ASender: TObject; AData: TStream;
  ABinding: TIdSocketHandle);
var
  Packet: TOpenTrackPacket;
begin
  Adata.Read(Packet, SizeOf(Packet));
  Yaw:=Packet.Yaw;
  Pitch:=Packet.Pitch;
  Roll:=Packet.Roll;
end;

var
  Ini: TIniFile;
begin
  TUDPServer.Create;
  Ini:=TIniFile.Create(ExtractFilePath(ParamStr(0)) + 'WheelSetup.ini');
  WheelAngle:=Ini.ReadInteger('Main', 'WheelAngle', 50);
  MinAngleLT:=Ini.ReadInteger('Main', 'MinAngleLT', -15);
  MaxAngleLT:=Ini.ReadInteger('Main', 'MaxAngleLT', -25);
  MinAngleRT:=Ini.ReadInteger('Main', 'MinAngleRT', 5);
  MaxAngleRT:=Ini.ReadInteger('Main', 'MaxAngleRT', 20);
  Ini.Free;
end.
