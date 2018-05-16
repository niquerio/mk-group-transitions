FactoryBot.define do
  factory :zipcode do
    number 48105
	end

	factory :group do
		name 'Barony of Cynnabar'
	  zipcodes { |a| [a.association(:zipcode)] } 	
	end

	factory :member do
	  number 55555
		zipcode
	end
end
