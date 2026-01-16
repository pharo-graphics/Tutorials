"
I'm an example of drawing boids simulation by using Element and Geometry: each boid is the model of aBlElement (See #boid: method), and the element updates its transformation on demand from such model sending #updateFromBoid.

See an example on class side.
"
Class {
	#name : #BoidsSkyUsingRectangle,
	#superclass : #BoidsSkyElement,
	#category : #'BlocTutorials-Boids-UI-Bloc'
}

{ #category : #examples }
BoidsSkyUsingRectangle class >> exampleOpenInNewSpace [

	^ self new openInNewSpace
]

{ #category : #initialization }
BoidsSkyUsingRectangle >> boidWasAddedToSimulation: aBoid [

	self addChild: (self newElementForBoid: aBoid)
]

{ #category : #accessing }
BoidsSkyUsingRectangle >> boidsMovedInSimulation [

	self childrenDo: [ :each |
			each position: each boid position.
			each transformDo: [ :aBuilder | 
				aBuilder rotateBy: each boid velocity degrees ] ]
]

{ #category : #initialization }
BoidsSkyUsingRectangle >> newElementForBoid: aBoid [

	^ BlElement new
			boid: aBoid;
			extent: aBoid extent;
			background: aBoid color;
			border: (BlBorder paint: aBoid color muchDarker width: 2);
			yourself

]
