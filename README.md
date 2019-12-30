# homebrew-liquidctl

Homebrew/linuxbrew tap for [liquidctl](https://github.com/jonasmalacofilho/liquidctl).

[![Status of homebrew/linuxbrew tests](https://github.com/jonasmalacofilho/homebrew-liquidctl/workflows/macOS%20%26%20linux/badge.svg)](https://github.com/jonasmalacofilho/homebrew-liquidctl/commits/master)

## Installing

```
$ brew tap jonasmalacofilho/liquidctl
$ brew install jonasmalacofilho/liquidctl/liquidctl [--HEAD | --devel]
```

If you already have `liquidctl` installed from homebrew-core, you must first uninstall it:

```
$ brew uninstall liquidctl
```

## Upgrading

To upgrade, make sure to use the complete name:

```
$ brew update && brew upgrade jonasmalacofilho/liquidctl/liquidctl
```

If you installed the formula with `--HEAD`, pass `--fetch-HEAD` when upgrading:

```
$ brew update && brew upgrade jonasmalacofilho/liquidctl/liquidctl --force-HEAD
```

## Uninstalling

To uninstall use the complete name:

```
$ brew uninstall jonasmalacofilho/liquidctl/liquidctl
```

After uninstalling, it is possible to revert back to the formula from homebrew-core:

```
$ brew install liquidctl
```
