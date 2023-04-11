"
I provide my subclasses the possibility to declare rules to perform message sends on subsets of a Bloc scene graph, i.e. a tree elements.

To ease it, the approach is similar to SUnit's TestCases: Answer collections of rules in selectors that have with the 'Rule' suffix.

Check my hierarchy for examples.
"
Class {
	#name : #GCMessageRuleSheet,
	#superclass : #Object,
	#instVars : [
		'baseElement',
		'ruleSelectors',
		'alreadyAppliedElements'
	],
	#category : #'Bloc-GridCombineGame-UI'
}

{ #category : #accessing }
GCMessageRuleSheet class >> allRuleSelectors [
	"Answer all defined rules, cinluding inherited.
	Inspired on `TestCase class>>#allTestSelectors`."

	| answer pivotClass lookupRoot |
	answer := Set new.
	pivotClass := self.
	lookupRoot := GCMessageRuleSheet.
	[ pivotClass == lookupRoot ] whileFalse: [
		answer addAll: pivotClass ruleSelectors.
		pivotClass := pivotClass superclass ].
	
	^ answer asSortedCollection asOrderedCollection
]

{ #category : #'instance creation' }
GCMessageRuleSheet class >> on: aBlElement [

	^ self new
		baseElement: aBlElement;
		ruleSelectors: self allRuleSelectors;
		yourself
]

{ #category : #accessing }
GCMessageRuleSheet class >> ruleSelectors [
	"Answer defined rules locally.
	Inspired on `TestCase class>>#testSelectors`."

	^ self selectors select: [ :each |
		  (each endsWith: 'Rule') and: [ each isUnary ] ]
]

{ #category : #public }
GCMessageRuleSheet >> apply: eachRule to: eachTarget [

	eachRule value pairsDo: [ :mutator :valuable |
		mutator numArgs = 1
			ifTrue: [
				eachTarget
					perform: mutator
					with: valuable value ]
			ifFalse: [
				eachTarget
					perform: mutator
					withArguments: (valuable collect: #value) ] ]
]

{ #category : #accessing }
GCMessageRuleSheet >> applyToNewElements [

	alreadyAppliedElements ifNil: [ 
		alreadyAppliedElements := IdentitySet new ].

	ruleSelectors do: [ :eachRuleSelector |
		| eachRule |
		eachRule := self perform: eachRuleSelector.

		eachRule key all do: [ :eachTarget |
			
			(alreadyAppliedElements includes: eachTarget) ifFalse: [
				alreadyAppliedElements add: eachTarget.
				self apply: eachRule to: eachTarget ]

		] ]
]

{ #category : #accessing }
GCMessageRuleSheet >> baseElement [

	^ baseElement
]

{ #category : #accessing }
GCMessageRuleSheet >> baseElement: aBlElement [

	baseElement := aBlElement
]

{ #category : #'instance creation' }
GCMessageRuleSheet >> newBaseQuery [

	^ baseElement query
]

{ #category : #accessing }
GCMessageRuleSheet >> ruleSelectors [

	^ ruleSelectors
]

{ #category : #accessing }
GCMessageRuleSheet >> ruleSelectors: aCollectionOfSymbols [

	ruleSelectors := aCollectionOfSymbols
]
