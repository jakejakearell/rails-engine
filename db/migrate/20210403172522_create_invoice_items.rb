class CreateInvoiceItems < ActiveRecord::Migration[5.2]
  def change
    create_table :invoice_items do |t|
      t.references :item_id, foreign_key: true
      t.references :invoice_id, foreign_key: true
      t.integer :quantity
      t.float :unit_price

      t.timestamps
    end
  end
end
