actions
resetStep
	|lastCard|
	lastCard := self chosenCards  last.
	self chosenCards 
		allButLastDo: [ :aCard | aCard flip ];
		removeAll;
		add: lastCard