"
I'm a representation of a BoidsSimulation in Bloc.

Please refer to that class for more information.

My subclasses define alternative implementations to draw the boids in Bloc either using a custom geometric or overriding the drawing hooks.
- See the methods `exampleOpenInNewSpace` of each of my subclasses.
- See the class side of `BoidsSkyPresenter` for related examples: e.g. `BoidsSkyPresenter class>> #exampleBloc1`
"
Class {
	#name : #BoidsSkyElement,
	#superclass : #BlElement,
	#instVars : [
		'simulation',
		'randomGenerator',
		'steppingTask',
		'numberOfBoids'
	],
	#category : #'BlocTutorials-Boids-UI-Bloc'
}

{ #category : #examples }
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
	
	steppingTask ifNotNil: [
		steppingTask stop.
		steppingTask := nil ]
]

{ #category : #accessing }
BoidsSkyElement >> ensureStepping [

	steppingTask ifNil: [
		steppingTask := BoidsMoveTask on: self.
		self enqueueTask: steppingTask ]
]

{ #category : #initialization }
BoidsSkyElement >> initialize [

	super initialize.

	numberOfBoids := 100.

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
			newExtent: self extent asIntegerPoint
			random: randomGenerator
			numberOfBoids: self numberOfBoids.

	simulation boids do: [ :each |
		self boidWasAddedToSimulation: each ].
	
	self ensureStepping
]

{ #category : #testing }
BoidsSkyElement >> isStepping [

	^ steppingTask isNotNil
]

{ #category : #moving }
BoidsSkyElement >> move [

	self move: 0.01
]

{ #category : #moving }
BoidsSkyElement >> move: deltaSeconds [

	simulation move: deltaSeconds.
	self boidsMovedInSimulation
]

{ #category : #accessing }
BoidsSkyElement >> numberOfBoids [

	^ numberOfBoids
]

{ #category : #accessing }
BoidsSkyElement >> numberOfBoids: aValue [

	numberOfBoids := aValue
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
BoidsSkyElement >> simulation: aBoidsSimulation [
	"The simulation can be initialized externally via this mutator, else it will be initialized by default when the element receives its first resize event."

	simulation := aBoidsSimulation
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

	self addEventHandlerOn: BlElementExtentChangedEvent do: [
		simulation
			ifNil: [ self initializeSimulation ]
			ifNotNil: [ simulation extent: self extent ] ]
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
