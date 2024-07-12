Class {
	#name : #BaselineOfBlocTutorialsBoids,
	#superclass : #BaselineOf,
	#category : #BaselineOfBlocTutorialsBoids
}

{ #category : #baselines }
BaselineOfBlocTutorialsBoids >> baseline: spec [
	<baseline>

	spec for: #common do: [ 
		spec
			baseline: #'Bloc'
			with: [ spec repository: 'github://pharo-graphics/Bloc:master/src' ].
		spec
			package: #'BlocTutorials-Boids'
			with: [ spec requires: #( #'Bloc' ) ].
		spec
			package: #'BlocTutorials-Boids-Tests'
			with: [ spec requires: #( #'BlocTutorials-Boids' ) ]
		]
]
