class CreateEmailBounces < ActiveRecord::Migration[7.0]
  def change
    create_table :email_bounces do |t|
      t.string :record_type
      t.string :bounce_type
      t.integer :type_code
      t.string :name
      t.string :tag
      t.string :message_stream
      t.string :description
      t.string :email
      t.string :from
      t.datetime :bounced_at
      t.string :status, null: false, default: "new"

      t.timestamps
    end
  end
end
