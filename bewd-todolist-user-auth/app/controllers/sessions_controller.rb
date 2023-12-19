class SessionsController < ApplicationController
  def create
    @user = User.find_by(username: params[:user][:username])

<<<<<<< HEAD
      if @user and BCrypt::Password.new(@user.password) == params[:user][:password]
        session = @user.sessions.create
        cookies.permanent.signed[:todolist_session_token] = {
          value: session.token,
          httponly: true
        }
=======
    if @user and @user.password == params[:user][:password]
      session = @user.sessions.create
      cookies.permanent.signed[:todolist_session_token] = {
        value: session.token,
        httponly: true
      }
>>>>>>> cbb41e54ea8bb7bce573d7e200cf5ab030bec996

      render json: {
        success: true
      }

    else
      render json: {
        success: false
      }
    end
  end

  def authenticated
    token = cookies.permanent.signed[:todolist_session_token]
    session = Session.find_by(token:)

    if session
      user = session.user

      render json: {
        authenticated: true,
        username: user.username
      }
    else
      render json: {
        authenticated: false
      }
    end
  end

  def destroy
    token = cookies.permanent.signed[:todolist_session_token]
    session = Session.find_by(token:)

    if session and session.destroy
      render json: {
        success: true
      }
    end
  end
end
