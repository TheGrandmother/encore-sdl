serious: src/serious.enc src/SDL_Main.enc src/Primitives.enc src/SDL_Types.enc
	encorec $^ -c -o ./serious -F "-lSDL2 -lSDL2_ttf -lSDL2_image -ggdb" -I src/:/home/grandmother/git/vat-is-love/src/

sdl: src/SDL_Main.enc src/Primitives.enc src/SDL_Types.enc
	encorec $^ -c -o ./test -F "-lSDL2 -lSDL2_ttf -lSDL2_image -ggdb" -I src/:/home/grandmother/git/vat-is-love/src/

test: src/test.enc
	encorec src/test.enc -c -o ./test -F "-lSDL2 -lSDL2_ttf -lSDL2_image -ggdb"
