accessing
announcer
	"Return my announcer that is used to notify my observers"
	^ announcer ifNil: [ announcer := Announcer new ]