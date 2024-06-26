# Gosearch

> Gosearch is a zsh widget that lists packages when you are trying to work with `go get`. See [Description](#description).

![Gosearch Wallpaper](./assets/wallpaper.png)

<div align="center">
<span style="font-size: x-large; font-weight: bold;">Image is from <a href="https://github.com/egonelbre/gophers">gophers</a></span>
</div>
<br />

## Description

Imagine you started a new go project and want to add some packages you have already know the name but don't know the actual address of it. Packages like gin, fiber, testify, json, uuid and ... . This script does excatly that. It searchs for the packages by their name without exiting the terminal and opening the browser.

![Gosearch gif](./assets/gosearch.gif)


## Installation

```bash
curl -sSfL https://raw.githubusercontent.com/itzloop/gosearch/main/install.sh | bash
```

## Usage
Searching for go packages in the terminal
```bash
$ go get <query><Tab>
$ go get require<Tab>
$ go get misrua<Tab>
```

Currently, symbols aren't supported, so these **WILL NOT** work
```bash
# These WILL NOT work
$ go get sql.Conn<Tab>
$ go get pgx.Conn<Tab>
```
Depending on where you live, you might need to setup a proxy

## Debugging

There is the env, `GOSEARCH_DEBUG_FILE`, by setting this in the shell you are working debug logs will be written to that file.

```
$ export GOSEARCH_DEBUG_FILE=/path/to/some/file
$ go get http<Tab>
# logs will be written to '/path/to/some/file'
```

## Limitation

1. Currently symbols aren't supported, so these **WILL NOT** work
2. Depending on where you live, you might need to setup a proxy
3. It's only for zsh, so if you use another shell and like this project, submit an issue or even better a PR!

## Contributions

This project is only for my needs, so it's pretty limited. If you have another usecase that is not covered, feel free to submit an issue or a PR.
