class AddNameAndStakeholderToRedirects < ActiveRecord::Migration
  def change
    change_table :redirects do |t|
      t.string :name
      t.string :stakeholder
    end
  end
end
