class AddReviewsToBench < ActiveRecord::Migration[7.0]
  def change
    add_column :benches, :rating, :integer, null: false
    add_column :benches, :comment, :text
  end
end
