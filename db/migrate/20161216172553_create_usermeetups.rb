class CreateUsermeetups < ActiveRecord::Migration
  def change
    create_table :usermeetups do |t|
      t.belongs_to :user, index: true
      t.belongs_to :meetups, index: true
      t.boolean :owner, null: false

      t.timestamps null: false
    end
  end
end
