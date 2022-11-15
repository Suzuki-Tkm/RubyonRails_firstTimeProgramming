class Member < ApplicationRecord
  has_secure_password

  has_many :entries, dependent: :destroy
  has_many :duties , dependent: :nullify
  has_many :votes, dependent: :destroy
  has_many :voted_entries, through: :votes, source: :entry
  
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

  attr_accessor :current_password
  validates :password, presence: { if: :current_password }

  def votable_for?(entry)
    entry && entry.author != self && !votes.exists?(entry_id: entry.id)
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
