note
	description: "Summary description for {MESSAGE}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	MESSAGE

feature -- Creation

	make(a_application_layer: LAYER_APPLICATION; a_is_in_message: BOOLEAN)
			-- Create a message, which will be part of the given application communication layer.
			-- a_is_in_message true, means that the message is a receivable message.
		do
			application_layer := a_application_layer
			if a_is_in_message then
				a_application_layer.messages.extend (Current)
			end
		end

feature -- Configuration

	reset
			-- Any properties set for flow and state need to reset to be able to reuse the same message
		do
		end

feature -- Parsing

	is_parseable: BOOLEAN
			-- True, when data_unit is parseable for the current message.

	parse(a_data_unit: READABLE_STRING_8)
			-- Initialize a new data unit parsing
		do
			is_parseable := false
			do_parse(a_data_unit)
		end

feature -- Transmission

	data_unit_to_transmit: STRING
			-- Result is the data eunit to be transmitted for outgoing message
		do
			-- Intended to be empty
			-- Incoming only messages are not transmitted.
			create Result.make_empty
		end

feature -- Execution

	execute(a_data_unit: READABLE_STRING_8)
			-- Execute the message, normally needs implementation for incoming messages only.
		do
			-- Intended to be empty
			-- Outgoing only messages are not executed.
		end


feature {NONE} -- Implementation

	do_parse(a_data_unit: READABLE_STRING_8)
			-- Parse the data unit and set is_parsable true, if data unit is parseable for the current message.
		do
			-- Intended to be empty in case of out going messages only			
		end

	application_layer: LAYER_APPLICATION
			-- The communication application layer

end
