class CreateReportRelationships < ActiveRecord::Migration[7.0]
  def change
    create_table :report_relationships do |t|
      t.references :report
      t.references :mentioning_report

      t.timestamps
    end
    add_index :report_relationships, %i[report_id mentioning_report_id], unique: true
  end
end
