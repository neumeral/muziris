class CreateSentSms < ActiveRecord::Migration[6.0]
  def change
    create_table :sent_sms do |t|
      t.string :mobile, null: false
      t.string :sms_type, null: false
      t.string :status, default: 'new', null: false
      t.json :message_options

      t.timestamps
    end
  end
end
