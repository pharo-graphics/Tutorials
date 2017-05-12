mouse handlers
memoryGame: aMemoryGame
	
	aMemoryGame availableCards do: [ :aCard |
		self addChild: (MgRawCardElement new
			card: aCard;
			addEventHandler: (MgCardEventListener new
				memoryGame: aMemoryGame)) ].