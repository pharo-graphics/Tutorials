actions
completeStep

	self chosenCards 
		do: [ :aCard | aCard disappear ];
		removeAll.