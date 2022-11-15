class Entry < ApplicationRecord
  belongs_to :author, class_name: "Member", foreign_key: "member_id"
  has_many :votes, dependent: :destroy
  has_many :voters, through: :votes, source: :member

  STATUS_VALUES = %w(draft member_only public)

  validates :title, presence: true, length: { maximum: 200 }
  validates :body, :posted_at, presence: true
  validates :status, inclusion: { in: STATUS_VALUES }

  scope :common, -> { where(status: "public") }
  scope :published, -> { where("status <> ?", "draft") }
  scope :full, ->(member) {
    where("member_id = ? OR status <> ?", member.id, "draft") }
  scope :readable_for, ->(member) { member ? full(member) : common }

  STATUS_VALUES_JA = %w(下書き 会員限定 公開)

  def self.status_text(status)
    status_options.to_h.invert[status]
  end

  def self.status_options
    STATUS_VALUES_JA.zip(STATUS_VALUES)
  end
end
