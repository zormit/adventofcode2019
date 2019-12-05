Class {
	#name : #'Day4_SecureContainer',
	#superclass : #Object,
	#instVars : [
		'from',
		'to'
	],
	#category : #AdventOfCode
}

{ #category : #'instance creation' }
Day4_SecureContainer class >> from: from to: to [
	^ self new
		from: from;
		to: to
]

{ #category : #accessing }
Day4_SecureContainer >> from [
	^ from
]

{ #category : #accessing }
Day4_SecureContainer >> from: anObject [
	from := anObject
]

{ #category : #testing }
Day4_SecureContainer >> isValid: password [
	| same decreasing |
	"Two adjacent digits are the same (like 22 in 122345)."
	same := false.
	decreasing := false.
	1 to: password size - 1 do: [ :i | 
		(password at: i) = (password at: i + 1)
			ifTrue: [ same := true ].
		(password at: i) asInteger > (password at: i + 1) asInteger ifTrue: [ decreasing:= true ] ].
	^ same
		and: [ "Going from left to right, the digits never decrease; they only ever increase or stay the same (like 111123 or 135679)." decreasing not ]
]

{ #category : #testing }
Day4_SecureContainer >> isValid_2: password [
	| doubledDigit decreasing digitCounts|
	"Two adjacent digits are the same (like 22 in 122345)."
	"the two adjacent matching digits are not part of a larger group of matching digits."
	"Going from left to right, the digits never decrease; they only ever increase or stay the same (like 111123 or 135679)."
	doubledDigit := false.
	decreasing := false.
	digitCounts := Dictionary new.
	1 to: password size do: [ :i | 
		| this next overnext |
		this := password at: i.
		digitCounts at: this put: ((digitCounts at:this ifAbsent: 0)+1).
		"next := password at: i + 1.
		overnext := -1.
		((i + 2) <= password size)
			ifTrue: [ overnext := password at: i + 2 ].
		(this = next and: [ next ~= overnext ])
			ifTrue: [ doubledDigit := true ]."
			
		((i + 1) <= password size) ifTrue:[
		 (password at: i) asInteger > (password at: i + 1) asInteger
			ifTrue: [ decreasing := true ] ]].
	doubledDigit := digitCounts values includes: 2.
	^ doubledDigit and: [ decreasing not ]
]

{ #category : #accessing }
Day4_SecureContainer >> to [
	^ to
]

{ #category : #accessing }
Day4_SecureContainer >> to: anObject [
	to := anObject
]

{ #category : #testing }
Day4_SecureContainer >> validPasswords [
	| valid |
	valid := 0.
	self from to: self to do: [ :i | 
		(self isValid: i asString)
			ifTrue: [ valid := valid + 1 ] ].
	^ valid
]

{ #category : #testing }
Day4_SecureContainer >> validPasswords_2 [
	| valid |
	valid := 0.
	self from to: self to do: [ :i | 
		(self isValid_2: i asString)
			ifTrue: [ valid := valid + 1 ] ].
	^ valid
]
