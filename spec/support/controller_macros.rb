module ControllerMacros
  def login_free_user
    before(:each) do
      @request.env["devise.mapping"] = Devise.mappings[:user]
      user =  create(:user)
      sign_in user
    end
  end
  def login_admin
    before(:each) do
      @request.env["devise.mapping"] = Devise.mappings[:user]
      user =  create(:user, :admin)
      sign_in user
    end
  end
end
