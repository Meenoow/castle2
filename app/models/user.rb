# == Schema Information
#
# Table name: users
#
#  id              :integer          not null, primary key
#  email           :string
#  password_digest :string
#  role            :string
#  username        :string
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#
class User < ApplicationRecord
  validates :email, :uniqueness => { :case_sensitive => false }
  validates :email, :presence => true
  has_secure_password

  has_many(:todos, { :class_name => "Todo", :foreign_key => "user_id", :dependent => :destroy })
  has_many :todos_completed_today, -> { completed_today }, class_name: "Todo"
  has_many(:categories, { :class_name => "Category", :foreign_key => "description", :dependent => :destroy })

  def daily_todo_goal
    5
  end
end
