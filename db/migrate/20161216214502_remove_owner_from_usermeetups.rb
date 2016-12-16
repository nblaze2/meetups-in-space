class RemoveOwnerFromUsermeetups < ActiveRecord::Migration
  def change
    remove_column :usermeetups, :owner
  end
end
