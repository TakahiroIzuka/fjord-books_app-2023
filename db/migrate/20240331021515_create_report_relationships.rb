class CreateReportRelationships < ActiveRecord::Migration[7.0]
  def change
    create_table :report_relationships do |t|
      t.integer :report_id
      t.integer :mentioning_report_id

      t.timestamps
    end
    add_index :report_relationships, :report_id
    add_index :report_relationships, :mentioning_report_id
    add_index :report_relationships, %i[report_id mentioning_report_id], unique: true
  end
end
