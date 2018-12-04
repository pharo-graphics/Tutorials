"
I am a memory game model
"
Class {
	#name : #MgGameModel,
	#superclass : #Object,
	#instVars : [
		'availableCards',
		'chosenCards'
	],
	#category : 'Bloc-MemoryGame-Model'
}

{ #category : #factory }
MgGameModel class >> chinese [
	^ self new initializeForSymbols: '为从公家里地个时'
]

{ #category : #factory }
MgGameModel class >> emoji [
	^ self new initializeForSymbols: '💰🏡🎅🍪🍕🚀😸🙈'
]

{ #category : #factory }
MgGameModel class >> numbers [
	^ self new initializeForSymbols: '12345678'
]

{ #category : #adding }
MgGameModel >> addCard: aCard [
	"Add card to the list of available cards"
	self
		assert: [ availableCards size < self cardsCount ]
		description: [ 'Amount of cards must not exceed grid size limit' ].

	availableCards add: aCard
]

{ #category : #accessing }
MgGameModel >> availableCards [
	^ availableCards
]

{ #category : #accessing }
MgGameModel >> cardsCount [
	"Return how many cards there should be depending on grid size"

	^ self gridSize * self gridSize
]

{ #category : #actions }
MgGameModel >> chooseCard: aCard [
	(self chosenCards includes: aCard) 
		ifTrue: [ ^ self ].
	self chosenCards add: aCard.
	aCard flip.
	self shouldCompleteStep ifTrue: [
		^ self completeStep ].
	self shouldResetStep ifTrue: [
		self resetStep ]
]

{ #category : #testing }
MgGameModel >> chosenCardMatch [
	| firstCard |
	firstCard := self chosenCards first.
	^ self chosenCards allSatisfy: [ :aCard | 
		aCard isFlipped and: [ firstCard symbol = aCard symbol ] ]
]

{ #category : #accessing }
MgGameModel >> chosenCards [
	^ chosenCards
]

{ #category : #actions }
MgGameModel >> completeStep [
	self chosenCards 
		do: [ :aCard | aCard disappear ];
		removeAll.
]

{ #category : #accessing }
MgGameModel >> gridSize [
	"Return grid size, total amount of card is gridSize^2"

	^ 4
]

{ #category : #initialization }
MgGameModel >> initialize [
	super initialize.
	
	availableCards := OrderedCollection new.
	chosenCards := OrderedCollection new
]

{ #category : #initialization }
MgGameModel >> initializeForSymbols: aCollectionOfCharacters [
	"Initialize game model with the cards that are represented by character symbols taken from a given
	collection of symbols.
	Note, amount of characters must correspond to amount of possible card combinations
	which is in fact = (total card count / how many card to match).
	So, if grid size is 4, then total card count is 4^2 = 16. If player should match 2 cards,
	then collection size must be 16 / 2 = 8"
	self
		assert: [ aCollectionOfCharacters size = (self cardsCount / self matchesCount) ]
		description: [ 'Amount of characters must be equal to possible all combinations' ].

	availableCards := (aCollectionOfCharacters asArray
			collect: [ :aSymbol | 
				(1 to: self matchesCount) collect: [ :i | 
					MgCardModel new symbol: aSymbol ] ] ) flattened shuffled asOrderedCollection
]

{ #category : #accessing }
MgGameModel >> matchesCount [
	"How many chosen cards should match in order to disappear"

	^ 2
]

{ #category : #actions }
MgGameModel >> resetStep [
	|lastCard|
	lastCard := self chosenCards  last.
	self chosenCards 
		allButLastDo: [ :aCard | aCard flip ];
		removeAll;
		add: lastCard
]

{ #category : #testing }
MgGameModel >> shouldCompleteStep [
	^ self chosenCards size = self matchesCount and: [ 
		self chosenCardMatch ]
]

{ #category : #testing }
MgGameModel >> shouldResetStep [ 
	^ self chosenCards size > self matchesCount
]
