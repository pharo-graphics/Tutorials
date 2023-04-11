"
I represent a subcollection of a `GCGame` grid slots.

I provide an enumeration API to slide tiles on the slots.
"
Class {
	#name : #GCGridLine,
	#superclass : #Array,
	#type : #variable,
	#category : #'Bloc-GridCombineGame'
}

{ #category : #enumerating }
GCGridLine >> slideTiles: isToEnd movesDo: moveBlock combinesDo: combineBlock [

	isToEnd
		ifTrue: [
			self slideTilesToEndMovesDo: moveBlock combinesDo: combineBlock ]
		ifFalse: [
			self slideTilesToStartMovesDo: moveBlock combinesDo: combineBlock ]
]

{ #category : #enumerating }
GCGridLine >> slideTilesToEndMovesDo: moveBlock combinesDo: combineBlock [ 

	self reversed
		slideTilesToStartMovesDo: [ :tile :index |
			moveBlock value: tile value: (1 + self size - index) ]
		combinesDo: [ :tile1 :tile2 :index |
			combineBlock value: tile1 value: tile2 value: (1 + self size - index) ]
]

{ #category : #enumerating }
GCGridLine >> slideTilesToStartMovesDo: moveBlock combinesDo: combineBlock [

	| emptySlotIndex combineCandidate combineCandidateIndex |
	emptySlotIndex := nil.
	combineCandidate := nil.
	combineCandidateIndex := nil.

	self withIndexDo: [ :each :index |
		each
			ifNil: [
				"This slot is empty"
				emptySlotIndex ifNil: [
					"This slot is empty and can receive a tile"
					emptySlotIndex := index ] ]
			ifNotNil: [
				"This slot has a tile"
				(combineCandidate notNil and: [ combineCandidate content = each content ])
					ifTrue: [
						"This slot has a tile that matches a precedent tile"
						| targetIndex |
						targetIndex := (emptySlotIndex isNotNil and: [
							emptySlotIndex < combineCandidateIndex ])
								ifTrue: [ emptySlotIndex ]
								ifFalse:  [ combineCandidateIndex ].

						combineBlock value: combineCandidate value: each value: targetIndex.
						emptySlotIndex := targetIndex + 1.
						"A combined tile can't match again in the same slide"
						combineCandidate := nil.
						combineCandidateIndex := nil ]
					ifFalse: [
						"This slot has a tile that doesn't match with candidate tile, and
						it becomes the new candidate to combine."
						combineCandidate := each.

						emptySlotIndex
							ifNotNil: [ 
								"There is room to move."
								moveBlock value: each value: emptySlotIndex.
								combineCandidateIndex := emptySlotIndex.
								emptySlotIndex := nil ]
							ifNil: [
								combineCandidateIndex := index ]
					] ] ]
]
