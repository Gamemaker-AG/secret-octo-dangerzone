default: run

clean:
	@[[ ! -e game.love ]] || rm game.love
	@[[ ! -e pkg ]] || rm -r pkg        

build: clean
	@zip -r -0 game.love data/*
	@cd src/ && zip -r ../game.love *

run: build
	@love game.love

package-windows:
	@lib/package.sh windows

package-linux:
	@lib/package.sh linux

package-mac:
	@lib/package.sh osx

package: package-linux package-windows package-mac
