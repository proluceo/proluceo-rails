class ApplicationRecord < ActiveRecord::Base
  primary_abstract_class
  @@current_company_id

  # Strip white spaces
  strip_attributes

  # Until default_order has been propertly implemented in ActiveRecord
  default_scope -> { order(primary_key) }

  before_validation :set_company_id


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

  # Set company_id property to current company_id
  def self.current_company_id=(current_company_id)
    @@current_company_id = current_company_id
  end

  def self.current_company_id
    return nil unless defined?(@@current_company_id)
    @@current_company_id
  end

  def self.companys
    where(company_id: current_company_id)
  end

  private
  def set_company_id
    self.company_id = self.class.current_company_id unless self.is_a?(Company)
  end

  # Set table name from given schema and model name derived table
  def self.schema=(schema)
    self.table_name = "#{schema}.#{self.name.tableize}"
  end
end
