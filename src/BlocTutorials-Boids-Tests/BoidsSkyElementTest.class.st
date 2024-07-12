Class {
	#name : #BoidsSkyElementTest,
	#superclass : #TestCase,
	#category : #'BlocTutorials-Boids-Tests-UI'
}

{ #category : #asserting }
BoidsSkyElementTest >> assertShown: aClass [

	| shown semaphore aSpace |
	shown := false.
	semaphore := Semaphore new.

	aSpace := aClass exampleOpenInNewSpace.

	aSpace
		when: BlSpaceShownEvent
		doOnce: [ :event |
			"The space was shown, let's wait to signal and close"
			shown := true.
			aSpace enqueueTask:
				(BlDelayedTaskAction new
					delay: 2 seconds;
					action: [
						aSpace close.
						semaphore signal ]
					yourself) ].

	semaphore wait.
	
	self assert: shown
]

{ #category : #tests }
BoidsSkyElementTest >> testOpenBoidCustomGeometrySkyElement [

	self assertShown: BoidCustomGeometrySkyElement
]

{ #category : #tests }
BoidsSkyElementTest >> testOpenBoidsCustomDrawSkyElement [

	self assertShown: BoidsCustomDrawSkyElement
]

{ #category : #tests }
BoidsSkyElementTest >> testOpenBoidsSkyUsingGeometryElement [

	self assertShown: BoidsSkyUsingGeometryElement
]
