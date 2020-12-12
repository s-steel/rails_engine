class CreateInvoiceItem < ActiveRecord::Migration[5.2]
  def change
    unless ActiveRecord::Base.connection.table_exists?('invoiceitems')
      create_table :invoice_items do |t|
        t.references :item, foreign_key: true
        t.references :invoice, foreign_key: true
        t.integer :quantity
        t.float :unit_price
      end
    end
  end
end
