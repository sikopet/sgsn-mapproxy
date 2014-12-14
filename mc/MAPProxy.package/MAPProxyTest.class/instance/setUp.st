as yet unclassified
setUp
	mapProxy := MAPProxy new.
	readDelegate := MAPProxyReadDelegate new.
	readDelegate onNewConnection: OsmoMessageSocket new.

	testEndPoint := TCAPTestServiceEndPoint new
		asn1Model: MAPProxy asn1Model.
	vlrEndPoint := TCAPTestServiceEndPoint newHLR
		asn1Model: MAPProxy asn1Model.

	mapProxy endPoint: vlrEndPoint.
	mapProxy vlrNumber: '123'.
	readDelegate mapProxy: mapProxy.

	testEndPoint connectTo: vlrEndPoint.
	vlrEndPoint connectTo: testEndPoint.