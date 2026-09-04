# Deskflow Configuration
This file explains how I have configured Deskflow to support direct device sharing between my laptop (MacOS) and my main workstation (Windows).

## Installation
### Windows
The installation requires the official `.msi` from GitHub and the additional dependencies demanded by this installator described in the README.md of the project.

### MacOS
```
brew tap deskflow/tap
brew trust --cask deskflow/tap/deskflow
brew trust deskflow/tap
brew install deskflow
```

After installing it, it will appear as a simple application. Additional accessibility permissions must be granted. Then the app can be run.

## General functioning
Depending on where the devices are connected, one machine will act as a server and the other as a client. This must be selected when starting the app.
Then, start the server. Once started, select the IP from within the client and connect. In a few seconds both devices should be linked and the KVM should be functioning.

## Additional settings on Windows
Given some shortcuts in my configuration, we must disable in Windows the Win + L (lock session) and Win + H (dictation mode). For the Win + L, disable with Win + R and `regedit`. A simple search in Internet may help this process. For Win + H, use PowerToys (again simple search online).
Moreover, depending on the keyboard, the command and opt keys may be inverted. This is easily configurable from the Deskflow app in the server side. Normally, this implies changing `Super`and `Alt` key bindings.
