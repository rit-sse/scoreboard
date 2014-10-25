Scoreboard::App.controllers :auth do
  post :authorize, map: '/api/auth', provides: [:json] do
    params = JSON.parse(request.body.read, symbolize_names: true)
    if ENV['RACK_ENV'] == 'development' and
      params[:username] == "admin" and
      params[:password] == "admin"

      set_current_user "admin", "admin"
      {notice: 'Successfully logged in!'}.to_json
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

        if ['president', 'vp', 'secretary', 'treasurer'].include?(username)
          role = 'admin'
        else
          role = 'committee'
        end

        set_current_user user, role

        {notice: 'Successfully logged in!'}.to_json
      else
        if ldap
          error_notice = "Insufficient Privileges"
        else
          error_notice = "Error: #{ldap.get_operation_result.message}"
        end
      end

      if error_notice
        flash[:error] = error_notice
        [401, {}, { notice: error_notice }.to_json]
      end
    end
  end

  post :logout, map: '/api/logout', provides: [:json] do
    session.clear
    {notice: "Logged out successfully"}.to_json
  end

  get :logged_in, map: '/api/logged_in', provides: [:json] do
    {signed_in: !current_user.nil?}.to_json
  end
end
