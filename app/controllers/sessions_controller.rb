class SessionsController < ApplicationController
  def new
    # render login form in sessions/new.html.erb
  end

  def create
    # authenticate the user
    # 1. try to find the user by their unique identifier
    @user = User.find_by({ "email" => params["email"] })
        # 2. if the user exists -> check if they know their password
    if @user 
      password_from_user = params["password"]
      password_from_database = @user["password"]
      if BCrypt::Password.new(password_from_database) == password_from_user 
        flash["notice"] = "Yes!"
        cookies["user_id"] = @user["id"]
        redirect_to "/companies"
        else
        flash["notice"] = "Nope."
        redirect_to "/sessions/new"
      end
    
    # 3. if they know their password -> login is successful
    # 4. if the email does not exist or they do not know their password -> login fails
      else 
      flash["notice"] = "Nope."
      redirect_to "/sessions/new"
      end
  end

  def destroy
    # logout the user
    flash["notice"] = "Goodbye."
    redirect_to "/sessions/new"
  end
end
