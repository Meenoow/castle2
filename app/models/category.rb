# == Schema Information
#
# Table name: categories
#
#  id          :integer          not null, primary key
#  description :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  user_id     :integer
#
class Category < ApplicationRecord
  belongs_to(:user, { :required => true, :class_name => "User", :foreign_key => "description" })

  has_many(:todos, { :class_name => "Todo", :foreign_key => "category_id", :dependent => :destroy })
end
