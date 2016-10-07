serious: src/serious.enc src/SDL_Main.enc src/Primitives.enc src/SDL_Types.enc src/Vat.enc
	encorec $^ -c -o ./serious -F "-lSDL2 -lSDL2_ttf -lSDL2_image -ggdb" -I src/

sdl: src/SDL_Main.enc src/Primitives.enc src/SDL_Types.enc src/Vat.enc
	encorec $^ -c -o ./test -F "-lSDL2 -lSDL2_ttf -lSDL2_image -ggdb" -I src/

