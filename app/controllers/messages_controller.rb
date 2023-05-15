class MessagesController < ApplicationController
  before_action(:force_user_sign_in)

  def index
    @messages = @current_user.messages

    render({ :template => "messages/index.html.erb" })
  end

  def create
    # create a new message
    user_message = @current_user.messages.new
    user_message.role = "user"
    user_message.content = params[:message]
    # TODO: association with @current_user

    # save the message to the database
    user_message.save

    # use the OpenAI API to generate a response to the user's input
    response = @current_user.chat(
      parameters: {
          model: ENV.fetch("OPENAI_TOKEN"),
          messages: api_messages_array,
          temperature: 1.0,
  })

    # create a new message with the AI's response
    ai_message = @current_user.messages.new
    ai_message.role = "work-bud"
    ai_message.content = response.choices.first.text

    # save the message to the database
    ai_message.save

    # redirect to the chat page
    redirect_to("/messages")
  end
end
