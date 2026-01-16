"
I'm a sky of boids, where each of them is expressed as a custom geometry.

See example on my class-side.

TODO: It is not drawing well the boids into the canvas.
"
Class {
	#name : #BoidsCustomGeometrySkyElement,
	#superclass : #BoidsSkyElement,
	#category : #'BlocTutorials-Boids-UI-Bloc'
}

{ #category : #examples }
BoidsCustomGeometrySkyElement class >> exampleOpenInNewSpace [

	^ self new openInNewSpace
]

{ #category : #initialization }
BoidsCustomGeometrySkyElement >> boidWasAddedToSimulation: aBoid [

	self addChild: (self newElementForBoid: aBoid)
]

{ #category : #accessing }
BoidsCustomGeometrySkyElement >> boidsMovedInSimulation [
	"Position and rotation are applied in the custom geometry. We only need to request redraw"
	
	self invalidate
]

{ #category : #initialization }
BoidsCustomGeometrySkyElement >> newElementForBoid: aBoid [

	^ BlElement new
		boid: aBoid;
		background: aBoid color;
		geometry: BoidCustomGeometry new;
		yourself

]
