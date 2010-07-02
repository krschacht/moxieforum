class ActionController::Base
  def self.authenticate(options = {})
    raise Exception, "Authenticate cannot be called on ActionController::Base. Only it's subclasses" if self ==  ActionController::Base
    prepend_before_filter :session_expiry
    prepend_before_filter :authenticate_session, options
  end

  def self.skip_authentication!(options = {})
    skip_before_filter :authenticate_session, options
  end

  private

    def authenticate_session
      unless valid_session? || [new_session_path, session_path].include?(request.request_uri)
        session[:return_to] = request.request_uri
        redirect_to new_session_path 
      end
    end

    def create_session_from_cookie 
      return true unless cookies[:account_remember_token] && !valid_session?
      if account = Account.find_by_remember_token(cookies[:account_remember_token])
        if !account.remember_expiry.nil? && account.remember_expiry > Time.now
          set_session_for account
          redirect_to previous_page
        end
      end
    end

    def previous_page
      (session[:return_to]) ? session[:return_to] : '/'
    end
    
    def reset_ression
      session[:account_id] = nil
      session[:account_login_time] = nil
    end

    def session_expiry
      reset_session if session[:expiry_time] && session[:expiry_time] < Time.now

      session[:expiry_time] = 1.hour.from_now
      return true
    end

    def set_session_for(account)
      session[:account_id] = account.id
      session[:account_login_time] = Time.now
    end

    def valid_session?
      ((session[:account_id] && session[:account_id] > 0) && (session[:account_login_time] && session[:account_login_time] < Time.now))
    end

end
