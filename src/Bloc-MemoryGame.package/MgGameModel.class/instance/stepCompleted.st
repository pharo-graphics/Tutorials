testing
stepCompleted
	^ self chosenCards size = self matchesCount and: [ 
		self chosenCardMatch ]