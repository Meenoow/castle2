Rails.application.routes.draw do



  # Routes for the Todo resource:

  # CREATE
  post("/insert_todo", { :controller => "todos", :action => "create" })
          
  # READ
  get("/todos", { :controller => "todos", :action => "index" })
  
  get("/todos/:path_id", { :controller => "todos", :action => "show" })
  
  # UPDATE
  
  post("/modify_todo/:path_id", { :controller => "todos", :action => "update" })
  
  # DELETE
  get("/delete_todo/:path_id", { :controller => "todos", :action => "destroy" })

  #------------------------------

end
