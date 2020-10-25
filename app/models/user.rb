class User < ApplicationRecord
  before_save {email.downcase!}
  # 仮想の属性
  attr_accessor :remember_token

  validates :name, presence: true, length: {maximum: 50}

  #VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
  validates :email, presence: true, length: {maximum: 255},
                    format: {with: VALID_EMAIL_REGEX},
                    uniqueness: {case_sensitive: false}

  # セキュアにハッシュ化したパスワードを、データベース内のpassword_digestという属性に保存できるようになる。
  # 2つのペアの仮想的な属性 (passwordとpassword_confirmation) が使えるようになる。また、存在性と値が一致するかどうかのバリデーションも追加される18 。
  # authenticateメソッドが使えるようになる (引数の文字列がパスワードと一致するとUserオブジェクトを、間違っているとfalseを返すメソッド) 。
  has_secure_password
  validates :password, presence: true, length: { minimum: 6 }, allow_nil: true

  # 渡された文字列のハッシュ値を返す
  def self.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                  BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end

  # token
  def self.new_token
    SecureRandom.urlsafe_base64
  end

  def remember
    # user属性
    self.remember_token = User.new_token
    update_attribute(:remember_digest,User.digest(remember_token))
  end

  # tokenがdigestと一致するか
  def authenticated?(remember_token)
    # digestに値がなければ未認証とみなす
    return false if remember_digest.nil?
    BCrypt::Password.new(remember_digest).is_password?(remember_token)
  end

  def forget
    update_attribute(:remember_digest, nil)
  end
end
