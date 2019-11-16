class CreateEmergencyContacts < ActiveRecord::Migration[6.0]
  def change
    create_table :emergency_contacts do |t|
      t.string :psid
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
