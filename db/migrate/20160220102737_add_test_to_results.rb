class AddTestToResults < ActiveRecord::Migration
  def change
    add_reference :results, :test, index: true, foreign_key: true
  end
end
