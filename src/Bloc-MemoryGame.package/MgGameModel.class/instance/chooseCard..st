actions
chooseCard: aCard
	(self chosenCards includes: aCard) 
		ifTrue: [ ^ self ].
	self chosenCards add: aCard.
	aCard flip.
	self stepCompleted ifTrue: [
		^ self completeStep ].
	self stepOverflow ifTrue: [
		self resetStep ]