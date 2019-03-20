# How to change open files limit and max processes limit on macOS

## Mac OS X

### To check the current limits on your Mac OS X system, run:
```shell
$ launchctl limit | grep max
	maxproc     266            532
	maxfiles    256            unlimited
```
I want to increase them to 65000.

The last two columns are the soft and hard limits, respectively.

### Adjusting open files limit and max processes limit in Sierra

Creating two configuration files,
1) `/Library/LaunchDaemons/limit.maxfiles.plist`
2) `/Library/LaunchDaemons/limit.maxproc.plist`
which contains the following XML configuration:

1)
```shell
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
  <plist version="1.0">
    <dict>
      <key>Label</key>
        <string>limit.maxfiles</string>
      <key>ProgramArguments</key>
        <array>
          <string>launchctl</string>
          <string>limit</string>
          <string>maxfiles</string>
          <string>65000</string>
          <string>65000</string>
        </array>
      <key>RunAtLoad</key>
        <true/>
      <key>ServiceIPC</key>
        <false/>
    </dict>
  </plist>
```
  
2)
```shell
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple/DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
  <plist version="1.0">
    <dict>
      <key>Label</key>
        <string>limit.maxproc</string>
      <key>ProgramArguments</key>
        <array>
          <string>launchctl</string>
          <string>limit</string>
          <string>maxproc</string>
          <string>65000</string>
          <string>65000</string>
        </array>
      <key>RunAtLoad</key>
        <true />
      <key>ServiceIPC</key>
        <false />
    </dict>
  </plist>
```

After creating the files, you can launch theses commands :

```shell
$ sudo launchctl load -w /Library/LaunchDaemons/limit.maxfiles.plist
$ sudo launchctl load -w /Library/LaunchDaemons/limit.maxproc.plist
```
And then check the current limits

```shell
$ launchctl limit | grep max
	maxproc     532            532
	maxfiles    65000          65000
```

Although maxfiles has been set to 65000, maxproc has only doubled to 532.
