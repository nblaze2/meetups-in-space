class RenameDescriptonDescription < ActiveRecord::Migration
    def change
      rename_column :meetups, :descripton, :description
    end
end
