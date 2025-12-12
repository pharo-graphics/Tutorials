"
I'm an implementation of boids, a simulation of flocking creatures.

The Boid class is my key collaborator.

The basic flocking model consists of three simple steering behaviors which describe how an individual boid maneuvers based on the positions and velocities its nearby flockmates:

* Separation: steer to avoid crowding local flockmates alignment diagram 	
* Alignment: steer towards the average heading of local flockmates cohesion diagram
* Cohesion: steer to move toward the average position of local flockmates

I also implement:
* Fall through: If a flock falls off one edge of the sky, it reappear at the opposite edge.
* Circling: When enabled, boids tend to circle around the center of the sky.

Reference: http://www.red3d.com/cwr/boids/

"
Class {
	#name : #BoidsSimulation,
	#superclass : #Model,
	#instVars : [
		'alignmentRadius',
		'cohesionRadius',
		'separationRadius',
		'boids',
		'separationAdjustment',
		'alignmentAdjustment',
		'cohesionAdjustment',
		'isCircling',
		'extent',
		'boidRadius',
		'velocityLimit'
	],
	#category : #'BlocTutorials-Boids-Model'
}

{ #category : #examples }
BoidsSimulation class >> exampleWithSomeBoidsExtent: anIntegerPoint [

	^ self
		  newExtent: anIntegerPoint
		  random: SharedRandom globalGenerator
		  numberOfBoids: 50
]

{ #category : #'instance creation' }
BoidsSimulation class >> newExtent: anIntegerPoint [
	
	^ self new
		extent: anIntegerPoint;
		yourself
]

{ #category : #'instance creation' }
BoidsSimulation class >> newExtent: anIntegerPoint random: aRandom numberOfBoids: aNumber [

	| aSimulation |
	aSimulation := self newExtent: anIntegerPoint.

	aNumber timesRepeat: [ 
		aSimulation addBoid: 
			(Boid newIn: aSimulation random: aRandom) ].

	^ aSimulation
]

{ #category : #accessing }
BoidsSimulation >> addBoid: aBoid [
	"Add a new boid with a initial position and velocity already established."

	boids add: aBoid
]

{ #category : #accessing }
BoidsSimulation >> alignmentAdjustment [

	^ alignmentAdjustment
]

{ #category : #accessing }
BoidsSimulation >> alignmentAdjustment: aNumber [

	alignmentAdjustment := aNumber
]

{ #category : #accessing }
BoidsSimulation >> alignmentRadius [

	^ alignmentRadius
]

{ #category : #accessing }
BoidsSimulation >> alignmentRadius: aNumber [

	alignmentRadius := aNumber
]

{ #category : #accessing }
BoidsSimulation >> boids [

	^ boids
]

{ #category : #accessing }
BoidsSimulation >> cohesionAdjustment [

	^ cohesionAdjustment
]

{ #category : #accessing }
BoidsSimulation >> cohesionAdjustment: aNumber [

	cohesionAdjustment := aNumber
]

{ #category : #accessing }
BoidsSimulation >> cohesionRadius [

	^ cohesionRadius
]

{ #category : #accessing }
BoidsSimulation >> cohesionRadius: aNumber [

	cohesionRadius := aNumber
]

{ #category : #accessing }
BoidsSimulation >> extent [
	^ extent
]

{ #category : #accessing }
BoidsSimulation >> extent: anIntegerPoint [
	"Set the extent, with a Point whose coordinates are Integer."

	extent := anIntegerPoint
]

{ #category : #moving }
BoidsSimulation >> fallThrough: aBoid [
	"If a boid falls off the edge of the bounds, it reappears at the opposite edge.
	At least, if the difference does not exceed one time the extent of the bounds."

	| p |
	p := aBoid position.
	p x < 0 ifTrue: [
		aBoid position: p + (extent x @ 0) ].
	p x > extent x ifTrue: [ 
		aBoid position: p - (extent x @ 0) ].

	p := aBoid position.
	p y < 0 ifTrue: [
		aBoid position: p + (0 @ extent y) ].
	p y > extent y ifTrue: [ 
		aBoid position: p - (0 @ extent y) ]
]

{ #category : #initialization }
BoidsSimulation >> initialize [

	super initialize.

	boids := OrderedCollection new.

	boidRadius := 8.
	velocityLimit := 8.
	
	separationRadius := boidRadius * 3. "steer to avoid crowding of flockmates"
	alignmentRadius := boidRadius * 35. "steer towards average heading of flockmates"
	cohesionRadius := boidRadius * 35. "steer towards average position of flockmates"

	separationAdjustment := 10. "how far away should Boids stay from each other (smaller further away)"
	alignmentAdjustment := 8. "how aligned the Boids are with each other (smaller more aligned)"
	cohesionAdjustment := 100. "how cohesive the Boids are with each other (smaller more cohesive)"
	
	isCircling := false.
]

{ #category : #accessing }
BoidsSimulation >> isCircling [

	^ isCircling
]

{ #category : #accessing }
BoidsSimulation >> isCircling: aBoolean [

	isCircling := aBoolean
]

{ #category : #moving }
BoidsSimulation >> move [
	"Update the simulation by 1 second. Backwards compatibility"

	self move: 1.0
]

{ #category : #moving }
BoidsSimulation >> move: deltaSeconds [

	boids do: [ :each | each move: deltaSeconds ]
]

{ #category : #'looking at others' }
BoidsSimulation >> nearbyBoidsToAlign: aBoid do: aBlock [

	^ self nearbyBoidsWithin: alignmentRadius to: aBoid do: aBlock
]

{ #category : #'looking at others' }
BoidsSimulation >> nearbyBoidsToCohere: aBoid do: aBlock [

	^ self nearbyBoidsWithin: cohesionRadius to: aBoid do: aBlock
]

{ #category : #'looking at others' }
BoidsSimulation >> nearbyBoidsToSeparate: aBoid do: aBlock [

	^ self nearbyBoidsWithin: separationRadius to: aBoid do: aBlock
]

{ #category : #'looking at others' }
BoidsSimulation >> nearbyBoidsWithin: aRadius to: aBoid do: aBlock [

	^ boids do: [ :eachBoid |
		  (aBoid isNearby: eachBoid within: aRadius)
				ifTrue: [ aBlock value: eachBoid ] ]
]

{ #category : #private }
BoidsSimulation >> newBoid [

	^ (Boid newIn: self)
		  radius: boidRadius;
		  yourself
]

{ #category : #accessing }
BoidsSimulation >> separationAdjustment [

	^ separationAdjustment
]

{ #category : #accessing }
BoidsSimulation >> separationAdjustment: aNumber [

	separationAdjustment := aNumber
]

{ #category : #accessing }
BoidsSimulation >> separationRadius [

	^ separationRadius
]

{ #category : #accessing }
BoidsSimulation >> separationRadius: aNumber [

	separationRadius := aNumber
]

{ #category : #accessing }
BoidsSimulation >> toggleCircling [
	
	isCircling := isCircling not
]

{ #category : #accessing }
BoidsSimulation >> velocityLimit [

	^ velocityLimit
]

{ #category : #accessing }
BoidsSimulation >> velocityLimit: aNumber [

	velocityLimit := aNumber
]
