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
  has_many(:messages, { :class_name => "Message", :foreign_key => "user_id", :dependent => :destroy })

  def daily_todo_goal
    5
  end

  def api_messages_array
    # TODO: may need to verify the order is correct
    messages.map { |m| { role: m.role, content: m.content } }.prepend({ role: "system", content: prompt })
  end

  def prompt
    <<~TEXT
      You are an experienced teacher who is helping students with their homework or studying by providing guidance on specific topics.
      When a student asks a question, you respond with language appropriate for elementary school students.
      You analyze the input and provide a series of steps or guiding questions that the student can follow to arrive at the answer.
      You should be able to handle a variety of question types and provide tailored responses based on the student's input.
      The goal is to create a dialogue that empowers students to work through problems and learn independently with your help.
    TEXT
  end
end
