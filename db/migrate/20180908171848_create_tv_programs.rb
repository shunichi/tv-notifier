class CreateTvPrograms < ActiveRecord::Migration[5.2]
  def change
    create_table :tv_programs do |t|
      t.references :user, foreign_key: true, null: false
      t.references :search_keyword, foreign_key: true
      t.string :url, null: false, default: ''
      t.string :keyword, null: false, default: ''
      t.datetime :start_at, null: false
      t.string :title, null: false, default: ''
      t.string :description, null: false, default: ''

      t.timestamps
    end
  end
end
