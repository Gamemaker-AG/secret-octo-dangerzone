.PHONY: default clean build run lib getwindowlib getmaclib package-linux package-windows package-mac package

default: build run

buildclean:
	@[[ ! -e seocda.love ]] || rm seocda.love

clean:
	@[[ ! -e seocda.love ]] || rm seocda.love
	@[[ ! -e pkg ]] || rm -r pkg
	@[[ ! -e lib ]] || rm -r lib
	@[[ ! -e temp ]] || rm -r temp

build: buildclean
	@zip -q -r -0 seocda.love data/*
	@cd src/ && zip -q -r ../seocda.love *

build-fast:
	@zip -q -r -0 seocda.love data/*
	@./script/fast.sh
	@cd temp/ && zip -q -r ../seocda.love *

fast: build-fast
	@love seocda.love

run:
	@love seocda.love

setup:
	git submodule update --init --recursive

package-linux: build
	@./script/download.sh linux
	@./script/package.sh linux

package-windows: build
	@./script/download.sh windows
	@./script/package.sh windows

package-mac: build
	@./script/download.sh osx
	@./script/package.sh osx

subupdate:
	git submodule foreach git pull origin master

package: build package-linux package-windows package-mac
