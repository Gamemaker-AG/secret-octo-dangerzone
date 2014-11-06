.PHONY: default clean build run lib getwindowlib getmaclib package-linux package-windows package-mac package

default: build

clean:
	@[[ ! -e seocda.love ]] || rm seocda.love
	@[[ ! -e pkg ]] || rm -r pkg
	@[[ ! -e lib ]] || rm -r lib
	@[[ ! -e temp ]] || rm -r temp

build: clean
	@zip -r -0 seocda.love data/*
	@cd src/ && zip -r ../seocda.love *

run: build
	@love seocda.love

package-linux:
	./script/download.sh linux
	@./script/package.sh linux

package-windows:
	./script/download.sh windows
	@./script/package.sh windows

package-mac:
	./script/download.sh osx
	@./script/package.sh osx

package: package-linux package-windows package-mac
