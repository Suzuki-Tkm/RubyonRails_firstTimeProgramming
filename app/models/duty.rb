class Duty < ApplicationRecord
  belongs_to :member, class_name: "Member", foreign_key: "member_id" , optional: true
end
