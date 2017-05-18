accessing
announcer
	"Return my announcer that is used to notify my observers"
	<return: #Announcer>

	^ announcer ifNil: [ announcer := Announcer new ]