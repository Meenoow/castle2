class MessagesController < ApplicationController
  def create
    # create a new message 
    user_message = Message.new
    user_message.role = "@current_user.username"
    user_message.content = params[:message]

    # save the message to the database
    user_message.save

    # use the OpenAI API to generate a response to the user's input
    response = OpenAI::GPT.new(
      access_token: ENV.fetch("OPENAI_TOKEN"),
      model: "text-davinci-002",
      prompt: user_message.content,
      max_tokens: 150,
      temperature: 0.5
    ).complete

    # create a new message with the AI's response
    ai_message = Message.new
    ai_message.role = "work-bud"
    ai_message.content = response.choices.first.text

    # save the message to the database
    ai_message.save

    # redirect to the chat page
    render({ :template => "messages/index.html.erb" })
    #redirect_to("/messages/index")
  end
end

##old code
=begin class MessagesController < ApplicationController
  def create
    the_message = Message.new
    the_message.role = params.fetch("query_role")
    the_message.content = params.fetch("query_content")

    system_message = Message.new
    system_message.role = "system"
    system_message.content = "You are an experience teacher. Ask the user five questions to assess their #{message.topic} proficiency. Start with an easy question. After each answer, increase or decrease the difficulty of the next question based on how well the user answered.
    In the end, provide a score between 0 and 10."
    system_message.save

    if the_message.valid?
      the_message.save

      client = OpenAI::Client.new(access_token: ENV.fetch("OPENAI_TOKEN"))

      api_messages_array = Array.new

        api_messages_array.push(message_hash)
      end

      response = client.chat(
        parameters: {
          model: ENV.fetch("OPENAI_TOKEN"),
          messages: api_messages_array,
          temperature: 1.0,
        },
      )
## the student writes the message ##
      user_message = Message.new
      user_message.role = "@current_user.username"
      user_message.content = "Please answer #{message.content}"
      user_message.save
## the assistant responds to the message ##
      assistant_message = Message.new
      assistant_message.role = "assistant"
      assistant_message.content = response.fetch("choices").at(0).fetch("message").fetch("content")
      assistant_message.save

## new message code create ##

    client = OpenAI::Client.new(access_token: ENV.fetch("OPENAI_TOKEN"))

    api_messages_array = Array.new

    ## if not quiz then question table? ##

    quiz_messages = Message.where({ :quiz_id => the_quiz.id }).order(:created_at)

    quiz_messages.each do |the_message|
      message_hash = { :role => the_message.role, :content => the_message.content }

      api_messages_array.push(message_hash)
    end

    response = client.chat(
      parameters: {
          model: ENV.fetch("OPENAI_TOKEN"),
          messages: api_messages_array,
          temperature: 1.0,
      }
    )

    assistant_message = Message.new
    assistant_message.role = "Work-Bud"
    assistant_message.content = response.fetch("choices").at(0).fetch("message").fetch("content")
    assistant_message.save

    redirect_to("/todo/index")
  end
end
=end
