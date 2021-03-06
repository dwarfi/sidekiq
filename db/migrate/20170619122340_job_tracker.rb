class JobTracker < ActiveRecord::Migration
  def change
    create_table :job_trackers do |table|
     table.text :job_id
      table.integer :priority, default: 0, null: false # Allows some jobs to jump to the front of the queue
      table.integer :attempts, default: 0, null: false # Provides for retries, but still fail eventually.
      table.text :last_error # reason for last failure (See Note below)
      table.datetime :run_at # When to run. Could be Time.zone.now for immediately, or sometime in the future.
      table.datetime :locked_at # Set when a client is working on this object
      table.datetime :failed_at # Set when all retries have failed (actually, by default, the record is deleted instead)
      table.string :locked_by # Who is working on this object (if locked)
      table.string :queue # The name of the queue this job is in

      # Fields for tracking jobs better
      table.integer :reference_id
      table.integer :depot_id
      table.string :reference_type
      table.string :reference_record
      table.string :status
      table.integer :progress_current, default: 0
      table.integer :progress_max, default: 0
      table.boolean :notified, default: false
      table.string :title
      table.timestamps null: false
    end
  end
end
