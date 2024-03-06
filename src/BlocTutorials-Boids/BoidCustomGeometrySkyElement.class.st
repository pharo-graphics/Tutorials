"
I'm a sky of boids, where each of them is expressed as a custom geometry.

See example on my class-side.

TODO: It is not drawing well the boids into the canvas.
"
Class {
	#name : #BoidCustomGeometrySkyElement,
	#superclass : #BoidsSkyElement,
	#category : #'BlocTutorials-Boids-UI-Bloc'
}

{ #category : #examples }
BoidCustomGeometrySkyElement class >> exampleOpenInNewSpace [
	<script>
	^ self new openInNewSpace
]

{ #category : #initialization }
BoidCustomGeometrySkyElement >> boidWasAddedToSimulation: aBoid [

	self addChild: (self newElementForBoid: aBoid)
]

{ #category : #accessing }
BoidCustomGeometrySkyElement >> boidsMovedInSimulation [
	
	self childrenDo: [:each |
		each position: each boid position ]
]

{ #category : #initialization }
BoidCustomGeometrySkyElement >> newElementForBoid: aBoid [

	^ BlElement new
			boid: aBoid;
			size: aBoid extent;
			background: aBoid color;
			border: (BlBorder paint: aBoid color muchDarker width: 2);
			geometry: BoidCustomGeometry new;
			yourself

]
