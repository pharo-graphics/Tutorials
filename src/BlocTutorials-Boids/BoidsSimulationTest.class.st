"
A BoidTest is a test class for testing the behavior of Boid
"
Class {
	#name : #BoidsSimulationTest,
	#superclass : #TestCase,
	#category : #'BlocTutorials-Boids-Model-Tests'
}

{ #category : #'tests-moving' }
BoidsSimulationTest >> testFallThrough [

	| simulation boid |
	simulation := BoidsSimulation newExtent: 100@100.

	boid := (Boid newIn: simulation)
		radius: 10;
		velocity: 10@10;
		yourself.
	
	boid position: (-10@ -10).
	simulation fallThrough: boid.
	self assert: boid position equals: (90@90).
	
	boid position: 110@110.
	simulation fallThrough: boid.
	self assert: boid position equals: (10@10).

]
