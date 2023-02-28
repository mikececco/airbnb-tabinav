class ChangeCountryToCountryFlat < ActiveRecord::Migration[7.0]
  def change
    rename_column :flats, :country, :country_flat
  end
end
