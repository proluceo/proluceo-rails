class ApplicationRecord < ActiveRecord::Base
  primary_abstract_class
  # Strip white spaces
  strip_attributes

  # Scope by company
  acts_as_tenant(:company)

  # Until default_order has been propertly implemented in ActiveRecord
  default_scope -> { order(Arel.sql("#{self.name.tableize}.#{Array(primary_key).first}")) }

  ## FSM
  # FSM events  should never be accessed outside of postgres
  self.ignored_columns += [:fsm_events]
  # Current state of FSM is read only
  attr_readonly :fsm_current_state

  # Add event to entry
  def append_fsm_event(event_name)
    q = sanitize_sql_array(["SELECT fsm.append_event(?,?,?)", self.class.table_name, id, event_name])
    ActiveRecord::Base.connection.execute(q)
  end



  private

  # Set table name from given schema and model name derived table
  def self.schema=(schema)
    self.table_name = "#{schema}.#{self.name.tableize}"
  end
end
