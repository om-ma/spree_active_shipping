require_dependency 'spree/calculator'

module Spree
  class Calculator < ActiveRecord::Base
    module Usps
      class PriorityMailInternationalSmallFlatRateBox < Calculator::Usps::Base
        # http://pe.usps.com/text/imm/ab_001.htm .. http://pe.usps.com/text/imm/tz_028.htm
        AVAILABLE_COUNTRIES = [
          "AC", "AD", "AE", "AF", "AG", "AI", "AL", "AM", "AN", "AO", "AR", "AT", "AU", "AW", "AZ", "BA", "BB", "BD", 
          "BE", "BF", "BG", "BH", "BI", "BJ", "BM", "BN", "BO", "BR", "BS", "BT", "BW", "BY", "BZ", "CA", "CD", "CF", 
          "CG", "CH", "CI", "CL", "CM", "CN", "CO", "CR", "CU", "CV", "CY", "CZ", "DE", "DJ", "DK", "DM", "DO", "DZ", 
          "EC", "EE", "EG", "ER", "ES", "ET", "FI", "FJ", "FK", "FO", "FR", "GA", "GB", "GD", "GE", "GF", "GH", "GI", 
          "GL", "GM", "GN", "GP", "GQ", "GR", "GT", "GW", "GY", "HK", "HN", "HR", "HT", "HU", "ID", "IE", "IL", "IN", 
          "IQ", "IR", "IS", "IT", "JM", "JO", "JP", "KE", "KG", "KH", "KI", "KM", "KN", "KR", "KW", "KY", "KZ", "LA", 
          "LB", "LC", "LI", "LK", "LR", "LS", "LT", "LU", "LV", "LY", "MA", "MD", "ME", "MG", "MK", "ML", "MM", "MN", 
          "MO", "MP", "MQ", "MR", "MS", "MT", "MU", "MV", "MW", "MX", "MY", "MZ", "NA", "NC", "NE", "NG", "NI", "NL", 
          "NO", "NP", "NR", "NZ", "OM", "PA", "PE", "PF", "PG", "PH", "PK", "PL", "PM", "PN", "PT", "PY", "QA", "RE", 
          "RO", "RS", "RU", "RW", "SA", "SB", "SC", "SD", "SE", "SG", "SH", "SI", "SK", "SL", "SM", "SN", "SR", "ST", 
          "SV", "SY", "SZ", "TC", "TD", "TG", "TH", "TJ", "TM", "TN", "TO", "TR", "TT", "TV", "TW", "TZ", "UA", "UG", 
          "UY", "UZ", "VA", "VC", "VE", "VG", "VN", "VU", "WF", "WS", "YE", "ZA", "ZM", "ZW"
        ]

        def self.service_code
          16 #Priority Mail International® Small Flat Rate Box**
        end

        def self.description
          I18n.t("usps.priority_mail_international_small_flat_rate_box")
        end
        
        protected
        # weight limit in ounces http://pe.usps.com/text/imm/immc2_011.htm
        def max_weight_for_country(country)
          if AVAILABLE_COUNTRIES.include?(country.iso)
            4*Spree::ActiveShipping::Config[:unit_multiplier]
          else
            # ex. North Korea, Somalia, etc.
            raise Spree::ShippingError.new("#{I18n.t(:shipping_error)}: This shipping method isn't available for #{country.name}") 
          end
        end
      end
    end
  end
end