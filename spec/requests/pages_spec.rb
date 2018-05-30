require "rails_helper"

RSpec.describe "Pages", type: :request do
  describe "GET #about" do
    before { get "/about/" }

    it do
      expect(path).to eq(about_path)
      expect(response).to have_http_status(200)
    end
  end
end
