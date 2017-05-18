class AddTotalToReceipts < ActiveRecord::Migration[5.1]
  def change
    add_column :receipts, :total, :decimal, :precision => 8, :scale => 2 
  end
end
