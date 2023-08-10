"
I'm a representation of a BoidsSimulation in Bloc.

Please refer to that class for more information.

My subclasses define alternative implementations to draw the boids in Bloc.

"
Class {
	#name : #BoidsSkyElement,
	#superclass : #BlElement,
	#instVars : [
		'steppingAnimation',
		'simulation',
		'randomGenerator'
	],
	#category : #'BlocTutorials-Boids-UI-Bloc'
}

{ #category : #'as yet unclassified' }
BoidsSkyElement class >> exampleOpenInNewSpace [
	^ self subclassResponsibility
]

{ #category : #initialization }
BoidsSkyElement >> boidWasAddedToSimulation: aBoid [
	"Hook to act after a new boid was added to the simulation"

	self subclassResponsibility

]

{ #category : #accessing }
BoidsSkyElement >> boidsMovedInSimulation [
	"Act after simulation changed."

	self subclassResponsibility
]

{ #category : #accessing }
BoidsSkyElement >> ensureNotStepping [
	
	steppingAnimation ifNotNil: [
		steppingAnimation stop.
		steppingAnimation := nil ]
]

{ #category : #accessing }
BoidsSkyElement >> ensureStepping [

	steppingAnimation ifNil: [
		steppingAnimation := self newSteppingAnimation.
		self addAnimation: steppingAnimation ]

]

{ #category : #initialization }
BoidsSkyElement >> initialize [

	super initialize.

	self
		useFixedRandomGenerator;
		background: Color lightGray;
		  constraintsDo: [ :c | 
			  c horizontal matchParent.
			  c vertical matchParent ];
		subscribeClickToAddBoid;
		subscribeExtentChangeToResizeSimulation "--> This is key because 
			simulation is initialized on first resize."

]

{ #category : #initialization }
BoidsSkyElement >> initializeSimulation [
	"Initialize the simulation and start stepping. This requires that my area is not zero."

	simulation := BoidsSimulation
			newExtent: self size asIntegerPoint
			random: randomGenerator
			numberOfBoids: 200.

	simulation boids do: [ :each |
		self boidWasAddedToSimulation: each ].
	
	self ensureStepping.

]

{ #category : #testing }
BoidsSkyElement >> isSteppingAnimation [

	^ steppingAnimation isNotNil
]

{ #category : #initialization }
BoidsSkyElement >> newSteppingAnimation [

	^ BlNumberTransition new
		  from: 0;
		  to: 1;
		  onStepDo: [ :t | self step ];
		  beInfinite;
		  yourself
]

{ #category : #accessing }
BoidsSkyElement >> randomGenerator [

	^ randomGenerator
]

{ #category : #accessing }
BoidsSkyElement >> randomGenerator: aRandom [

	randomGenerator := aRandom
]

{ #category : #accessing }
BoidsSkyElement >> simulation [

	^ simulation
]

{ #category : #accessing }
BoidsSkyElement >> step [

	simulation move.
	self boidsMovedInSimulation.
]

{ #category : #initialization }
BoidsSkyElement >> subscribeClickToAddBoid [

	self
		addEventHandlerOn: BlClickEvent
		do: [ :anEvent |
			| aBoid |
			aBoid := Boid newIn: simulation random: randomGenerator.
			aBoid position: anEvent localPosition.
			simulation addBoid: aBoid.
			self boidWasAddedToSimulation: aBoid ]

]

{ #category : #initialization }
BoidsSkyElement >> subscribeExtentChangeToResizeSimulation [
	"Subscribe to BlElementExtentChangedEvent.
	The first time this event occurs, it initializes the boids.
	The next times, the simulation extent must be updated."

	self
		addEventHandlerOn: BlElementExtentChangedEvent
		do: [ :anEvent |
			simulation
				ifNil: [ self initializeSimulation ]
				ifNotNil: [ simulation extent: self size asIntegerPoint ] ]
]

{ #category : #accessing }
BoidsSkyElement >> useFixedRandomGenerator [
	"Set a Random instance with a fixed seed. Useful for exact repeatibility on benchmarks."

	randomGenerator := Random seed: 1
]

{ #category : #accessing }
BoidsSkyElement >> useGlobalRandomGenerator [
	"Set the global Random as generator. Each simulator will be initialized slightly different."

	randomGenerator := SharedRandom globalGenerator
]
