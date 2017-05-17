mouse handlers
memoryGame: aMemoryGame
	
	self layout columnCount: aMemoryGame gridSize.
	
	aMemoryGame availableCards do: [ :aCard |
		self addChild: (MgRawCardElement new
			card: aCard;
			addEventHandler: (MgCardEventListener new
				memoryGame: aMemoryGame)) ].