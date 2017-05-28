testing
shouldCompleteStep
	^ self chosenCards size = self matchesCount and: [ 
		self chosenCardMatch ]