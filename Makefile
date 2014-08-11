default: run

clean:
	@[[ ! -e ShapeRape.love ]] || rm ShapeRape.love
	@[[ ! -e pkg ]] || rm -r pkg        

build: clean
	@zip -r -0 ShapeRape.love data/*
	@cd src/ && zip -r ../ShapeRape.love *

run: build
	@love ShapeRape.love

package-windows:
	@lib/package.sh windows

package-linux:
	@lib/package.sh linux

package-mac:
	@lib/package.sh osx

package: package-linux package-windows package-mac
