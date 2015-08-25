Sequel.migration do
  change do
    create_table(:posts) do
      primary_key :id, unique: true
      foreign_key :user_id, :users, null: false

      String :title, null: false
      String :content, text: true, default: ""

      DateTime :created_at, null: false
      DateTime :updated_at, null: false

      index :user_id
      index :created_at
    end
  end
end
