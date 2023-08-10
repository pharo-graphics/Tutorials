Extension { #name : #BlElement }

{ #category : #'*BlocTutorials-Boids' }
BlElement >> boid [

	^ self userData at: #boid
]

{ #category : #'*BlocTutorials-Boids' }
BlElement >> boid: aBoid [
	self userData at: #boid put: aBoid
]
