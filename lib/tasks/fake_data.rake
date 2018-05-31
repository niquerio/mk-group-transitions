namespace :fake_data do
  task :db_reset => :environment do
    Rake::Task['db:drop'].invoke 
    Rake::Task['db:create'].invoke 
    Rake::Task['db:migrate'].invoke 
  end
  task :zipcode_grps => :environment do
    cynnabar = Group.create(name: 'Barony of Cynnabar')
    brack = Group.create(name: 'Canton of Brackendelve')
    rw = Group.create(name: 'Barony of Roaring Wastes')
    zips = [48103, 48104, 48105, 48106, 48107, 48108, 48109, 48110, 48111]
    zips.each do |zip|
      z = Zipcode.create(number: zip)
      z.groups << cynnabar 
    end

    z = Zipcode.find_by(number: 48111)
    rw.zipcodes << z
    brack.zipcodes << z
  end

  task :poll => :environment do
    cynnabar = Group.first
    poll = Poll.create(start_date: DateTime.now, end_date: DateTime.now + 1.week, group: cynnabar)    
    letter_of_intent = File.read('lib/tasks/lorem_ipsum.txt')


    ticket1 = Ticket.create(poll: poll, letter_of_intent: letter_of_intent)
    ticket1.portrait.attach(io: File.open(Rails.root.join('lib', 'tasks', 'couple1.jpg')), filename: 'couple1.jpg', content_type: 'image/jpg')

    cand1 = Candidate.create(sca_name: 'Lord Lincoln', ticket: ticket1)
    cand2 = Candidate.create(sca_name: 'Lady Lily', ticket: ticket1)

    ticket2 = Ticket.create(poll: poll, letter_of_intent: letter_of_intent)
    ticket2.portrait.attach(io: File.open(Rails.root.join('lib', 'tasks', 'couple2.jpg')), filename: 'couple2.jpg', content_type: 'image/jpg')
    cand3 = Candidate.create(sca_name: 'Master Milton', ticket: ticket2)
    cand4 = Candidate.create(sca_name: 'Mistress Marton', ticket: ticket2)

  end

  task :all => [:db_reset, :zipcode_grps, :poll]    
end
