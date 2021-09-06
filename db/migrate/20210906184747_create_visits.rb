class CreateVisits < ActiveRecord::Migration[6.1]
  def change
    create_table :visits do |t|
      t.text :description
      t.integer :duration_minutes
      t.references :visit_scheduling, null: false, foreign_key: true

      t.timestamps
    end
  end
end
