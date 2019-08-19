require 'rails_helper'

RSpec.describe DifferentiationController, type: :controller do

  describe "GET #show .json" do

    context "HTTP response codes" do
      let(:coefficients) { "3/2/1" }

      it "returns 200 Ok if coefficients are supplied" do
        get :show, params: {coefficients: coefficients}, format: :json
        expect(response).to have_http_status(:success)
      end

      it "returns 422 Unprocessable Entity if coefficients are wrong" do
        get :show, params: {coefficients: ['a','b','c']}, format: :json
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end

    context "Response body" do
      let(:coefficients) { "3/2/1" }

      it "returns valid JSON" do
        get :show, params: {coefficients: coefficients}
        expect { JSON.parse response.body }.not_to raise_error
      end

      it "JSON response contains an 'expression' if successful" do
        get :show, params: {coefficients: coefficients}
        data = JSON.parse response.body
        expect(data['expression']).not_to be_nil
      end

      it "JSON response contains 'errors' if not" do
        get :show, params: {coefficients: "a/b/c"}
        data = JSON.parse response.body
        expect(data[0]['message']).to eql('one or more coefficients are not integers')
      end
    end
  end

end
