class CreateVisitSchedulings < ActiveRecord::Migration[6.1]
  def change
    create_table :visit_schedulings do |t|
      t.datetime :date
      t.string :status
      t.references :contact, foreign_key: true, foreign_key: true

      t.timestamps
    end
  end
end
