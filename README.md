# Memory Game Tutorial

I contain a Memory Game based in [Bloc](https://github.com/pharo-graphics/Bloc).

The present code is the result of the old tutorial in this booklet:<br>
[Bloc - Memory Game.pdf](http://files.pharo.org/books-pdfs/booklet-Bloc/2017-11-09-memorygame.pdf), with some little name adaptations.
The source code for such booklet can be found [here](https://github.com/SquareBracketAssociates/Booklet-BuildingMemoryGameWithBloc).

# Installation

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
