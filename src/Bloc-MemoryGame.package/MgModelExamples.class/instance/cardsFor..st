examples
cardsFor: aMgGameModel
	<gtExample>
	<dependsOn: #basicGame>
	
	^ ((1 to: aMgGameModel cardsCount / aMgGameModel matchesCount) collect: [ :index |
		| symbols |
		symbols := '为从公家里地个时来心'.
		(1 to: aMgGameModel matchesCount)
			collect: [ :i | MgCardModel new symbol: (symbols at: index) ]
	]) flattened shuffled