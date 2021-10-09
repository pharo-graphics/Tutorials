# Memory Game Tutorial

[![License](https://img.shields.io/github/license/pharo-graphics/Tutorials.svg)](./LICENSE)
[![Test](https://github.com/pharo-graphics/Tutorials/actions/workflows/test.yml/badge.svg)](https://github.com/pharo-graphics/Tutorials/actions/workflows/test.yml)

I contain a Memory Game based in [Bloc](https://github.com/pharo-graphics/Bloc). 

The present code is the result of following the Bloc tutorial in [this booklet](https://files.pharo.org/books-pdfs/booklet-Bloc/2017-11-09-memorygame.pdf), with some little name adaptations.
The source code for such booklet can be found [here](https://github.com/SquareBracketAssociates/Booklet-BuildingMemoryGameWithBloc).


![Window](OSWindow.png)


## Installation

In [Pharo 9.0](https://pharo.org/download):

```smalltalk
Metacello new
    baseline: 'Memory';
    repository: 'github://pharo-graphics/Tutorials/src';
    onConflictUseLoaded;
    load
```

It will load the package `Bloc-Memory` located in this repository, and Bloc as a dependency.
The `onConflictUseLoaded` avoid a conflict in thte case you already have Bloc loaded in the image.


## Play

Evaluate this code:

```smalltalk
"Create the game model and the Bloc element."
aGameElement := MGGameElement new
	memoryGame: MGGame withNumbers;
	yourself.

"The space represents the window"
space := BlSpace new.
space addChild: aGameElement. 

"Calculate the extent of the game board for the first time, to set it to the window."
space pulse.
space extent: aGameElement extent.

"Show the window"
space show. 
```

By default, a Morphic window will popup. It is also possible to open a OS "external" window. To do it, open "System Settings > Appearance > Bloc" and select "OSWindow - SDL2" in "Preferable Host".


## License

This code is licensed under the [MIT license](./LICENSE).
