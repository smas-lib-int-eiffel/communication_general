note
	description: "Summary description for {LAYER_SESSION}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	LAYER_SESSION

inherit
	LAYER
		redefine
			is_connected
		end

feature {LAYER} -- Session features

	connect(an_address_information: ADDRESS_INFORMATION)
			-- Create a session for the current communication layer
		deferred
		end

	connected
			-- Indicate the session layer is in a connected state
		do
			internal_is_connected := true
			if attached {LAYER_APPLICATION} higher_layer as l_higher_layer_application then
				l_higher_layer_application.initialize
			end
		end

	disconnect
			-- Terminate the current session
		deferred
		end

	disconnected
			-- Indicate the session layer is disconnected and thus not cobbected anymore
		do
			internal_is_connected := false
			if attached {LAYER_APPLICATION} higher_layer as l_higher_layer_application then
				l_higher_layer_application.cleanup
			end
		end

feature -- Status

	is_connected: BOOLEAN
			-- True, when the stack of layers is in a connected state.
		do
			Result := internal_is_connected
		end

feature {NONE} -- Implementation

	internal_is_connected: BOOLEAN
			-- True, when a connection exists.

end
