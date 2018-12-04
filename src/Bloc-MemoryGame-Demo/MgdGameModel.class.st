"
I am a memory game model
"
Class {
	#name : #MgdGameModel,
	#superclass : #Object,
	#instVars : [
		'availableCards',
		'chosenCards'
	],
	#category : 'Bloc-MemoryGame-Demo-Model'
}

{ #category : #factory }
MgdGameModel class >> chinese [
	^ self new initializeForSymbols: '为从公家里地个时'
]

{ #category : #factory }
MgdGameModel class >> emoji [
	^ self new initializeForSymbols: '💰🏡🎅🍪🍕🚀😸🙈'
]

{ #category : #factory }
MgdGameModel class >> numbers [
	^ self new initializeForSymbols: '12345678'
]

{ #category : #adding }
MgdGameModel >> addCard: aCard [
	"Add card to the list of available cards"
	self
		assert: [ availableCards size <= self cardsCount ]
		description: [ 'Amount of cards must not exceed grid size limit' ].

	availableCards add: aCard
]

{ #category : #accessing }
MgdGameModel >> availableCards [
	^ availableCards
]

{ #category : #accessing }
MgdGameModel >> cardsCount [
	"Return how many cards there should be depending on grid size"

	^ self gridSize * self gridSize
]

{ #category : #actions }
MgdGameModel >> chooseCard: aCard [
	(self chosenCards includes: aCard) 
		ifTrue: [ ^ self ].
	self chosenCards add: aCard.
	aCard flip.
	self shouldCompleteStep
		ifTrue: [ ^ self completeStep ].
	self shouldResetStep
		ifTrue: [ self resetStep ]
]

{ #category : #testing }
MgdGameModel >> chosenCardMatch [
	| firstCard |
	firstCard := self chosenCards first.
	^ self chosenCards allSatisfy: [ :aCard | 
		aCard isFlipped and: [ firstCard symbol = aCard symbol ] ]
]

{ #category : #accessing }
MgdGameModel >> chosenCards [
	^ chosenCards
]

{ #category : #actions }
MgdGameModel >> completeStep [
	self chosenCards 
		do: [ :aCard | aCard disappear ];
		removeAll.
]

{ #category : #accessing }
MgdGameModel >> gridSize [
	"Return grid size, total amount of card is gridSize^2"

	^ 4
]

{ #category : #initialization }
MgdGameModel >> initialize [
	super initialize.
	
	availableCards := OrderedCollection new.
	chosenCards := OrderedCollection new
]

{ #category : #initialization }
MgdGameModel >> initializeForSymbols: aCollectionOfCharacters [
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
					MgdCardModel new symbol: aSymbol ] ] ) flattened shuffled asOrderedCollection
]

{ #category : #accessing }
MgdGameModel >> matchesCount [
	"How many chosen cards should match in order to disappear"

	^ 2
]

{ #category : #actions }
MgdGameModel >> resetStep [
	| lastCard |

	lastCard := self chosenCards  last.

	self chosenCards 
		allButLastDo: [ :aCard | aCard flip ];
		removeAll;
		add: lastCard
]

{ #category : #testing }
MgdGameModel >> shouldCompleteStep [
	"Return true if current step should be completed, false otherwise.
	According to game rules step is done when all chosen cards match
	and their amount corresponds to a specific number (#matchesCount)"
	<return: #Boolean>
	
	^ self chosenCards size = self matchesCount
		and: [ self chosenCardMatch ]
]

{ #category : #testing }
MgdGameModel >> shouldResetStep [ 
	^ self chosenCards size > self matchesCount
]
