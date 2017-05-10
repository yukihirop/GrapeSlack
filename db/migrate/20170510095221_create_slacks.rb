class CreateSlacks < ActiveRecord::Migration[5.1]
  def change
    create_table :slacks do |t|
      t.string :first_name,     null:false
      t.string :last_name,      null:false
      t.string :email,          null:false, unique:true
      t.string :password_digest,null:false
      t.string :profile_img_url,null:false

      t.timestamps
    end
  end
end
