note
	description: "[
				An OSI communication Layer

				OSI communication layer model for communication:

				7 Layers		PDU			Purpose						Protocol examples
				Application		Message		Interfaces with				SMTP, DNS, HTTP, FTP, Telnet
											Application					RIP, etc.
				Presentation	Message		Data translation			MP3, JPG (Compression),
											& prep for network			encryption, etc.
				Session			Message		Establishing and 			NTFS, SQL, RPC, NetBios,
											Maintaining communication	UDP, NCP, ADSP, etc.
											link
				Transport		Segment		Breaks down message			TCP, UDP, NWlink, SPX,
											to send						NBP, ATP, SPP, etc.
				Network			Packet		Adds logical address info	IPX, RIP, DDP, RTMP, IP,
																		ARP, RARP, ICMP, OSPF, etc.
				Data link		Frame		Adds Physical Adressing		802.3 Ethernet, 802.5 Token Ring,
																		802.11 Wireless, FIDDI, X.25, STP, etc.
				Physical		Bit			Converts to signal and		Electronic, radio or optical pulses
											sends
		 	]"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	LAYER

feature -- Status

	is_connected: BOOLEAN
			-- True, when the stack of layers is in a connected state.
		do
			if attached lower_layer as l_lower_layer then
				Result := l_lower_layer.is_connected
			end
		end

feature {LAYER} -- Communication

	transmit( a_data_unit: READABLE_STRING_8 )
			-- Transmit data unit to receiver
		do
			if attached lower_layer as l_lower_layer then
				l_lower_layer.transmit (a_data_unit)
			end
		end

	receive( a_data_unit: READABLE_STRING_8 )
			-- Received data unit from sender
		do
			if attached higher_layer as l_higher_layer then
				l_higher_layer.receive (a_data_unit)
			end
		end

feature -- Element change

	set_lower_layer(a_lower_layer: like lower_layer)
			-- Make a_lower_layer the new lower layer of this layer
		do
			lower_layer := a_lower_layer
		end

	set_higher_layer(a_higher_layer: like higher_layer)
			-- Make a_higher_layer the new higher layer of this layer
		do
			higher_layer := a_higher_layer
		end


feature {LAYER} -- OSI layers model

	higher_layer: detachable LAYER
			-- The communication layer above the current communication layer, when the OSI layers are visualized as a stack of layers.

	lower_layer: detachable LAYER
			-- The communication layer beneath the current communication layer,  when the OSI layers are visualized as a stack of layers.


end
