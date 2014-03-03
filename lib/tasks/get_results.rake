# Run this task with:
# rake sat_results:import
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
		end
		puts "Finished!"
	end
end