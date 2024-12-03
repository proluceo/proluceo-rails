# frozen_string_literal: true

class ApplicationReflex < StimulusReflex::Reflex
  include DbAuthenticated

  # Put application-wide Reflex behavior and callbacks in this file.
  #
  # Learn more at: https://docs.stimulusreflex.com/guide/reflex-classes
  #
  delegate :current_user, :company_id, to: :connection

  before_reflex do
    Current.user = current_user
    begin
      set_db_credentials
      ActsAsTenant.current_tenant = Company.find(company_id)
    rescue PG::ConnectionBad => e
      raise unless e.cause.message =~ /authentication failed/
      raise unless Current.user.refresh_token!
      retry
    end
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
