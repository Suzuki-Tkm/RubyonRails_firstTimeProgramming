class Member < ApplicationRecord
  has_secure_password

  has_many :entries, dependent: :destroy
  has_many :duties , dependent: :nullify
  has_many :votes, dependent: :destroy
  has_many :voted_entries, through: :votes, source: :entry

  has_one_attached :profile_picture
  attribute :new_profile_picture
  attribute :remove_profile_picture, :boolean

  attribute :new_duty_ids, :intarray , default: []

  after_initialize do 
    duty_ids.each do |id|
      new_duty_ids.push(id)
    end
  end
  
  validates :number, presence: true,
  numericality: {
    only_integer: true,
    greater_than: 0,
    less_than: 100,
    allow_blank: true
  },
  uniqueness: true
  validates :name, presence: true,
  format: { with: /\A[A-Za-z][A-Za-z0-9]*\z/, allow_blank: true },
  length: { minimum: 2, maximum: 20, allow_blank: true },
  uniqueness: { case_sensitive: false }
  validates :full_name, presence: true, length: { maximum: 20 }
  validates :email, email: { allow_blank: true }
  validates :birthday, date: {
    before: ->(obj) { Date.today }
  }
  validate do
    duty_id = []
    Duty.all.each do |duty|
      duty_id.push(duty.id) if duty.member_id != nil
    end
    new_duty_ids.each do |duty|
      if Duty.find(duty).member_id != self.id
        errors.add(:base , "#{Duty.find(duty).role}はすでに決定しています") if duty_id.include?(duty)
      end 
    end
  end

  attr_accessor :current_password
  validates :password, presence: { if: :current_password }

  def votable_for?(entry)
    entry && entry.author != self && !votes.exists?(entry_id: entry.id)
  end

  validate if: :new_profile_picture do
    if new_profile_picture.respond_to?(:content_type)
      unless new_profile_picture.content_type.in?(ALLOWED_CONTENT_TYPES)
        errors.add(:new_profile_picture, :invalid_image_type)
      end
    else
      errors.add(:new_profile_picture, :invalid)
    end
  end

  before_save do
    if new_profile_picture
      self.profile_picture = new_profile_picture
    elsif remove_profile_picture
      self.profile_picture.purge
    end
    self.duty_ids = new_duty_ids
  end

  class << self
    def search(query , p)
      rel = order("number")
      if query.present?
        rel = rel.where("name LIKE ? OR full_name LIKE ?",
          "%#{query}%", "%#{query}%")
      end

     if p == "1"
      rel = rel.where(sex: 1)
     elsif p == "2"
      rel = rel.where(sex: 2)
     end
      rel
    end
  end
end
