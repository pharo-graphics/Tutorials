"
I'm an example of drawing boids simulation by using Element and Geometry: each boid is the model of aBlElement (See #boid: method), and the element updates it's transformation un demand from such model sending #updateFromBoid.

See an example on class side.
"
Class {
	#name : #BoidsSkyUsingGeometryElement,
	#superclass : #BoidsSkyElement,
	#category : #'BlocTutorials-Boids-UI-Bloc'
}

{ #category : #examples }
BoidsSkyUsingGeometryElement class >> exampleOpenInNewSpace [

	^ self new openInNewSpace
]

{ #category : #initialization }
BoidsSkyUsingGeometryElement >> boidWasAddedToSimulation: aBoid [

	self addChild: (self newElementForBoid: aBoid)
]

{ #category : #accessing }
BoidsSkyUsingGeometryElement >> boidsMovedInSimulation [
	
	self childrenDo: [:each |
		each position: each boid position.
		each transformDo: [ :aBuilder |
			aBuilder rotateBy: each boid velocity degrees ] ]
]

{ #category : #initialization }
BoidsSkyUsingGeometryElement >> newElementForBoid: aBoid [

	^ BlElement new
			boid: aBoid;
			size: aBoid extent;
			background: aBoid color;
			border: (BlBorder paint: aBoid color muchDarker width: 2);
			geometry: BlTriangleGeometry new;
			yourself

]
