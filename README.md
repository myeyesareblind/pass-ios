Pass for iOS
============

View your [password-store][] passwords on your iDevice.

[password-store]: http://zx2c4.com/projects/password-store

Dependencies
------------

The following packages are available from Cydia:

  * gnupg  (required)
  * git    (optional)

Setup
-----

### Copy your `pass` password-store to /var/mobile/.password-store

The preferred way to do this is to store your passwords in a `git` repository, which you can then clone. Alternatively, you can use scp, iFile or any other method to transfer the passwords over.

### Set up your gpg key

1) Export your *private* key from your desktop/laptop/etc:

    (desktop)$ gpg --export-secret-key --armor ${KEY_ID} > ${KEY_ID}.asc

2) Copy this file to your device

3) On the device, import the key

    (device)$ gpg --import ${KEY_ID}.asc

4) Delete the key file

5) Test decrypting one of your passwords

    (device)$ gpg -d ~/.password-store/ENTRY.gpg

### Using the Pass App

After launching the app, you will be presented with a listing of files and directories in `~/.password-store`. Files starting with '.' are hidden, and `.gpg` extensions are stripped.

Clicking on a directory will show its contents.

Clicking on a password file will show a screen with the password file details (name and \*'d out password).

Clicking on the name or password box will copy the respective contents to the pasteboard (clipboard). Since the password is encrypted, you will have to enter you passphrase before it can be copied.

Todo
----

* Simplify initial setup

  - enter git repo url to clone
  - paste gpg key

* Better details screen
  - allow viewing multi-line content
  - auto-decrypt if passphrase stored?

* Allow storing gpg key passphrase in iOS Keychain
  - this is partially done. passphrase is stored until app exits for now

* Reset pasteboard contents after 45 s when copying password.

* Configurable Settings

  - base directory location (other than /var/mobile/.password-store)
  - whether to store passphrase in keychain
  - passphrase storage duration (X minutes or forever)
  - pasteboard reset time

* Password editing / adding
  - auto-commit ala pass bash script

* trigger 'git pull' from app (also 'git push' after editing is implemented)
* dropbox support?
