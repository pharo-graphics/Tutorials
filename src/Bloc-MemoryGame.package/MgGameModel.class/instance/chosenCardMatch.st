testing
chosenCardMatch
	| firstCard |
	firstCard := self chosenCards first.
	^ self chosenCards allSatisfy: [ :aCard | 
		aCard isFlipped and: [ firstCard symbol = aCard symbol ] ]