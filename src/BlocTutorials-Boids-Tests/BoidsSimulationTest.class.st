"
A BoidTest is a test class for testing the behavior of Boid
"
Class {
	#name : #BoidsSimulationTest,
	#superclass : #TestCase,
	#category : #'BlocTutorials-Boids-Tests-Model'
}

{ #category : #'tests-moving' }
BoidsSimulationTest >> testFallThrough [

	| simulation boid |
	simulation := BoidsSimulation newExtent: 100@100.

	boid := (Boid newIn: simulation)
		velocity: 10@10;
		yourself.
	
	boid position: (-10@ -10).
	simulation fallThrough: boid.
	self assert: boid position equals: (90@90).
	
	boid position: 110@110.
	simulation fallThrough: boid.
	self assert: boid position equals: (10@10).

]

{ #category : #tests }
BoidsSimulationTest >> testMove [

	| aSimulation boidR boidG boidB |
	aSimulation := BoidsSimulation newExtent: 200 @ 100.

	boidR := aSimulation newBoid
		color: Color red;
		position: 10@10;
		velocity: 2 @ 0;
		yourself.
	aSimulation addBoid: boidR.

	boidG := aSimulation newBoid
		color: Color green;
		position: 20@10;
		velocity: 2 @ 0;
		yourself.
	aSimulation addBoid: boidG.

	boidB := aSimulation newBoid
		color: Color blue;
		position: 15@15;
		velocity: 2 @ 0;
		yourself.
	aSimulation addBoid: boidB.

	aSimulation move.
	self assert: boidR position asIntegerPoint equals: 10@9.
	self assert: boidG position asIntegerPoint equals: 23@9.
	self assert: boidB position asIntegerPoint equals: 16@15.

	aSimulation move.
	self assert: boidR position asIntegerPoint equals: 9@8.
	self assert: boidG position asIntegerPoint equals: 28@8.
	self assert: boidB position asIntegerPoint equals: 17@18
]
