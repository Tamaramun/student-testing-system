class AddResultToReports < ActiveRecord::Migration
  def change
    add_reference :reports, :result, index: true, foreign_key: true
  end
end
