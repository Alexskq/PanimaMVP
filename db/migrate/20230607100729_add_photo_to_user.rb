class AddPhotoToUser < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :photo, :string, default: "https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_640.png"
  end
end
