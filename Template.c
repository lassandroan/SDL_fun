#include <SDL2/SDL.h>

#include "../../Source/SDL_fun.c"

int main(void)
{
	if (SDL_Init(SDL_INIT_VIDEO) != 0)
		goto err_sdl;

	SDL_Window* const window = SDL_CreateWindow(
		FUN_EXAMPLE_NAME,
		SDL_WINDOWPOS_UNDEFINED, SDL_WINDOWPOS_UNDEFINED,
		512, 512,
		SDL_WINDOW_SHOWN
	);

	if (!window)
		goto err_window;

	SDL_RaiseWindow(window);

	while (1)
	{
		if (SDL_QuitRequested())
			break;
	}

err_window:
	SDL_DestroyWindow(window);

err_sdl:
	SDL_Quit();
}
