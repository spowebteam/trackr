class CreateMails < ActiveRecord::Migration
  def change
    create_table :mails do |t|
      t.string :to
      t.string :cc
      t.string :bcc
      t.string :subject
      t.string :body

      t.timestamps
    end
  end
end
