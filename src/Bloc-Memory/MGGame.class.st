"
I am a memory game model
"
Class {
	#name : #MGGame,
	#superclass : #Object,
	#instVars : [
		'availableCards',
		'chosenCards'
	],
	#category : #'Bloc-Memory-Model'
}

{ #category : #factory }
MGGame class >> withChinese [
	^ self new initializeForSymbols: '为从公家里地个时'
]

{ #category : #factory }
MGGame class >> withEmoji [
	^ self new initializeForSymbols: '💰🏡🎅🍪🍕🚀😸🙈'
]

{ #category : #factory }
MGGame class >> withNumbers [
	^ self new initializeForSymbols: '12345678'
]

{ #category : #adding }
MGGame >> addCard: aCard [
	"Add card to the list of available cards"

	availableCards add: aCard
]

{ #category : #accessing }
MGGame >> availableCards [

	^ availableCards
]

{ #category : #accessing }
MGGame >> cardsCount [
	"Return how many cards there should be."

	^ self gridSize * self gridSize
]

{ #category : #actions }
MGGame >> chooseCard: aCard [
	"This is the main logic of the game. 
	The user pick a card, if this is a new one it is added to the chosen ones,
	then flipped. At this point the game check if all the cards have been chosen and 
	if they are good, remove them. 
	Else the cards are flipped back and remove from the chosen list."
	
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
MGGame >> chosenCardMatch [
	"Return whether the chosen cards match."
	"The implementation is handling the fact that we could want to have a game where more than two matches are needed e.g., three cards of the same symbol."
	
	| firstCard |
	firstCard := self chosenCards first.
	^ self chosenCards allSatisfy: [ :aCard | 
		aCard isFlipped and: [ firstCard symbol = aCard symbol ] ]
]

{ #category : #accessing }
MGGame >> chosenCards [
	^ chosenCards
]

{ #category : #actions }
MGGame >> completeStep [
	"The player found the same cards so the step is complete. The cards should be removed from the board."
	
	self chosenCards 
		do: [ :aCard | aCard disappear ];
		removeAll.
]

{ #category : #accessing }
MGGame >> gridSize [
	"Return grid size, total amount of card is gridSize^2"

	^ 4
]

{ #category : #initialization }
MGGame >> initialize [
	super initialize.
	
	availableCards := OrderedCollection new.
	chosenCards := OrderedCollection new
]

{ #category : #initialization }
MGGame >> initializeForSymbols: aCollectionOfCharacters [

	"Initialize game model with the cards that are represented by character symbols taken from a given
	collection of symbols.
	Note, amount of characters must correspond to amount of possible card combinations
	which is in fact = (total card count / how many card to match).
	So, if grid size is 4, then total card count is 4^2 = 16. If player should match 2 cards,
	then collection size must be 16 / 2 = 8"
	
	aCollectionOfCharacters size = (self cardsCount / self matchesCount)
			ifFalse: [ self error: 'Amount of characters must be equal to possible all combinations' ].

	availableCards := (aCollectionOfCharacters asArray
			collect: [ :aSymbol | 
				(1 to: self matchesCount) collect: [ :i | 
					MGCard new symbol: aSymbol ] ] ) flattened shuffled asOrderedCollection
]

{ #category : #accessing }
MGGame >> matchesCount [
	"How many chosen cards should match to disappear"

	^ 2
]

{ #category : #actions }
MGGame >> resetStep [
	""
	
	| lastCard |
	lastCard := self chosenCards last.
	self chosenCards 
		allButLastDo: [ :aCard | aCard flip ];
		removeAll;
		add: lastCard
]

{ #category : #testing }
MGGame >> shouldCompleteStep [
	"Return true if current step should be completed, false otherwise.
	According to game rules step is done when all chosen cards match
	and their amount corresponds to a specific number (#matchesCount)"
	
	^ self chosenCards size = self matchesCount
		and: [ self chosenCardMatch ]
]

{ #category : #testing }
MGGame >> shouldResetStep [ 
	^ self chosenCards size > self matchesCount
]
