require("openai")

class MessagesController < ApplicationController
  before_action(:force_user_sign_in)

  def index
    @messages = @current_user.messages

    render({ :template => "messages/index.html.erb" })
  end

  def create
    # create a new message
    user_message = @current_user.messages.create(
      content: params[:message],
    )

    # use the OpenAI API to generate a response to the user's input
    client = OpenAI::Client.new(access_token: ENV.fetch("GPT_TOKEN"))

    response = client.chat(
      parameters: {
        model: "gpt-3.5-turbo",
        messages: @current_user.api_messages_array,
        temperature: 0.7,
      },
    )

    ai_message_response_params = response.dig("choices", 0, "message")
    # create a new message with the AI's response
    ai_message = @current_user.messages.create(ai_message_response_params)

    # redirect to the chat page
    redirect_to("/messages")
  end
end
