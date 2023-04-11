"
A GCGameTest is a test class for testing the behavior of GCGame
"
Class {
	#name : #GCGameTest,
	#superclass : #TestCase,
	#category : #'Bloc-GridCombineGame-Tests'
}

{ #category : #'instance creation' }
GCGameTest >> newTestingGame [

	^ GCGame
		gridExtent: 4@4
		variant:
			(GCMockVariant new
				isSuccessBlock: [:n | n = 16 ];
				yourself)
]

{ #category : #tests }
GCGameTest >> test01InitialSetup [

	| aGame |
	aGame := self newTestingGame.
	aGame insertNewTileAt: 3@4.
	
	self deny: aGame isFinished.
	self deny: aGame isFull.
	self
		assert: aGame availablePositions size
		equals: aGame gridExtent x * aGame gridExtent y - 1.
	self assert: aGame tiles size equals: 1.
	self
		assert: aGame tiles first position
		equals: 3@4
]

{ #category : #tests }
GCGameTest >> test02aSlideUp [

	| aGame |
	aGame := self newTestingGame.
	aGame insertNewTileAt: 1@1.
	aGame insertNewTileAt: 2@2.
	aGame slideUp.
	self assert: aGame tiles size equals: 2.
	self
		assert: (aGame tiles collect: #position as: Array)
		equals: { 1@1. 2@1 }
]

{ #category : #tests }
GCGameTest >> test02bSlideDown [

	| aGame |
	aGame := self newTestingGame.
	aGame insertNewTileAt: 1@1.
	aGame insertNewTileAt: 2@2.
	aGame slideDown.
	self assert: aGame tiles size equals: 2.
	self
		assert: (aGame tiles collect: #position as: Array)
		equals: { 1@4. 2@4 }
]

{ #category : #tests }
GCGameTest >> test02cSlideRight [

	| aGame |
	aGame := self newTestingGame.
	aGame insertNewTileAt: 1@1.
	aGame insertNewTileAt: 2@2.
	aGame slideRight.
	self assert: aGame tiles size equals: 2.
	self
		assert: (aGame tiles collect: #position as: Array)
		equals: { 4@1. 4@2 }
]

{ #category : #tests }
GCGameTest >> test02dSlideLeft [

	| aGame |
	aGame := self newTestingGame.
	aGame insertNewTileAt: 1@1.
	aGame insertNewTileAt: 2@2.
	aGame slideLeft.
	self assert: aGame tiles size equals: 2.
	self
		assert: (aGame tiles collect: #position as: Array)
		equals: { 1@1. 1@2 }
]

{ #category : #tests }
GCGameTest >> test03aCombineUp [

	| aGame |
	aGame := self newTestingGame.
	aGame insertNewTileAt: 1@1.
	aGame insertNewTileAt: 1@4.
	aGame slideUp.
	self assert: aGame tiles size equals: 1.
	self assert: aGame tiles first content equals: 4.
	self assert: aGame tiles first position equals: 1@1
]

{ #category : #tests }
GCGameTest >> test03bCombineDown [

	| aGame |
	aGame := self newTestingGame.
	aGame insertNewTileAt: 1@1.
	aGame insertNewTileAt: 1@4.
	aGame slideDown.
	self assert: aGame tiles size equals: 1.
	self assert: aGame tiles first content equals: 4.
	self assert: aGame tiles first position equals: 1@4
]

{ #category : #tests }
GCGameTest >> test03cCombineRight [

	| aGame |
	aGame := self newTestingGame.
	aGame insertNewTileAt: 1@1.
	aGame insertNewTileAt: 4@1.
	aGame slideRight.
	self assert: aGame tiles size equals: 1.
	self assert: aGame tiles first content equals: 4.
	self assert: aGame tiles first position equals: 4@1
]

{ #category : #tests }
GCGameTest >> test03dCombineLeft [

	| aGame |
	aGame := self newTestingGame.
	aGame insertNewTileAt: 1@1.
	aGame insertNewTileAt: 4@1.
	aGame slideLeft.
	self assert: aGame tiles size equals: 1.
	self assert: aGame tiles first content equals: 4.
	self assert: aGame tiles first position equals: 1@1
]

{ #category : #tests }
GCGameTest >> test04aCombineUp [

	| aGame |
	aGame := self newTestingGame.
	aGame insertNewTileAt: 1@1.
	aGame insertNewTileAt: 1@2.
	aGame insertNewTileAt: 1@3.
	aGame insertNewTileAt: 1@4.
	aGame slideUp.
	self assert: aGame tiles size equals: 2.
	aGame tiles do: [ :each |
		self assert: each content equals: 4 ].
	self
		assert: (aGame tiles collect: #position as: Array)
		equals: { 1@1. 1@2 }
]

{ #category : #tests }
GCGameTest >> test04bCombineDown [

	| aGame |
	aGame := self newTestingGame.
	aGame insertNewTileAt: 1@1.
	aGame insertNewTileAt: 1@2.
	aGame insertNewTileAt: 1@3.
	aGame insertNewTileAt: 1@4.
	aGame slideDown.
	self assert: aGame tiles size equals: 2.
	aGame tiles do: [ :each |
		self assert: each content equals: 4 ].
	self
		assert: (aGame tiles collect: #position as: Array)
		equals: { 1@3. 1@4 }
]

{ #category : #tests }
GCGameTest >> test05aCombineUpTwice [

	| aGame |
	aGame := self newTestingGame.
	aGame insertNewTileAt: 1@1.
	aGame insertNewTileAt: 1@2.
	aGame insertNewTileAt: 1@3.
	aGame insertNewTileAt: 1@4.
	aGame slideUp.
	aGame slideUp.
	self assert: aGame tiles size equals: 1.
	self assert: aGame tiles first content equals: 8.
	self assert: aGame tiles first position equals: 1@1
]

{ #category : #tests }
GCGameTest >> test05bCombineDownTwice [

	| aGame |
	aGame := self newTestingGame.
	aGame insertNewTileAt: 1@1.
	aGame insertNewTileAt: 1@2.
	aGame insertNewTileAt: 1@3.
	aGame insertNewTileAt: 1@4.
	aGame slideDown.
	aGame slideDown.
	self assert: aGame tiles size equals: 1.
	self assert: aGame tiles first content equals: 8.
	self assert: aGame tiles first position equals: 1@4
]

{ #category : #tests }
GCGameTest >> test05cCombineRightTwice [

	| aGame |
	aGame := self newTestingGame.
	aGame insertNewTileAt: 1@1.
	aGame insertNewTileAt: 2@1.
	aGame insertNewTileAt: 3@1.
	aGame insertNewTileAt: 4@1.
	aGame slideRight.
	aGame slideRight.
	self assert: aGame tiles size equals: 1.
	self assert: aGame tiles first content equals: 8.
	self assert: aGame tiles first position equals: 4@1
]

{ #category : #tests }
GCGameTest >> test05dCombineLeftTwice [

	| aGame |
	aGame := self newTestingGame.
	aGame insertNewTileAt: 1@1.
	aGame insertNewTileAt: 2@1.
	aGame insertNewTileAt: 3@1.
	aGame insertNewTileAt: 4@1.
	aGame slideLeft.
	aGame slideLeft.
	self assert: aGame tiles size equals: 1.
	self assert: aGame tiles first content equals: 8.
	self assert: aGame tiles first position equals: 1@1
]

{ #category : #tests }
GCGameTest >> test06aCombineUpDown [

	| aGame |
	aGame := self newTestingGame.
	aGame insertNewTileAt: 1@1.
	aGame insertNewTileAt: 1@2.
	aGame insertNewTileAt: 1@3.
	aGame insertNewTileAt: 1@4.
	aGame slideUp.
	aGame slideDown.
	self assert: aGame tiles size equals: 1.
	self assert: aGame tiles first content equals: 8.
	self assert: aGame tiles first position equals: 1@4
]

{ #category : #tests }
GCGameTest >> test06bCombineRightLeft [

	| aGame |
	aGame := self newTestingGame.
	aGame insertNewTileAt: 1@1.
	aGame insertNewTileAt: 2@1.
	aGame insertNewTileAt: 3@1.
	aGame insertNewTileAt: 4@1.
	aGame slideRight.
	aGame slideLeft.
	self assert: aGame tiles size equals: 1.
	self assert: aGame tiles first content equals: 8.
	self assert: aGame tiles first position equals: 1@1
]

{ #category : #tests }
GCGameTest >> test07CombineTopRightDownLeft [

	| aGame |
	aGame := self newTestingGame.
	aGame
		insertNewTileAt: 1@1;
		slideUp; "2"
		insertNewTileAt: 4@1;
		slideRight; "4"
		insertNewTileAt: 4@4;
		slideDown; "4 2"
		insertNewTileAt: 1@4;
		slideLeft "4 4".
	self assert: aGame tiles size equals: 2.
	self
		assert: (aGame tiles collect: #position as: Array)
		equals: { 1@3. 1@4 }
]

{ #category : #tests }
GCGameTest >> test08Success [

	| aGame |
	aGame := self newTestingGame.

	aGame insertNewTileAt: 1@1.
	aGame insertNewTileAt: 1@2.
	aGame slideDown. "- - - 4"
	aGame insertNewTileAt: 1@1.
	aGame insertNewTileAt: 1@2.
	aGame slideDown. "- - 4 4"
	aGame insertNewTileAt: 1@1.
	aGame insertNewTileAt: 1@2.
	aGame slideDown. "- - 4 8"
	aGame insertNewTileAt: 1@1.
	aGame insertNewTileAt: 1@2.
	aGame slideDown. "- 4 4 8"
	aGame slideDown. "- - 8 8"
	aGame slideDown. "- - - 16"
	self assert: aGame tiles size equals: 1.
	self assert: aGame isFinished.
	self assert: aGame isSuccess.

]

{ #category : #tests }
GCGameTest >> test09Full [

	| aGame |
	aGame := self newTestingGame.

	aGame availablePositions do: [ :each |
		aGame insertNewTileAt: each ].
	
	self assert: aGame isFinished.
	self deny: aGame isSuccess
]

{ #category : #tests }
GCGameTest >> test10ToDo [

	| aGame |
	aGame := self newTestingGame.
	aGame insertNewTileAt: 1@1.
	aGame insertNewTileAt: 2@1.
	aGame insertNewTileAt: 4@1.
	aGame tiles doWithIndex: [ :each :index | each content: 2**index ].
	aGame slideRight.

	self assert: aGame tiles size equals: 3.
	self
		assert: (aGame tiles collect: #position as: Array)
		equals: { 2@1. 3@1. 4@1 }
]
