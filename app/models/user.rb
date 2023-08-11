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

    ActiveRecord::Base.connection.exec_query(query, 'SQL', binds)
  end
end