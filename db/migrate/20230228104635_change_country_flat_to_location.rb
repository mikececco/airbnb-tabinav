class ChangeCountryFlatToLocation < ActiveRecord::Migration[7.0]
  def change
    rename_column :flats, :country_flat, :flat_location
  end
end
