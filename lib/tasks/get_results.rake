namespace :sat_results do
	desc 'Import SAT results by school into database'
	task :import => :environment do
		require 'csv'    
		puts "Starting import..."
		CSV.foreach('sat.csv', :headers => true, :col_sep => ',') do |row|
		  r = Results.new(:dbn => row['DBN'],
			:school_name => row['School Name'],
			:num_test_takers => row['Number of Test Takers'],
			:critical_reading => row['Critical Reading Mean'],
			:math => row['Mathematics Mean'],
			:writing => row['Writing Mean'])
		  r.save!
		  #Car.create(:make => row['Make'], :model => row['Model'], :year => row['Year'])

		#csv_text = File.read('sat.csv')
		#csv = CSV.parse(csv_text, :headers => true)
		#csv.each do |row|
		 # print row

		end
		puts "Finished!"
	end
end