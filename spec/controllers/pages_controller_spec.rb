require "rails_helper"

RSpec.describe PagesController, type: :controller do
  describe "GET #about" do
    before { get :about }
    
    it { should render_template("about") }
  end
end