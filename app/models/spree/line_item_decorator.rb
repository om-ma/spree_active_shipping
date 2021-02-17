# Add product packages relation
module Spree
	module LineItemDecorator
		def self.prepended(base)
			base.has_many :product_packages, through: :product
		end
	end
end
::Spree::LineItem.prepend(Spree::LineItemDecorator)
