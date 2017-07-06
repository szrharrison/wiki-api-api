class Account
  include Mongoid::Document
  include BCrypt

  attr_accessor :password

  field :first_name, type: String
  field :last_name, type: String
  field :username, type: String
  field :password_digest, type: String

  validates :username, uniqueness: { message: ': "%{value}" is already taken'}, presence: {message: ': You must have a username'}
  validates :password_digest, presence: true

  index({username: 1}, {unique: true})

  before_validation :encrypt_password

  def authenticate(password)
    if password_correct?(password)
      true
    else
      false
    end
  end

  def password_correct?(password)
    user_pass = Password.new(self.password_digest)
    user_pass == password
  end

  def encrypt_password
    if @password
      self.password_digest = Password.create(@password)
    end
  end

  def name
    self.first_name + ' ' + self.last_name
  end

  has_many :api_wikis, validate: false do
    def pages
      @target.each_with_object([]) do |wiki, acc|
        wiki.pages.all.each do |page|
          acc << page
        end
      end
    end
  end
end
