ActiveRecord::Schema.define do
  self.verbose = false

  create_table :users, :force => true do |t|
    t.string :first_name
    t.string :last_name
    t.string :mood
    t.timestamps
  end
end
