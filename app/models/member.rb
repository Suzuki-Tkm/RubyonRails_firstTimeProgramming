class Member < ApplicationRecord
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
