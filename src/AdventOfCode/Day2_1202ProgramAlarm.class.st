Class {
	#name : #'Day2_1202ProgramAlarm',
	#superclass : #Object,
	#instVars : [
		'state'
	],
	#category : #AdventOfCode
}

{ #category : #running }
Day2_1202ProgramAlarm class >> run: program [ 
	| runner |
	runner := self new.
	runner state: program.
	^ runner computeResult.
]

{ #category : #run }
Day2_1202ProgramAlarm >> computeResult [
	| step |
	step := 1.
	[ (self state at: step) = 99 ]
		whileFalse: [ | opcode |
			opcode := self state at: step.
			opcode = 1
				ifTrue: [ self doAdd: step ]
				ifFalse: [ opcode = 2
						ifTrue: [ self doMultiply: step ] ].
			step := step + 4 ].
	^ self state
]

{ #category : #computation }
Day2_1202ProgramAlarm >> doAdd: step [
	| result |
	result := (self getValueAt: (step+1))+(self getValueAt: (step+2)).
	self writeAt:(step+3) value:result.
]

{ #category : #computation }
Day2_1202ProgramAlarm >> doMultiply: step [
	| result |
	result := (self getValueAt: (step+1))*(self getValueAt: (step+2)).
	self writeAt:(step+3) value:result.
]

{ #category : #accessing }
Day2_1202ProgramAlarm >> getValueAt: position [ 
	^ self state at: (self state at: position)+1.
]

{ #category : #setup }
Day2_1202ProgramAlarm >> readProgram: program [ 
	self state: ((program substrings: ',') collect: [ :n | n asInteger  ]).
]

{ #category : #accessing }
Day2_1202ProgramAlarm >> state [
	^ state
]

{ #category : #accessing }
Day2_1202ProgramAlarm >> state: anArray [
	state := anArray
]

{ #category : #writing }
Day2_1202ProgramAlarm >> writeAt: position value: value [ 
	self state at: (state at: position)+1 put: value
]
