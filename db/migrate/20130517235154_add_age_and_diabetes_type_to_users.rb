class AddAgeAndDiabetesTypeToUsers < ActiveRecord::Migration
  def change
    add_column :users, :age, :integer
    add_column :users, :diabetes_type, :string, :default => 'Type II'
  end
end
