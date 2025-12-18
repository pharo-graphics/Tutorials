"
I'm a boid expressed as an arrow whose length depends on the velocity.

See my references.
"
Class {
	#name : #BoidCustomGeometry,
	#superclass : #BlElementGeometry,
	#category : #'BlocTutorials-Boids-UI-Bloc'
}

{ #category : #'canvas - alexandrie' }
BoidCustomGeometry >> aeApplyTo: aeCanvas element: aBlElement [ 

	aeCanvas pathFactory: [ :cairoContext |
		cairoContext restoreStateAfter: [ 
			| boid |
			boid := aBlElement boid.

			"The position, velocity and radius are applied to the affine matrix.
			The state is restored after this block closure because each boid has
			its own values."
			cairoContext
				translateBy: boid position;
				rotateByRadians: boid velocity angle;
				scaleByX: boid radius * boid velocity r / boid velocityLimit
					    y: boid radius.

			"Draw an arrow pointing to the left. Velocity affects arrow length."
			cairoContext
				lineToX: -1.0 y: -1.0;
				lineToX: -0.5 y: 0.0;
				lineToX: -1.0 y: 1.0;
				lineToX: 1.0 y: 0.0;
				closePath ] ]
]

{ #category : #'geometry testing' }
BoidCustomGeometry >> containsPoint: aPoint alreadyInGeometryBoundsOf: aBlElement [

	^ (aPoint distanceTo: aBlElement boid position) <= aBlElement boid radius
]

{ #category : #'api - bounds' }
BoidCustomGeometry >> geometryBounds: aBlBounds of: aBlElement [ 

	| center radius |
	center := aBlElement boid position.
	radius := aBlElement boid radius asPoint.

	^ aBlBounds
		origin: center - radius
		extent: center + radius
]

{ #category : #testing }
BoidCustomGeometry >> hasCaps [

	^ false
]

{ #category : #testing }
BoidCustomGeometry >> hasJoins [

	^ true
]

{ #category : #geometry }
BoidCustomGeometry >> matchElement: aBlElement [
]

{ #category : #'api - cache' }
BoidCustomGeometry >> releaseCache [
	"Nothing to release"
]

{ #category : #'api - cache' }
BoidCustomGeometry >> releaseStrokedBoundsCache [
]

{ #category : #'visual bounds' }
BoidCustomGeometry >> strokedBounds: aBlBounds of: aBlElement [ 
	"Return stroked bounds of a geometry if it would be stroked according to element's outskirts."

	^ aBlElement outskirts strokedBounds: aBlBounds of: aBlElement
]

{ #category : #'visual bounds' }
BoidCustomGeometry >> strokedBoundsInside: aBlBounds of: aBlElement [ 

	^ self geometryBounds: aBlBounds of: aBlElement
]
