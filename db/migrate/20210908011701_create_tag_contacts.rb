class CreateTagContacts < ActiveRecord::Migration[6.1]
  def change
    create_table :tag_contacts do |t|
      t.string :name

      t.timestamps
    end
  end
end
