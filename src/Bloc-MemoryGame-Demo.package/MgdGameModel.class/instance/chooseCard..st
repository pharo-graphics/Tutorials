actions
chooseCard: aMgCard
	| allEqual |

	(self chosenCards includes: aMgCard)
		ifTrue: [ ^ self ].
		
	(self availableCards includes: aMgCard)
		ifFalse: [ ^ self ].

	self chosenCards add: aMgCard.
	aMgCard flipped: true.

	allEqual := self chosenCards allSatisfy: [ :each | each = self chosenCards first ].

	(self chosenCards size = self matchesCount and: [ allEqual ])
		ifTrue: [
			self availableCards removeAll: self chosenCards.
			self chosenCards do: [ :each | each disappear ].
			self chosenCards removeAll.
			^ self ].
	
	(self chosenCards size > self matchesCount)
		ifTrue: [ 
			self chosenCards allButLastDo: [ :each | each flip ].
			self chosenCards removeAll.
			self chosenCards add: aMgCard ]