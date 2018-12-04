"
I contain examples of how to instantiate and initialize a game model with cards and query card count or grid size
"
Class {
	#name : #MgModelExamples,
	#superclass : #Object,
	#category : 'Bloc-MemoryGame-Examples'
}

{ #category : #'instance creation' }
MgModelExamples >> basicCard [
	<gtExample>
	
	^ MgCardModel new
]

{ #category : #'instance creation' }
MgModelExamples >> basicGame [
	<gtExample>
	
	^ MgGameModel new
]

{ #category : #examples }
MgModelExamples >> gameCardsCount [
	<gtExample>

	^ self basicGame cardsCount
]

{ #category : #examples }
MgModelExamples >> gameGridSize [
	<gtExample>

	^ self basicGame gridSize
]

{ #category : #examples }
MgModelExamples >> gameModelWithCards [
	<gtExample>
	
	^ self basicGame initializeForSymbols: '12345678'
]
