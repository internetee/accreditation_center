class AddReferenceToCategory < ActiveRecord::Migration[6.1]
  def change
    add_reference :categories, :quiz, index: true
  end
end
