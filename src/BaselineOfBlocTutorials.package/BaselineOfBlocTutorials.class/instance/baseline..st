baselines
baseline: spec
	<baseline>

	spec for: #common do: [		
		spec 
			package: 'Bloc-MemoryGame';
			package: 'Bloc-MemoryGame-Demo'.
		spec 
			group: 'default' with: #('Bloc-MemoryGame' 'Bloc-MemoryGame-Demo') ]