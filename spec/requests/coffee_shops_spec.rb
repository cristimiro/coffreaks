require 'rails_helper'

RSpec.describe "CoffeeShopsController", type: :request do
  describe "GET #nearby" do
    let(:params) { {} }

    before { get "/coffee_shops/nearby", params: params }

    context "when valid parameters" do
      # validates both float and integer input with same test
      let(:params) { { x: "45.0", y: "45" } }

      it "returns success message" do
        expect(response).to have_http_status(:ok)
        json = JSON.parse(response.body)
        expect(json["message"]).to eq("Success")
      end
    end

    context "when missing parameters" do
      it "returns 'Invalid coordinates' error message" do
        expect(response).to have_http_status(:unprocessable_entity)
        json = JSON.parse(response.body)
        expect(json["error"]).to eq("Invalid coordinates")
      end
    end

    context "when invalid parameters" do
      let(:params) { { x: "text", y: "45" } }

      it "returns 'Invalid coordinates' error message" do
        expect(response).to have_http_status(:unprocessable_entity)
        json = JSON.parse(response.body)
        expect(json["error"]).to eq("Invalid coordinates")
      end
    end
  end
end
