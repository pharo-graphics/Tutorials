examples
game: aMgGameModel withCards: aCollectionOfCards
	<gtExample>
	<dependsOn: #basicGame>
	<dependsOn: #cardsFor:>
	
	aCollectionOfCards do: [ :aCard | self addCard: aCard to: aMgGameModel ].
	^ aMgGameModel