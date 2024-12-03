class User
  include ActiveModel::Model
  include ActiveModel::Serializers::JSON

  ATTRS = %w(email first_name last_name image token refresh_token expires_at)
  attr_accessor(*ATTRS)

  alias_method :attributes, :instance_values
  alias_method :access_token, :token


  def self.from_omniauth(oauth_data)
    # mash hashes together
    h = oauth_data.info.to_hash.merge(oauth_data.credentials.to_hash.slice('token', 'refresh_token', 'expires_at'))
    user = new(h.slice(*ATTRS))
    # Store token in db
    user.store_user_token
    user
  end

  def refresh_token!
    return false unless refresh_token.present?
    client = OmniAuth::Strategies::GoogleOauth2.new(Rails.application, ENV['GOOGLE_CLIENT_ID'], ENV['GOOGLE_CLIENT_SECRET']).client
    new_token = OAuth2::AccessToken.new(client, token, {refresh_token: refresh_token}).refresh!
    self.token = new_token.token
    self.refresh_token = new_token.refresh_token
    self.expires_at = new_token.expires_at
    store_user_token
    return true
    rescue RuntimeError => e
      return false if e.message == 'A refresh_token is not available'
      raise
  end

  def store_user_token
    query = "SELECT store_user_token($1,$2,$3)"
    binds = [
      ActiveRecord::Relation::QueryAttribute.from_user(
        'access_token', token, ActiveRecord::Type::String.new,
      ),
      ActiveRecord::Relation::QueryAttribute.from_user(
        'refresh_token', refresh_token, ActiveRecord::Type::String.new,
      ),
      ActiveRecord::Relation::QueryAttribute.from_user(
        'expires_at', expires_at, ActiveRecord::Type::Integer.new,
      )
    ]

    self.refresh_token = ActiveRecord::Base.connection.exec_query(query, 'SQL', binds).last['store_user_token']
    true
  end
end