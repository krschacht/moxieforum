module MoxieForum
  class SessionsController < ApplicationController

    unloadable

    prepend_before_filter :create_session_from_cookie, :only => [:new]

    def create
      if account = Account.authenticate(params[:account][:uname], params[:account][:password])
        set_session_for(account)
        if params[:account][:remember_me] == "1"
          account.remember_me
          cookies[:account_remember_token] = { :value => account.remember_token, :expires => account.remember_expiry }
        end
        redirect_to previous_page
      else
        redirect_to new_session_path
      end
    end
    
    def new
      @account = Account.new
    end

    def destroy
      if cookies[:account_remember_token]
        Account.find(session[:account_id]).forget_me
        cookies.delete :account_remember_token
      end
      reset_session
      redirect_to new_session_path
    end
  end
end
