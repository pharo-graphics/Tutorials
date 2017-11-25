# Tutorials
I contain bloc/brick tutorials and demo related materials that go far beyond simple bloc/brick examples

# Memory Game booklet
Consider going through a detailed steb by step implementation described in a booklet:<br>
[Bloc - Memory Game.pdf](http://files.pharo.org/books-pdfs/booklet-Bloc/2017-11-09-memorygame.pdf)

# Installation

In [Pharo 6.1](https://pharo.org/download):

```smalltalk
Metacello new
    baseline: 'Bloc';
    repository: 'github://pharo-graphics/Bloc:pharo6.1/src';
    load: #core.
```    

```smalltalk
Metacello new
    baseline: 'BlocTutorials';
    repository: 'github://pharo-graphics/Tutorials/src';
    load
```

Package:
  **Bloc-MemoryGame-Demo**

## Direct links to Pharo 6.1

- [Windows](http://files.pharo.org/platform/Pharo6.1-win.zip)
- [Mac](http://files.pharo.org/platform/Pharo6.1-mac.zip)
- [Linux](https://pharo.org/gnu-linux-installation)
