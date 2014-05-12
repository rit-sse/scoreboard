Scoreboard::App.controllers :memberships,  conditions: {authorize: true} do

  get :new, map: '/memberships/new' do
    render 'memberships/new'
  end

  post :create, map: '/memberships' do
  end

end