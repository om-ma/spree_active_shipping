module Spree
	module StockLocationDecorator
		def self.prepended(base)
			base.validates_presence_of :address1, :city, :zipcode, :country_id
			base.validate :state_id_or_state_name_is_present
		end
		def state_id_or_state_name_is_present
		    if state_id.nil? && state_name.nil?
		      errors.add(:state_name, "can't be blank")
		    end
		end
	end
end
