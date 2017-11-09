testing
shouldCompleteStep
	"Return true if current step should be completed, false otherwise.
	According to game rules step is done when all chosen cards match
	and their amount corresponds to a specific number (#matchesCount)"
	<return: #Boolean>
	
	^ self chosenCards size = self matchesCount
		and: [ self chosenCardMatch ]