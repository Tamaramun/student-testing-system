class Result < ActiveRecord::Base
  belongs_to :test
  has_one :report
end
