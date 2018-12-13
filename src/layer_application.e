note
	description: "Summary description for {LAYER_APPLICATION}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	LAYER_APPLICATION
	inherit
		LAYER
			redefine
				transmit,
				receive
			end

feature -- Creation

	make
			-- The feature to be able to create an instance
		do
			create messages.make(0)
		end

feature -- Initial execution

	initialize
			-- This feature is called when a lower session layer is sure of being in a connected state.
			-- So proper actions can be taken if needed to make use of a connected communication stack.
		do
			-- Intended to be empty
		end

feature -- Initial execution

	cleanup
			-- This feature is called when a lower session layer is sure of coming to a diconnected state after
			-- having been connected.
			-- So proper actions can be taken if needed to clean up stuff, to become ready for the next connection.
		do
			-- Intended to be empty
		end

feature {LAYER, MESSAGE} -- Communication

	transmit( a_data_unit: READABLE_STRING_8 )
			-- Transmit data unit to receiver
		do
			Precursor(a_data_unit)
		end

feature {LAYER} -- Communication

	receive(a_data_unit: READABLE_STRING_8)
			-- Received data unit from sender
		local
			i: INTEGER
			l_parseable: BOOLEAN
		do
			from
				i := 1
			until
				i > messages.count or l_parseable
			loop
				messages.at(i).reset
				messages.at(i).parse(a_data_unit)
				if messages.at(i).is_parseable then
					l_parseable := true
				end
				if not l_parseable then
					i := i + 1
				end
			end
			if l_parseable then
				messages.at(i).execute(a_data_unit)
			end
		end

feature {MESSAGE} -- Messaging

	messages: ARRAYED_LIST[MESSAGE]
			-- The list of application messages

end
