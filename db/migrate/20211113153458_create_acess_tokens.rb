class CreateAcessTokens < ActiveRecord::Migration[6.1]
  def change
    create_table :acess_tokens do |t|
      t.string :token, null: false
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
