examples
cardsFor: aMgGameModel
	<gtExample>
	<dependsOn: #basicGame>
	
	^ ((1 to: aMgGameModel cardsCount / aMgGameModel matchesCount) collect: [ :index |
		| symbols |
		symbols := '12345678'.
		(1 to: aMgGameModel matchesCount)
			collect: [ :i | MgCardModel new symbol: (symbols at: index) ]
	]) flattened shuffled