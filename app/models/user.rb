class User < ApplicationRecord
  attr_accessor :remember_token, :remember_me
  has_many :posts, dependent: :destroy
  before_create :set_user_id

  # ユーザー名のバリデーション
  VALID_NAME_REGEX = /\A[a-zA-Z0-9]+\z/
  validates :name, presence: true, uniqueness: { case_sensitive: false }, length: { maximum: 30 },
  format: { with: VALID_NAME_REGEX }, if: :require_validation?

  # パスワードのバリデーション
  has_secure_password #validations: false
  # validate(if: :require_validation?) do |record|
  #   record.errors.add(:password, :blank) unless record.password_digest.present?
  # end
  # validates_length_of :password, maximum: ActiveModel::SecurePassword::MAX_PASSWORD_LENGTH_ALLOWED, if: :require_validation?
  # validates_confirmation_of :password, allow_blank: true, if: :require_validation?
  validates :password, length: { minimum: 6 }
  #,if: :require_validation?


  # ランダムなremenberトークンを生成
  def User.new_token
    SecureRandom.urlsafe_base64
  end

  # 渡された文字列のハッシュ値を返す
  def User.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST : BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end

  # ハッシュ化した記憶トークンをDB（remember_digest）に保存する
  def remember
    self.remember_token = User.new_token
    update_attribute(:remember_digest, User.digest(remember_token))
  end

  # cookiesから渡されたトークンがダイジェスト(ハッシュ化されたトークン）と一致したらtrueを返す
  def authenticated?(remember_token)
    return false if remember_digest.nil?
    BCrypt::Password.new(remember_digest).is_password?(remember_token)
  end

  # ユーザーの記憶ダイジェストを破棄する
  def forget
    update_attribute(:remember_digest, nil)
  end

  private

    # ランダムなユーザーIDを生成
    def set_user_id
      while self.id.blank? || User.find_by(id: self.id).present? do
        self.id = SecureRandom.base58
      end
    end

    # ゲストユーザーの作成
    def self.guest_login
      random_pass = SecureRandom.base36
      create!(name: "ゲストユーザー",
              password: random_pass,
              guest: true)
    end

    #ゲストユーザーのみバリデーションを解除（:name）
    def require_validation?
      return true if self.guest == false || self.guest == 0
      false
    end

end
