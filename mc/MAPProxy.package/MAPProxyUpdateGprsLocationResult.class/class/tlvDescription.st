as yet unclassified
tlvDescription
	^super tlvDescription
		add: (MAPProxyPDPInfoComplete tlvDescription beOptional; yourself);
		add: (MAPProxyPDPInfo attributeTlvDescription beOptional; yourself);
		add: MAPProxyISDNAddressString tlvDescription;
		add: MAPProxyHLRNumber tlvDescription;
		add: self chargingCharacteristicsTlvDescription;
		yourself