class AddTypes < ActiveRecord::Migration
  def change
    create_table :types do |t|
      t.integer :status_code
      t.string :name

      t.timestamps null: false
    end
  end
end
