Class {
	#name : #BoidsSkyElementTest,
	#superclass : #TestCase,
	#category : #'BlocTutorials-Boids-Tests-UI'
}

{ #category : #asserting }
BoidsSkyElementTest >> testExample: aClass [

	| shown semaphore aSpace |
	self timeLimit: 5 seconds.
	
	shown := false.
	semaphore := Semaphore new.

	aSpace := aClass exampleOpenInNewSpace.

	aSpace
		addEventHandlerOn: BlSpaceShownEvent
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

	self testExample: BoidCustomGeometrySkyElement
]

{ #category : #tests }
BoidsSkyElementTest >> testOpenBoidsCustomDrawSkyElement [

	self testExample: BoidsCustomDrawSkyElement
]

{ #category : #tests }
BoidsSkyElementTest >> testOpenBoidsSkyUsingGeometryElement [

	self testExample: BoidsSkyUsingGeometryElement
]
