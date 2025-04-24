"
I'm a boid expressed as a geometry.

See my references.

TODO: It is not drawing well into the canvas.
"
Class {
	#name : #BoidCustomGeometry,
	#superclass : #BlElementGeometry,
	#category : #'BlocTutorials-Boids-UI-Bloc'
}

{ #category : #'canvas - alexandrie' }
BoidCustomGeometry >> aeApplyTo: aeCanvas element: aBlElement [ 

	aeCanvas pathFactory: [ :cairoContext |
		| boid |
		boid := aBlElement boid.
		cairoContext
			circleRadius: boid radius;
			moveTo: boid radius asPoint;
			lineTo: boid velocity negated ]
]

{ #category : #'geometry testing' }
BoidCustomGeometry >> containsPoint: aPoint alreadyInGeometryBoundsOf: aBlElement [
	"Inspired by BlEllipseGeometry>>#containsPoint:in:"

	| w h x y center xRadius yRadius normalized |
	
	w := aBlElement boid radius.
	h := w.
	x := 0.
	y := 0.
	
	xRadius := w / 2.0.
	yRadius := h / 2.0.
	center := (x + xRadius) @ (y + yRadius).

	(xRadius <= 0 or: [ yRadius <= 0 ])
		ifTrue: [ ^ false ].

	normalized := (aPoint x - center x) @ (aPoint y - center y).
	^ ((normalized x squared / xRadius squared) + (normalized y squared / yRadius squared)) <= 1
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

	^ true
]

{ #category : #testing }
BoidCustomGeometry >> hasJoins [

	^ false
]

{ #category : #geometry }
BoidCustomGeometry >> matchElement: aBlElement [ 
	"Ignore element's extent. Wrong? We will get the position and radius from the boid in this element but at the moment of building the path."
]

{ #category : #'api - cache' }
BoidCustomGeometry >> releaseCache [
	"Nothing to release"
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
