# How to change open file limit and max processes limit on OS X and macOS

## Mac OS X

### To check the current limits on your Mac OS X system, run:
```shell
$ launchctl limit
	maxproc     266            532
	maxfiles    256            unlimited
```

The last two columns are the soft and hard limits, respectively.

### Adjusting open file limit and max processes limit in Sierra
