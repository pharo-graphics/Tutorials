Class {
	#name : #BaselineOfMemory,
	#superclass : #BaselineOf,
	#category : #BaselineOfMemory
}

{ #category : #baselines }
BaselineOfMemory >> baseline: spec [
	<baseline>

	spec for: #'common' do: [
		spec package: #'Bloc-Memory' ]
	
]
