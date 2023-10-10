# frozen_string_literal: true

class ApplicationReflex < StimulusReflex::Reflex
  # Put application-wide Reflex behavior and callbacks in this file.
  #
  # Learn more at: https://docs.stimulusreflex.com/guide/reflex-classes
  #
  delegate :current_user, :current_company_id, to: :connection

  before_reflex do
      Current.user = current_user
      set_db_credentials
      ActsAsTenant.current_tenant = Company.find(current_company_id)
  end
  #
  # To access view helpers inside Reflexes:
  #   delegate :helpers, to: :ApplicationController
  #
  # If you need to localize your Reflexes, you can set the I18n locale here:
  #
  #   before_reflex do
  #     I18n.locale = :fr
  #   end
  #
  # For code examples, considerations and caveats, see:
  # https://docs.stimulusreflex.com/guide/patterns#internationalization
end