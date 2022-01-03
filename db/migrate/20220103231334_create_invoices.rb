class CreateInvoices < ActiveRecord::Migration[5.2]
  def change
    create_table :invoices do |t|
      t.string :status
      t.references :customer, foreign_key: true

      t.timestamps
    end
  end
end
