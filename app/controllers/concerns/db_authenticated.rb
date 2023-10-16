module DbAuthenticated
  extend ActiveSupport::Concern

  included do
    def user_db_conf
      {
        adapter:  'postgresql',
        encoding: 'unicode',
        host:     ENV['RAILS_DB_HOST'],
        port:     ENV['RAILS_DB_PORT'],
        username: Current.user.email,
        password: Current.user.access_token,
        database: 'proluceo',
        pool: ENV.fetch("RAILS_MAX_THREADS") { 5 }
      }
    end

    def set_db_credentials
      # Connect to db with user credentials once signed in
      return reset_db_connection unless Current.user
      tries = 0
      begin
        ActiveRecord::Base.establish_connection(user_db_conf)
        Company.first
      rescue ActiveRecord::ConnectionNotEstablished
        # Weird rails issue
        tries += 1
        retry unless tries == 2
        raise
      end
    end

    def reset_db_connection
      ActiveRecord::Base.establish_connection(ActiveRecord::Base.configurations.find_db_config(Rails.env))
    end

  end
end