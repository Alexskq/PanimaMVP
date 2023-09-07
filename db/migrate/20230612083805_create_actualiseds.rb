class CreateActualiseds < ActiveRecord::Migration[7.0]
  def change
    create_table :actualiseds do |t|
      t.datetime :update_ate

      t.timestamps
    end
  end
end
