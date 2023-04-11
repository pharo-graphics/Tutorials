"
I'm an extension to `BlElement` that provides animated transitions to certain element properties.
"
Class {
	#name : #GCElement,
	#superclass : #BlElement,
	#instVars : [
		'transitionByName'
	],
	#category : #'Bloc-GridCombineGame-UI'
}

{ #category : #initialization }
GCElement >> initialize [

	super initialize.
	
	transitionByName := Dictionary new
]

{ #category : #'instance creation' }
GCElement >> newOpacityAnimationFrom: from to: to [

	^ BlNumberTransition new
			from: from;
			to: to;
			onStepDo: [ :f | super opacity: f ];
			yourself
]

{ #category : #'instance creation' }
GCElement >> newTransformationAnimationFrom: startElementTransformation to: endElementTransformation [

	| cachedTransformation fromMatrix toMatrix |
	cachedTransformation :=
		endElementTransformation asCachedTransformation.
	cachedTransformation boundingRectangle:
		self bounds inLocal asRectangle.

	fromMatrix := startElementTransformation matrix copy.
	toMatrix := cachedTransformation matrix.

"	toMatrix = fromMatrix ifTrue: [ 'same matrix!' traceCr ]."

	^ BlNumberTransition new
			from: 0.0;
			to: 1.0;
			onStepDo: [ :f |
				super transformation:
					(BlElementAbsoluteTransformation matrix:
						(fromMatrix interpolate: f to: toMatrix)) ];
			yourself
]

{ #category : #accessing }
GCElement >> opacity: aNumber [

	| aTransition anAnimation |
	aNumber = self opacity ifTrue: [ ^self ].

	aTransition := transitionByName
		at: #opacity
		ifAbsent: [ ^ super opacity: aNumber ].
	
	aTransition duration isZero ifTrue: [
		^ super opacity: aNumber ].

	aTransition isRunning ifTrue: [
		self notYetImplemented ].

	anAnimation :=
		(self newOpacityAnimationFrom: self opacity to: aNumber)
			duration: aTransition duration;
			easing: aTransition easing;
			yourself.

	aTransition animation: anAnimation.
	self addAnimation: anAnimation
]

{ #category : #accessing }
GCElement >> transformation: anElementTransformation [

	| aTransition |
	aTransition := transitionByName
		at: #transformation
		ifAbsent: [ ^ super transformation: anElementTransformation ].
	
	aTransition isRunning ifTrue: [
		self notYetImplemented ].

	self whenLayoutedDoOnce: [
		| anAnimation |
		anAnimation :=
			(self
				newTransformationAnimationFrom: self transformation
				to: anElementTransformation)
					duration: aTransition duration;
					easing: aTransition easing;
					yourself.

		aTransition animation: anAnimation.
		self addAnimation: anAnimation ]
]

{ #category : #accessing }
GCElement >> transitionAt: aName [

	^ transitionByName
			at: aName
			ifAbsentPut: [ GCElementTransition new ]
]

{ #category : #accessing }
GCElement >> transitionAt: aName duration: aDuration [

	(self transitionAt: aName) duration: aDuration

]

{ #category : #accessing }
GCElement >> transitionAt: aName easing: aBlInterpolator [

	(self transitionAt: aName) easing: aBlInterpolator
]
