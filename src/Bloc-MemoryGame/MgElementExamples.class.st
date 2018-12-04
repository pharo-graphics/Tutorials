"
I contain examples of how to create card and grid elements
"
Class {
	#name : #MgElementExamples,
	#superclass : #Object,
	#category : 'Bloc-MemoryGame-Examples'
}

{ #category : #'instance creation' }
MgElementExamples >> basicGrid [
	<gtExample>
	
	^ MgGameElement new
]

{ #category : #accessing }
MgElementExamples >> card [
	<gtExample>

	^ MgCardElement new
]

{ #category : #accessing }
MgElementExamples >> gameElementWithModel [
	<gtExample>
	
	^ self basicGrid memoryGame: MgModelExamples new gameModelWithCards
]
