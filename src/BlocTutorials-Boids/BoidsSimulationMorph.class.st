"
I render a bunch of Boids on the sky.

For more information, refer to `MorphicAthensExample`.
"
Class {
	#name : #BoidsSimulationMorph,
	#superclass : #Morph,
	#instVars : [
		'surface',
		'simulation'
	],
	#category : #'BlocTutorials-Boids-UI-MorphicAthens'
}

{ #category : #accessing }
BoidsSimulationMorph >> defaultExtent [
	^ 500@500
]

{ #category : #drawing }
BoidsSimulationMorph >> drawOn: aCanvas [

	self render.

	aCanvas drawImage: surface asForm at: self bounds origin
]

{ #category : #initialization }
BoidsSimulationMorph >> initialize [ 
	super initialize.
	self extent: self defaultExtent.
	self initializeSimulation.
	surface := AthensCairoSurface extent: self extent.
	self startStepping.
]

{ #category : #initialization }
BoidsSimulationMorph >> initializeSimulation [
	
	simulation := BoidsSimulation exampleWithSomeBoidsExtent: self defaultExtent.

]

{ #category : #drawing }
BoidsSimulationMorph >> render [

	surface drawDuring: [ :canvas | 
		surface clear.
		canvas pathTransform loadIdentity.
		canvas
			setPaint: Color lightGray;
			drawShape: (0 @ 0 corner: self extent).
		simulation boids do: [ :eachBoid | eachBoid drawOn: canvas ] ]
]

{ #category : #'stepping and presenter' }
BoidsSimulationMorph >> step [

	simulation move.
	self changed
]

{ #category : #stepping }
BoidsSimulationMorph >> stepTime [
	^ 0
]
