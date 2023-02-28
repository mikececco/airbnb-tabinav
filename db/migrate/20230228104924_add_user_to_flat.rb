class AddUserToFlat < ActiveRecord::Migration[7.0]
  def change
    add_reference :flats, :user, index: true
  end
end
