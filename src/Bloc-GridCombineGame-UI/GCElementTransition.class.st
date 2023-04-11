"
I hold information about a `GCElement` animated transition.
"
Class {
	#name : #GCElementTransition,
	#superclass : #Object,
	#instVars : [
		'duration',
		'easing',
		'animation'
	],
	#category : #'Bloc-GridCombineGame-UI'
}

{ #category : #GC2048Skin }
GCElementTransition >> animation [

	^ animation
]

{ #category : #GC2048Skin }
GCElementTransition >> animation: aBlAnimation [

	self isRunning ifTrue: [ self notYetImplemented ].

	animation := aBlAnimation
]

{ #category : #GC2048Skin }
GCElementTransition >> duration [

	^ duration
]

{ #category : #GC2048Skin }
GCElementTransition >> duration: aDuration [

	aDuration isZero ifTrue: [
		self notYetImplemented ].
	self isRunning ifTrue: [
		self notYetImplemented ].

	duration := aDuration
]

{ #category : #GC2048Skin }
GCElementTransition >> easing [

	^ easing
]

{ #category : #GC2048Skin }
GCElementTransition >> easing: aBlInterpolator [

	self isRunning ifTrue: [ self notYetImplemented ].

	easing := aBlInterpolator
]

{ #category : #initialization }
GCElementTransition >> initialize [

	super initialize.
	
	duration := 0 seconds.
	easing := BlLinearInterpolator default
]

{ #category : #testing }
GCElementTransition >> isRunning [
	
	^ animation isNotNil and: [ animation isRunning ]
]
