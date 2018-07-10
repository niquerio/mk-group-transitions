FactoryBot.define do
  factory :score do
    candidate
    ballot
    value 1
  end
  factory :ballot do
    member_number 111111
    poll 
    sca_name "Lord So and So"
    modern_name "Something Someone"
    comment "MyText"
  end
  factory :ticket do
    letter_of_intent "We intend to rule well."
    poll
    after(:build) do |ticket|
      ticket.portrait.attach(io: File.open(Rails.root.join('spec', 'fixtures', 'images', 'missing.jpg')), filename: 'missing.jpg', content_type: 'image/jpg')
    end
  end
  factory :candidate do
    sca_name "Lady Ruby"
    ticket
  end
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
	  #zipcodes { |a| [a.association(:zipcode)] } 	
	end

	factory :member do
	  number 55555
		zipcode
	end
end
