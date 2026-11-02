Class {
	#name : #BoidsRecordedSimulation,
	#superclass : #Object,
	#instVars : [
		'boids'
	],
	#classVars : [
		'With100Boids'
	],
	#category : #'BlocTutorials-Boids-Model'
}

{ #category : #'as yet unclassified' }
BoidsRecordedSimulation class >> initialize [

	With100Boids := self new recordForBoids: 100.
]

{ #category : #'as yet unclassified' }
BoidsRecordedSimulation class >> with100Boids [
	
	^ With100Boids copy
]

{ #category : #adding }
BoidsRecordedSimulation >> addBoid: aBoid into: aDictionary [ 
	
	(aDictionary at: aBoid put: BoidRecorded new) updateFrom: aBoid
]

{ #category : #accessing }
BoidsRecordedSimulation >> boids [ 
	
	^ boids
]

{ #category : #accessing }
BoidsRecordedSimulation >> extent: anExtent [

	"I cannot change the extent, I am already recorded"
]

{ #category : #accessing }
BoidsRecordedSimulation >> initialize [

	super initialize.
	boids := OrderedCollection new
]

{ #category : #moving }
BoidsRecordedSimulation >> move: aDelta [ 
	
	boids do: [ :e | e move ]
]

{ #category : #copying }
BoidsRecordedSimulation >> postCopy [

	super postCopy.
	boids := boids collect: [:e | e copy].
]

{ #category : #'as yet unclassified' }
BoidsRecordedSimulation >> recordForBoids: numberOfBoids [

	| simulation map |
	
	map := Dictionary new.
	simulation := BoidsSimulation newExtent: 300@300 random: (Random seed: 42) numberOfBoids: numberOfBoids.
	
	simulation boids do: [ :e | self addBoid: e into: map].

	0.1 to: 20 by: 0.1 do: [ :iteration |
		simulation move: 0.1.	
		simulation boids do: [ :e | self updateBoid: e from: map].
	].

	boids := map values.

	^ self
]

{ #category : #'as yet unclassified' }
BoidsRecordedSimulation >> updateBoid: aBoid from: aDictionary [ 
	
	(aDictionary at: aBoid) updateFrom: aBoid
]
