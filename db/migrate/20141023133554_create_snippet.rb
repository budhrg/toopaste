class CreateSnippet < ActiveRecord::Migration[6.0]
  def up
    create_table(:snippets, primary_key: :id) do |t|
      t.string :title, limit: 32, default: nil
      t.text :body, default: nil
      t.timestamps
    end
  end

  def down
    drop_table :snippets
  end
end
