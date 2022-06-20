class AddTextDirectionToAppSettings < ActiveRecord::Migration[6.0]
  def change
    add_column :app_settings, :text_direction, :string, default: 'LTR'
  end
end
