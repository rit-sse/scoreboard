Scoreboard::App.controllers :auth do
  post :authorize, map: '/auth' do
    if ENV['RACK_ENV'] == 'development' and
      params[:username] == "admin" and
      params[:password] == "admin"

      set_current_user "admin", "admin"

      flash[:success] = "Logged in successfully."
      redirect_to '/scoreboard'
    else
      username = params[:username]
      username = username[/\A\w+/].downcase
      user = username + "@ad.sofse.org"
      psw = params[:password]
      authorized = false

      ldap = Net::LDAP.new host: "dc1.ad.sofse.org",
           port: 389,
           auth: {
                 method: :simple,
                 username: user,
                 password: psw
           }

      filter = Net::LDAP::Filter.eq("mail", "*")
      treebase = "OU=Officers,OU=Users,OU=SOFSE,DC=ad,DC=sofse,DC=org"

      officers = []
      ldap.search(base: treebase, filter: filter) do |entry|
        officers << entry.mail.first.split("@").first
      end

      if officers.include?(username)
        authorized = true
      end

      error_notice = nil

      if authorized

        username = user
        role = "admin"

        set_current_user username, role
        flash[:success] = "Logged in successfully."
        redirect_to '/scoreboard'
      else
        if ldap
          error_notice = "Insufficient Privileges"
        else
          error_notice = "Error: #{ldap.get_operation_result.message}"
        end
      end

      if error_notice
        flash[:error] = error_notice
        redirect_to '/scoreboard'
      end
    end
  end

  post :authorize, map: '/logout' do
    session.clear
    flash[:success] = "Logged out successfully"
    redirect_to '/scoreboard'
  end
end
