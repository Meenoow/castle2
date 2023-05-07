class TodosController < ApplicationController
  before_action(:force_user_sign_in)

  def index
    require "date"
    matching_todos = @current_user.todos

    @list_of_todos = matching_todos.order({ :created_at => :desc })

    #url_username = params.fetch("query_username")

    #matching_usernames = User.where({ :username => url_username })

    #@the_user = matching_usernames.at(0)
    date = Date.today
    @today = date.to_formatted_s(:long)

    render({ :template => "todos/index.html.erb" })
  end

  def create
    @the_todo = Todo.new
    @the_todo.content = params.fetch("query_content")
    @the_todo.user_id = session.fetch(:user_id)
    @the_todo.category_id = params.fetch("category_id")

    if @the_todo.save
      redirect_to("/todos", :notice => "We saved a todo 🎉")
    else
      redirect_to("/todos", :alert => "Error saving todo: #{@the_todo.errors.full_messages.to_sentence}")
    end
  end

  def show
    the_id = params.fetch("path_id")
    @the_todo = Todo.where({:id => the_id})
    render({ :template => "/todos" })
  end

  def update
    @todo = Todo.find(params[:path_id])
    current_stat = params.fetch("query_status")
    @todo.status=current_stat
    @todo.save
    redirect_to("/")
  end

  def destroy
    the_id = params.fetch("path_id")
    the_todo = Todo.where({id: the_id}).at(0)
    the_todo.destroy
    redirect_to("/")
  end

=begin

  def show
    the_id = params.fetch("path_id")

    matching_todos = Todo.where({ :id => the_id })

    @the_todo = matching_todos.at(0)

    render({ :template => "todos/show.html.erb" })
  end


  
  def create
    the_todo = Todo.new
    the_todo.content = params.fetch("query_content")
    #the_todo.status = params.fetch("query_status")
    the_todo.user_id = session.fetch(:user_id)
    #the_todo.user_id = params.fetch("query_user_id")
    #the_todo.category_id = params.fetch("query_category_id")

    if the_todo.valid?
      the_todo.save
      redirect_to("/student_todos", { :notice => "Todo created successfully." })
    else
      redirect_to("/student_todos", { :alert => the_todo.errors.full_messages.to_sentence })
    end
  end

  def update
    the_id = params.fetch("path_id")
    the_todo = Todo.where({ :id => the_id }).at(0)

    the_todo.content = params.fetch("query_content")
    the_todo.status = params.fetch("query_status")
    the_todo.user_id = params.fetch("query_user_id")
    the_todo.category_id = params.fetch("query_category_id")

    if the_todo.valid?
      the_todo.save
      redirect_to("/todos/#{the_todo.id}", { :notice => "Todo updated successfully."} )
    else
      redirect_to("/todos/#{the_todo.id}", { :alert => the_todo.errors.full_messages.to_sentence })
    end
  end

  def destroy
    the_id = params.fetch("path_id")
    the_todo = Todo.where({ :id => the_id }).at(0)

    the_todo.destroy

    redirect_to("/todos", { :notice => "Todo deleted successfully."} )
  end
=end
end
