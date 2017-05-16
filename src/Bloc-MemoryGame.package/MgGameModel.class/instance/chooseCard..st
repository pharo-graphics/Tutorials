actions
chooseCard: aMgCard
	| allEqual |
	self chosenCards add: aMgCard.
	aMgCard flip.
	
	allEqual := self chosenCards allSatisfy: [ :each | each symbol = self chosenCards first symbol ].

	(self chosenCards size = self matchesCount and: [ allEqual ])
		ifTrue: [
			self chosenCards do: [ :each | each disappear ].
			self chosenCards removeAll.
			^ self ].
	
	(self chosenCards size > self matchesCount)
		ifTrue: [ 
			self chosenCards allButLastDo: [ :each | each flip ].
			self chosenCards removeAll.
			self chosenCards add: aMgCard ]