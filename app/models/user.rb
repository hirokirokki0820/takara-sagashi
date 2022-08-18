class User < ApplicationRecord
  has_many :posts, dependent: :destroy
  before_create :set_user_id

  # ユーザー名のバリデーション
  VALID_NAME_REGEX = /\A[a-zA-Z0-9]+\z/
  validates :name, presence: true, uniqueness: { case_sensitive: false }, length: { maximum: 30 },
  format: { with: VALID_NAME_REGEX }, if: :require_validation?

  # パスワードのバリデーション
  has_secure_password validations: false
  validate(if: :require_validation?) do |record|
    record.errors.add(:password, :blank) unless record.password_digest.present?
  end
  validates_length_of :password, maximum: ActiveModel::SecurePassword::MAX_PASSWORD_LENGTH_ALLOWED, if: :require_validation?
  validates_confirmation_of :password, allow_blank: true, if: :require_validation?
  validates :password,
                      length: { minimum: 6 }, if: :require_validation?


  # ゲストユーザーの有効期限が切れている場合はtrueを返す
  # def guest_user_expired?
  #   updated_at < 7.days.ago
  # end

  private
    # ゲストユーザーのみバリデーションを解除（Name, Password）
    def require_validation?
      return true if self.guest == false || self.guest == 0
      false
    end

    # ランダムなユーザーIDを生成
    def set_user_id
      while self.id.blank? || User.find_by(id: self.id).present? do
        self.id = SecureRandom.base58
      end
    end

end
