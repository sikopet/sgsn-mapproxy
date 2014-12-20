as yet unclassified
updateGprsLocation: aRequest for: aDelegate
	| imsi gt callingGT calledGT operationName dialogue invocation parameter |

	imsi := 	aRequest mobileIdentity fromTBCD.
	gt := self gtForIMSI: imsi.

	callingGT := self callingSCCPAddress.
	calledGT := self calledSCCPAddress: (gt prepare: imsi).

	operationName := 'updateGprsLocation'.
	parameter :=  ASN1Dictionary new
				at: 'imsi' put: aRequest mobileIdentity;
				at: 'sgsn-Number' put: vlrNumber toE164;
				at: 'sgsn-Address' put: 'AABBCCDD';
				yourself.
	dialogue := self newDialogue.
	dialogue
		onPAbort: [self returnUpdateGprsLocationFailureFor: aRequest on: aDelegate];
		onUAbort: [self returnUpdateGprsLocationFailureFor: aRequest on: aDelegate];
		onInvoke: [:isd |
			"TODO extract parameters for success handling"
			isd invocation returnResultLast: nil.
			dialogue requestTcContinue].
	invocation := dialogue requestTcInvokeNamed: operationName parameters:  parameter class: 1 timeout: 60.
	invocation
		onReturn: [self returnUpdateGprsLocationFailureFor: aRequest on: aDelegate];
		onError: [self returnUpdateGprsLocationFailureFor: aRequest on: aDelegate];
		onReject: [self returnUpdateGprsLocationFailureFor: aRequest on: aDelegate];
		onLCancel: [self returnUpdateGprsLocationFailureFor: aRequest on: aDelegate];
		onReturnLast: [:result | self returnUpdateGprsLocationResultFor: aRequest with: result on: aDelegate].
	dialogue
		requestTcBeginDestinationAddress: calledGT
		originatingAddress: callingGT
		applicationContextName: (dialogue applicationContextNamed: operationName).