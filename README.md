# Tutorials
I contain bloc/brick tutorials and demo related materials that go far beyond simple bloc/brick examples

# Installation

In [Pharo 6.0](http://files.pharo.org/image/60/60493.zip) with [Sources V60](http://files.pharo.org/sources/PharoV60.sources) and **stable** vm:

```smalltalk
Metacello new
    baseline: 'Bloc';
    repository: 'github://pharo-graphics/Bloc/src';
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
  
VMs:
- [Windows Stable](http://files.pharo.org/vm/pharo-spur32/win/stable-20170503.zip)
- [Mac](http://files.pharo.org/vm/pharo-spur32/mac/stable-20170503.zip)
- Linux: download the right one from [here](http://files.pharo.org/vm/pharo-spur32/linux/)
