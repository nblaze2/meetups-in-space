class RenameMeetupsMeetup < ActiveRecord::Migration
  def change
    rename_column :usermeetups, :meetups_id, :meetup_id
  end
end
