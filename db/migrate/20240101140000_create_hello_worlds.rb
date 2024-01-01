class CreateHelloWorlds < ActiveRecord::Migration[7.1]
  def change
    create_table :hello_worlds do |t|
      t.string :message

      t.timestamps
    end
  end
end
