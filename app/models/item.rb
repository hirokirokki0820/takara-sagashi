class Item < ApplicationRecord
  before_create :set_item_id, :set_item_number
  belongs_to :post

  validates :name, presence: true, length: { maximum: 50 }

  private
    # item用のidを生成
    def set_item_id
      while self.id.blank? || User.find_by(id: self.id).present? do
        self.id = SecureRandom.urlsafe_base64
      end
    end

    # ランダムな景品番号を生成
    def set_item_number
      post = self.post
      while self.item_number.blank? || post.items.find_by(item_number: self.item_number).present? do
        self.item_number = rand(1..9999).to_s
      end
    end
end
