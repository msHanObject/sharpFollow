class CreateChips < ActiveRecord::Migration[5.1]
  def change
    create_table :chips do |t|
      t.text :content
      t.belongs_to :user

      t.timestamps
    end
  end
end
