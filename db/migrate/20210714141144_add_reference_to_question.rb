class AddReferenceToQuestion < ActiveRecord::Migration[6.1]
  def change
    add_reference :questions, :category, index: true
  end
end
