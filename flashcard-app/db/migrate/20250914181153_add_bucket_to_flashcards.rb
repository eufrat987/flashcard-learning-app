class AddBucketToFlashcards < ActiveRecord::Migration[8.0]
  def change
    add_column :flashcards, :bucket, :integer
  end
end
