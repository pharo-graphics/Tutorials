Class {
	#name : #BaselineOfMemory,
	#superclass : #BaselineOf,
	#category : #BaselineOfMemory
}

{ #category : #baselines }
BaselineOfMemory >> baseline: spec [
	<baseline>
	spec for: #common do: [ 
		spec
			baseline: 'NewBloc'
			with: [ spec repository: 'github://pharo-graphics/Bloc:dev-1.0/src' ].
		spec
			package: #'Bloc-Memory' with: [
				spec requires: #( #NewBloc ) ];
			package: #'Bloc-Memory-Tests' with: [
				spec requires: #( #'Bloc-Memory' ) ] ]

]
