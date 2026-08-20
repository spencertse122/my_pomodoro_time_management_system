#define MyAppName "Focus Flow"
#define MyAppPublisher "Focus Flow"
#ifndef MyAppVersion
  #define MyAppVersion "2.0.0"
#endif
#ifndef BuildRoot
  #define BuildRoot "..\\..\\build\\windows\\x64\\runner\\Release"
#endif

[Setup]
AppId={{7D8322EB-1F3B-498C-AE00-8D36BB9F247A}
AppName={#MyAppName}
AppVersion={#MyAppVersion}
AppPublisher={#MyAppPublisher}
DefaultDirName={autopf}\\Focus Flow
DefaultGroupName=Focus Flow
DisableProgramGroupPage=yes
PrivilegesRequired=lowest
ArchitecturesAllowed=x64compatible
ArchitecturesInstallIn64BitMode=x64compatible
MinVersion=10.0.22000
OutputDir=..\\..\\dist
OutputBaseFilename=Focus-Flow-{#MyAppVersion}-windows-x64-setup
Compression=lzma2/max
SolidCompression=yes
WizardStyle=modern
UninstallDisplayIcon={app}\\FocusFlow.exe
SetupIconFile=..\\..\\windows\\runner\\resources\\app_icon.ico
SignTool=FocusFlowSignTool
SignedUninstaller=yes

[Languages]
Name: "english"; MessagesFile: "compiler:Default.isl"

[Tasks]
Name: "desktopicon"; Description: "Create a desktop shortcut"; GroupDescription: "Additional shortcuts:"

[Files]
Source: "{#BuildRoot}\\*"; DestDir: "{app}"; Flags: ignoreversion recursesubdirs createallsubdirs

[Icons]
Name: "{group}\\Focus Flow"; Filename: "{app}\\FocusFlow.exe"
Name: "{autodesktop}\\Focus Flow"; Filename: "{app}\\FocusFlow.exe"; Tasks: desktopicon

[Run]
Filename: "{app}\\FocusFlow.exe"; Description: "Launch Focus Flow"; Flags: nowait postinstall skipifsilent
