as yet unclassified
tlvDescription
	^TLVDescription new
		instVarName: #cause;
		parseClass: self;
		useDelegatedWrite;
		beTLV;
		beForceTagged;
		tag: 16r02;
		yourself