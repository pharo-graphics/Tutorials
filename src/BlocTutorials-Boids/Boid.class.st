"
I move at a certain velocity and stay close to my flockmates
- by aligning my speed and direction with theirs (align) and
- by moving closer to them (cohere)
- without bumping into them (separate).

If I fall off one edge of the sky, I reappear at the opposite edge (fallthrough).

I can circle around the center of the sky to avoid falling of the edges (circle).

"
Class {
	#name : #Boid,
	#superclass : #Object,
	#instVars : [
		'position',
		'color',
		'radius',
		'velocity',
		'simulation',
		'velocityDelta'
	],
	#classVars : [
		'ThreeQuartersPi'
	],
	#category : #'BlocTutorials-Boids-Model'
}

{ #category : #'class initialization' }
Boid class >> initialize [

	ThreeQuartersPi := 0.75 * Float pi
]

{ #category : #'instance creation' }
Boid class >> new [

	^ self shouldNotImplement
]

{ #category : #'instance creation' }
Boid class >> newIn: aBoidsSimulation [
	^ self basicNew
		initializeIn: aBoidsSimulation;
		yourself
]

{ #category : #'instance creation' }
Boid class >> newIn: aBoidsSimulation random: aRandom [

	^ (self newIn: aBoidsSimulation)
		color: (Color random: aRandom);
		position:
			(aBoidsSimulation extent x atRandom: aRandom) @ 
			(aBoidsSimulation extent y atRandom: aRandom);
		velocity:
			(aBoidsSimulation velocityLimit - ((2 * aBoidsSimulation velocityLimit) atRandom: aRandom)) @
			(aBoidsSimulation velocityLimit - ((2 * aBoidsSimulation velocityLimit) atRandom: aRandom));
		yourself

]

{ #category : #'flocking rules' }
Boid >> align [
	"Steer towards average heading of flockmates."

	| count sum |
	count := 0.
	sum := 0@0.
	simulation
		nearbyBoidsToAlign: self
		do: [ :each |
			sum := sum + each velocity.
			count := count + 1 ].
	count = 0 ifTrue: [ ^ self ].

	velocityDelta := velocityDelta +
		((sum / count) - self velocity / simulation alignmentAdjustment)
]

{ #category : #moving }
Boid >> circle [

	velocityDelta := velocityDelta - (self position - (simulation extent / 2) / 200)
]

{ #category : #'flocking rules' }
Boid >> cohere [
	"Steer towards average position of flockmates."

	| count sum |
	count := 0.
	sum := 0@0.
	simulation
		nearbyBoidsToCohere: self
		do: [ :each |
			sum := sum + each position.
			count := count + 1 ].
	count = 0 ifTrue: [ ^ self ].

	velocityDelta := velocityDelta +
		((sum / count) - self position / simulation cohesionAdjustment)

]

{ #category : #accessing }
Boid >> color [

	^ color
]

{ #category : #accessing }
Boid >> color: aColor [

	color := aColor
]

{ #category : #'looking at others' }
Boid >> distanceFrom: aBoid [

	^ self position distanceTo: aBoid position
]

{ #category : #'drawing - Morphic' }
Boid >> drawBallOn: aCanvas [
	"Draw the body of a boid."
	
	| path stroke r |
	r := self radius.	
	
	"Draw a filled ball."
	path := aCanvas createPath: [ :builder | | rNeg halfPi |
		rNeg := r negated.
		halfPi := Float halfPi.  
		
		builder 
			relative;
			moveTo: (self position x - r)@(self position y) + 1;
			cwArcTo: r@rNeg angle: halfPi; 
			cwArcTo: r@r angle: halfPi; 
			cwArcTo: rNeg@r angle: halfPi; 
			cwArcTo: rNeg@rNeg angle: halfPi ].

	aCanvas setPaint: self color.
	aCanvas drawShape: path.	
	
	"Draw the outline of a ball."
	stroke := aCanvas setStrokePaint: self color muchDarker.
	stroke width: 1.
	aCanvas draw.
]

{ #category : #'drawing - Morphic' }
Boid >> drawOn: aCanvas [
	self
		drawBallOn: aCanvas;
		drawTailOn: aCanvas

	

]

{ #category : #'drawing - Morphic' }
Boid >> drawTailOn: aCanvas [
	"Draw the tail of the boid, that indicates it's speed."
	
	| path |
	path := aCanvas createPath: [:builder |
		builder
			relative;
			moveTo: self position + 1;
			lineTo:  self velocity negated].
	aCanvas drawShape: path.	
]

{ #category : #accessing }
Boid >> extent [

	^ (self radius * 2) asPoint
]

{ #category : #initialization }
Boid >> initializeIn: aBoidsSimulation [

	self initialize.
	
	simulation := aBoidsSimulation
]

{ #category : #'looking at others' }
Boid >> isInFieldOfVision: aBoid [

	| vector1 vector2 cosinusAngle |
	vector1 := self velocity - self position.
	vector1 isZero ifTrue: [^ true ].
	vector2 := aBoid position - self position.
	vector2 isZero ifTrue: [^ true ].
	cosinusAngle := (vector1 dotProduct: vector2) / ((vector1 r) * (vector2 r)).

	^ cosinusAngle degreesToRadians < ThreeQuartersPi
]

{ #category : #'looking at others' }
Boid >> isNearby: aBoid within: aThreshold [

	^ aBoid ~~ self and: [ 
		  (self distanceFrom: aBoid) < aThreshold and: [ 
			  self isInFieldOfVision: aBoid ] ]
]

{ #category : #moving }
Boid >> move: deltaSeconds [

	| dt |
	dt := deltaSeconds * 50. "MAGIC"

	"Calculate velocity delta"	
	velocityDelta := 0@0.
	self separate; align; cohere; muffle.
	simulation isCircling ifTrue: [ self circle ].
	
	"Update according to delta"
	self velocity: velocity + (velocityDelta * dt).
	self position: position + (velocity * dt).

	simulation fallThrough: self
]

{ #category : #moving }
Boid >> muffle [

	self velocity r > simulation velocityLimit
		ifFalse: [ ^ self ].
	self velocity: self velocity / self velocity r.
	self velocity: self velocity * simulation velocityLimit
]

{ #category : #accessing }
Boid >> position [

	^ position
]

{ #category : #accessing }
Boid >> position: aPoint [

	position := aPoint
]

{ #category : #printing }
Boid >> printOn: aStream [
	"Append a sequence of characters to aStream that identify the receiver."

	super printOn: aStream.
	aStream
		nextPutAll: ' position: ';
		print: self position.
	aStream
		nextPutAll: ' velocity: ';
		print: self velocity
]

{ #category : #accessing }
Boid >> radius [

	^ radius ifNil: [ radius := 7 ]
]

{ #category : #accessing }
Boid >> radius: aNumber [

	radius := aNumber
]

{ #category : #'flocking rules' }
Boid >> separate [
	"Move a bit away from nearby flockmates."

	| count sum |
	count := 0.
	sum := 0@0.
	simulation
		nearbyBoidsToSeparate: self
		do: [ :each |
			sum := sum + (self position - each position).
			count := count + 1 ].
	count = 0 ifTrue: [ ^ self ].

	velocityDelta := velocityDelta +
		(sum / simulation separationAdjustment)

]

{ #category : #accessing }
Boid >> velocity [

	^ velocity ifNil: [ velocity := 0 @ 0 ]
]

{ #category : #accessing }
Boid >> velocity: aPoint [

	velocity := aPoint
]
