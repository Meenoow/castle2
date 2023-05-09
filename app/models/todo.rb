# == Schema Information
#
# Table name: todos
#
#  id          :integer          not null, primary key
#  content     :string
#  status      :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  category_id :integer
#  user_id     :integer
#
class Todo < ApplicationRecord
  belongs_to(:user, { :required => true, :class_name => "User", :foreign_key => "user_id" })

  belongs_to(:category, { :required => true, :class_name => "Category", :foreign_key => "category_id" })

  scope :completed_today, -> { where(status: "done", updated_at: Date.today.all_day)  }
end
