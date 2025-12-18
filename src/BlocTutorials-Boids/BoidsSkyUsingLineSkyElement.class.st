"
I'm a sky of boids, where each of them is expressed as an element with line geometry.

See example on my class-side.
"
Class {
	#name : #BoidsSkyUsingLineSkyElement,
	#superclass : #BoidsSkyElement,
	#category : #'BlocTutorials-Boids-UI-Bloc'
}

{ #category : #examples }
BoidsSkyUsingLineSkyElement class >> exampleOpenInNewSpace [

	^ self new openInNewSpace
]

{ #category : #initialization }
BoidsSkyUsingLineSkyElement >> boidWasAddedToSimulation: aBoid [

	self addChild: (self newElementForBoid: aBoid)
]

{ #category : #accessing }
BoidsSkyUsingLineSkyElement >> boidsMovedInSimulation [
	
	self childrenDo: [:each |
		each position: each boid position.
		each transformDo: [ :aBuilder |
			aBuilder rotateBy: each boid velocity degrees ] ]
]

{ #category : #initialization }
BoidsSkyUsingLineSkyElement >> newElementForBoid: aBoid [

	^ BlElement new
			boid: aBoid;
			extent: aBoid extent;
			border: (BlBorder builder
				paint: aBoid color;
				width: 3;
				capRound;
				build);
			beOutskirtsCentered;
			geometry: (BlLineGeometry from: (aBoid radius negated @ 0) to: (aBoid radius @ 0));
			yourself
]
