class CreateInvoice < ActiveRecord::Migration[5.2]
  def change
    unless ActiveRecord::Base.connection.table_exists?('invoices')
      create_table :invoices do |t|
        t.references :customer, foreign_key: true
        t.references :merchant, foreign_key: true
        t.string :status
        t.timestamps
      end
    end
  end
end
