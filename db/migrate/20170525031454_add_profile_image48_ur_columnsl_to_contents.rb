class AddProfileImage48UrColumnslToContents < ActiveRecord::Migration[5.1]
  def change
    add_column :contents, :profile_image_48_url, :string, null:false
  end
end
