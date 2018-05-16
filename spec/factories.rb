FactoryBot.define do
  factory :poll, aliases: [:future_poll] do
    group 
    start_date (DateTime.now + 1.days)
    end_date (DateTime.now+2.days)
  end
  factory :current_poll, class: Poll do 
    to_create {|instance| instance.save(validate: false) }
    group
    start_date (DateTime.now - 2.days)
    end_date (DateTime.now+2.days)
  end
  factory :zipcode do
    number 48105
	end
  sequence :group_name do |n|
    "Barony of Cynnabar#{n}"
  end
	factory :group do
		name :group_name
	  zipcodes { |a| [a.association(:zipcode)] } 	
	end

	factory :member do
	  number 55555
		zipcode
	end
end
