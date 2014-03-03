class Results
  include Mongoid::Document
  field :dbn, type: String
  field :school_name, type: String
  field :num_test_takers, type: String
  field :critical_reading, type: String
  field :math, type: String
  field :writing, type: String
end
