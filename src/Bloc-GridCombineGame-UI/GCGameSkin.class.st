"
I provide my subclasses the possibility to declare rules to perform message sends on subsets of a Bloc scene graph, i.e. a tree elements.

To ease it, the approach is similar to SUnit's TestCases: Answer collections of rules in selectors that have with the 'Rule' suffix.

Check my hierarchy for examples.
"
Class {
	#name : #GCGameSkin,
	#superclass : #Object,
	#category : #'Bloc-GridCombineGame-UI'
}

{ #category : #accessing }
GCGameSkin class >> allRuleSelectors [
	"Answer all defined rules, cinluding inherited.
	Inspired on `TestCase class>>#allTestSelectors`."

	| answer pivotClass lookupRoot |
	answer := Set new.
	pivotClass := self.
	lookupRoot := GCGameSkin.
	[ pivotClass == lookupRoot ] whileFalse: [
		answer addAll: pivotClass ruleSelectors.
		pivotClass := pivotClass superclass ].
	
	^ answer asSortedCollection asOrderedCollection
]

{ #category : #testing }
GCGameSkin class >> isAbstract [

	^ self == GCGameSkin
]

{ #category : #'instance creation' }
GCGameSkin class >> on: aBlElement [

	^ self new
		baseElement: aBlElement;
		ruleSelectors: self allRuleSelectors;
		yourself
]

{ #category : #accessing }
GCGameSkin class >> ruleSelectors [
	"Answer defined rules locally.
	Inspired on `TestCase class>>#testSelectors`."

	^ self selectors select: [ :each |
		  (each endsWith: 'Rule') and: [ each isUnary ] ]
]

{ #category : #applying }
GCGameSkin >> applyGameFailedMessageSkinOn: anElement [

	self subclassResponsibility
]

{ #category : #applying }
GCGameSkin >> applyGameFinishedMessageSkinOn: anElement [

	self subclassResponsibility
]

{ #category : #applying }
GCGameSkin >> applyGameSkinOn: anElement [

	self subclassResponsibility
]

{ #category : #applying }
GCGameSkin >> applyGameSuccessMessageSkinOn: anElement [

	self subclassResponsibility
]

{ #category : #applying }
GCGameSkin >> applySlotSkinOn: anElement [

	self subclassResponsibility
]

{ #category : #applying }
GCGameSkin >> applyTileInsertedSkinOn: anElement [

	self subclassResponsibility
]

{ #category : #applying }
GCGameSkin >> applyTileSkinOn: anElement [

	self subclassResponsibility
]
