class CreateLineNotificationTargets < ActiveRecord::Migration[5.2]
  def change
    create_table :line_notification_targets do |t|
      t.references :user, foreign_key: true
      t.string :token
      t.jsonb :auth_hash

      t.timestamps
    end
  end
end
