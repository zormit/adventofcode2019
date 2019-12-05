Class {
	#name : #'Day5_SunnyAsteroids',
	#superclass : #Object,
	#instVars : [
		'state',
		'step',
		'operations',
		'startInput',
		'output'
	],
	#category : #AdventOfCode
}

{ #category : #running }
Day5_SunnyAsteroids class >> run: program [
	^ self run: program startInput: 1
]

{ #category : #running }
Day5_SunnyAsteroids class >> run: program startInput: s [
	| runner |
	runner := self new.
	runner state: program.
	runner startInput: s.
	runner output: OrderedCollection new.
	^ runner computeResult
]

{ #category : #accessing }
Day5_SunnyAsteroids >> computeOperations [
	| o |
	o := Dictionary new.
	o at: 1 put: [:a :b :c | self writeValue: a + b toAddressAt: (c+1). false ].
	o at: 2 put: [:a :b :c | self writeValue: a * b toAddressAt: (c+1). false ].
	o at: 3 put: [:a | self writeValue: startInput toAddressAt: (a+1). false ].
	o at: 4 put: [:a | output add: a. false ].
	" Opcode 5 is jump-if-true: if the first parameter is non-zero,
		it sets the instruction pointer to the value from the second parameter. Otherwise, it does nothing."
	o at: 5 put: [ :a :b | a ~= 0 ifTrue: [ step := (b + 1). true ] ifFalse: [ false ]  ].
	" Opcode 6 is jump-if-false: if the first parameter is zero,
		it sets the instruction pointer to the value from the second parameter. Otherwise, it does nothing."		
	o at: 6 put: [ :a :b | a = 0 ifTrue: [ step := (b + 1). true ] ifFalse: [ false ]  ].
	" Opcode 7 is less than: if the first parameter is less than the second parameter,
		it stores 1 in the position given by the third parameter. Otherwise, it stores 0."
	o at: 7 put: [ :a :b :c | self writeValue: (a < b ifTrue: [1] ifFalse: [0]) toAddressAt: (c+1). false ].
	" Opcode 8 is equals: if the first parameter is equal to the second parameter,
		it stores 1 in the position given by the third parameter. Otherwise, it stores 0."
	o at: 8 put: [ :a :b :c | self writeValue: (a = b ifTrue: [1] ifFalse: [0]) toAddressAt: (c+1). false ].
	 ^ o
]

{ #category : #run }
Day5_SunnyAsteroids >> computeResult [
	step := 1.
	[ (self state at: step) = 99 ]
		whileFalse: [ | opcode modes arguments operation |
			"Transcript show: 'state at step '; show: step; crShow: state;cr."
			opcode := (self state at: step) % 100.
			operation := self operations at: opcode.
			modes := (self state at: step) // 100.
			opcode = 3 ifTrue: [ modes := modes + 1 ].
			(#(1 2 7 8) includes: opcode) ifTrue: [ modes := modes + 100 ].
			arguments := self
				get: operation numArgs
				argsWith: modes
				from: step + 1.
			(operation valueWithArguments: arguments) ifFalse: [  
				step := step + operation numArgs + 1
			].
		].
	^ output
]

{ #category : #'state wrapper' }
Day5_SunnyAsteroids >> get: numArgs argsWith: modes from: position [
 	| p m args |
	p := position.
	m := modes.
	args := OrderedCollection new.
	numArgs timesRepeat: [ 
		m % 10 = 1
		ifTrue: [ args add: (self getImmediateAt: p) ]
		ifFalse: [ args add: (self getValueAt: p) ].
		p := p + 1.
		m := m//10.
	].
	^ args
]

{ #category : #'state wrapper' }
Day5_SunnyAsteroids >> getImmediateAt: position [ 
	^ self state at: position.
]

{ #category : #'state wrapper' }
Day5_SunnyAsteroids >> getValueAt: position [
 	| address |
	address := (self state at: position) + 1.
	^ self state at: address.
]

{ #category : #accessing }
Day5_SunnyAsteroids >> operations [
	^ operations ifNil: [ operations:= self computeOperations ]
]

{ #category : #accessing }
Day5_SunnyAsteroids >> operations: anObject [
	operations := anObject
]

{ #category : #accessing }
Day5_SunnyAsteroids >> output: anObject [
	output := anObject
]

{ #category : #setup }
Day5_SunnyAsteroids >> readProgram: program [ 
	self state: ((program substrings: ',') collect: [ :n | n asInteger  ]).
]

{ #category : #accessing }
Day5_SunnyAsteroids >> startInput: anObject [
	startInput := anObject
]

{ #category : #accessing }
Day5_SunnyAsteroids >> state [
	^ state
]

{ #category : #accessing }
Day5_SunnyAsteroids >> state: anArray [
	state := anArray
]

{ #category : #accessing }
Day5_SunnyAsteroids >> step [
	^ step
]

{ #category : #accessing }
Day5_SunnyAsteroids >> step: anObject [
	step := anObject
]

{ #category : #'state wrapper' }
Day5_SunnyAsteroids >> writeValue: value toAddressAt: address [
	self state at: address put: value
]
