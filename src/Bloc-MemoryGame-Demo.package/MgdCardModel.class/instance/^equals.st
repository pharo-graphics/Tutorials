comparing
= anObject
	self == anObject ifTrue: [ ^ true ].
	self class = anObject class ifFalse: [ ^ false ].
	^ symbol = anObject symbol
		and: [ flipped = anObject flipped ]