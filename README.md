# homebrew-liquidctl

_This tap has been deprecated and it is recommended to switch to the formulae in homebrew-core/linuxbrew-core.  See: [Uninstalling](#uninstalling)._

## Installing

_Deprecated._

```
$ brew tap jonasmalacofilho/liquidctl
$ brew install jonasmalacofilho/liquidctl/liquidctl [--HEAD | --devel]
```

If you already have `liquidctl` installed from homebrew-core, you must first uninstall it:

```
$ brew uninstall liquidctl
```

## Upgrading

_Deprecated._

To upgrade, make sure to use the complete name:

```
$ brew update && brew upgrade jonasmalacofilho/liquidctl/liquidctl
```

If you installed the formula with `--HEAD`, pass `--fetch-HEAD` when upgrading:

```
$ brew update && brew upgrade jonasmalacofilho/liquidctl/liquidctl --force-HEAD
```

## Uninstalling

To uninstall use the complete formula name, and then untap:

```
$ brew uninstall jonasmalacofilho/liquidctl/liquidctl
$ brew untap jonasmalacofilho/liquidctl
```

After this it is possible to install the formula from homebrew-core/linuxbrew-core:

```
$ brew install liquidctl
```
