#Encore SDL Library
Better name forthcoming.

This library builds upon the SDL2 C library.
It is recomended that you familirase with the working of SDL2.
Nice documentation can be found [here](https://wiki.libsdl.org/FrontPage).

##General warnings
This library is very, very **beta**. SDL2 is not thread safe and how well it
will play together with the Encore scheduler is not known.

###Memory leaks
This library is very likely to leak memory since a lot of *under the hood*
allocation of SDL objects that will not be traced by Encore and no guarantees
can be made, regarding anything in general.

###Driver Issues
It appears as if this, due to some strange driver thing, Encore and SDL
does not play well together on some machines. If you find that programs
using this library segfaults almost instantaneously, run the program in
a debugger. If the segfault always appear inside some low level driver 
routine, you are out of luck.

###Sequential Bottleneck
All drawing is contained in a single active object and will thus cause a
sequential bottleneck. Take note of this since it may cause headaches.

###Need for embedding C code
Unfortunately, as of now the usage of this library, the event handling in
particular, will require the user to do some light embedding of `C` code. This
is both ugly, annoying and unsafe. This will be phased out as Encore gets the
required features. The goal is to make the library completely opaque from the
users perspective.

##Library Architecture
This library consists of two main components.
The `SDL_Main` object which is the core and the `SDL_Event_Handler`, which
contrary to what one might expect, handles the events.

###SDL_Main
The `SDL_Main` object is the heart of the library. Within this object all of 
the native SDL code gets called. Upon initialization of the `SDL_Main` object
the SDL system is initialized and the window is created. After this stage the
`SDL_Main` object will be used for the drawing and the retrieving of events.
To draw things to the window one simply calls one of the many drawing functions
to draw to the buffer. It is first when the `refresh()` method is called
that the rendering plane will be drawn onto the screen.

The two methods `pollEvent` and `waitForEvent` are used for getting events from
the native `SDL_EventQueue`. These two methods takes an argument a `SDL_Event_Handler`
object that actually does something exciting with the event.

###SDL_Event_Handler
The `SDL_Event_Handler` makes the event actually do nice things.
The event handler contains a set of wrapped Vat  objects. Each of these Vats
correspond to a specific type of event. The user adds callbacks to these vats
which are then triggered upon an event of the corresponding type.

Each of the callbacks gets as their argument a reference to the `SDL_Main` object
that triggered the event and a passive object holding the information about the event.

#Documentation

##SDL_main
###init
`init(width : int, height : int) : void`
####Description
The constructor of the `SDL_Main` object.
Initializes the SDL system and creates the window.
####Arguments
| Name | Type |  Description |
|:-----|:----:|:-------------|
| width| int  | The width of the window |
| height | int | The height of the window|

###initFont
`initFont(font_name : String, size: int) : void`
####Description
Initializes a font object for the SDL system.
**NOTE:** Only TTF fonts can be used.
A current limitation of the library is that there can only be one font
loaded at a time. So if one wants to switch fonts one needs to reload
the fonts whenever one switches between fonts.
####Arguments
| Name | Type |  Description |
|:-----|:----:|:-------------|
|font_name| String | The path to the TTF font. |
| size| int | The size of the font on pts. |

###drawText
`drawText(text: String, x : int, y: int, color: ColorRGBA) : void`
####Description
Draws a piece of text into the frame buffer in with the
currently loaded font.
####Arguments
| Name | Type |  Description |
|:-----|:----:|:-------------|
| text | String | The text to be drawn. |
| x | int | The x coordinate of the text. |
| y | int | The y coordinate of the text. |
| color | ColorRGBA | The color of the text |

###refresh
`refresh() : void`
####Description
Flips the frame buffers, essentially drawing everything you wanted
onto the screen.

###pollEvent
`pollEvent(handler: SDL_Event_Handler) : void`
####Description
Checks if an event is present and send the event to the event handler
if such an event is present.
####Arguments
| Name | Type |  Description |
|:-----|:----:|:-------------|
| handler | SDL_Event_Handler | The event handler responsible to deal with the event. |

###waitForEvent
`waitForEvent(handler: SDL_Event_Handler, timeout : int) : void`
####Description
Blocks until an event is available. The timeout parameters is in milliseconds
and if it is set to zero the method will block indefinitely until there
is an event present.

**WARNING:** There is some confusion as to how this method behaves in the case when it
times even though no new event was found. 
####Arguments
| Name | Type |  Description |
|:-----|:----:|:-------------|
| handler | SDL_Event_Handler | The event handler responsible for the event |
| timeout | int | For how long to wait for an event before returning. If set to zero we will block indefinitely|

###drawRectangle
`drawRectangle(rec: Rectangle) :void`
####Description
Draws the outline of an rectangle on the screen.
####Arguments
| Name | Type |  Description |
|:-----|:----:|:-------------|
| rec | Rectangle | The rectangle to be drawn |


###fillRectangle
`fillRectangle(rec: Rectangle) :void`
####Description
Fills an rectangle on the screen.
####Arguments
| Name | Type |  Description |
|:-----|:----:|:-------------|
| rec | Rectangle | The rectangle to be drawn |

###setRendererColor
`setRenderColor(c: ColorRGBA) : void`
####Description
Sets the color for the renderer.
This does not affect the color for fonts and images.
####Arguments
| Name | Type |  Description |
|:-----|:----:|:-------------|
| c    | ColorRGBA | The color to be set |

###drawImage
`drawImage(image_path : String, x : int, y : int, x_scale : real, y_scale : real): void`
####Description
Draws an image onto the screen.
####Arguments
| Name | Type |  Description |
|:-----|:----:|:-------------|
| image_path | String | File path to the image |
| x | int | The upper left x coordinate of the image |
| y | int | The upper left y coordinate of the image |
| x_scale | real | The horizontal scaling factor of the image |
| y_scale | real | The vertical scaling factor of the image. |

###drawLine
`drawLine(p1: Point2D, p2: Point2D) : void`
####Description
Draws a line between the two points
####Arguments
| Name | Type |  Description |
|:-----|:----:|:-------------|
| p1 | Point2D | The starting point of the line |
| p2 | Point2D | The ending point of the line |

###clearAll
`clearAll() : void`
####Description
Blanks the entire frame buffer

###fillAll
`fillAll() : void`
####Description
Fills the entire frame buffer with the selected color.

