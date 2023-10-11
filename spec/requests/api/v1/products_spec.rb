require 'rails_helper'

RSpec.describe "Api::V1::Products", type: :request do

  let(:product){FactoryBot.create(:product)}
  describe "GET #index" do
    it "returns a 200 status code" do
      get api_v1_products_path
      expect(response).to have_http_status(200)
    end

    it "returns a JSON response" do
      get api_v1_products_path
      expect(response.content_type).to match("application/json")
    end
  end

  describe "POST #create" do 
    it " creates a product with status code 200" do
      post api_v1_products_path ,params: { product: { name: "Test Product", brand: "Test Brand", price: 10.0 } }
      expect(response).to have_http_status(200)
      expect(response.content_type).to match("application/json; charset=utf-8")
      
    end
  end

  describe "GET #show" do
      it "returns a 200 status code when product exists" do
      get api_v1_product_path(product.id)
      expect(response).to have_http_status(200)
      expect(response.content_type).to eq("application/json; charset=utf-8")
    end
  end

  describe "DELETE #destroy" do
    let(:product) { FactoryBot.create(:product) }

    it "deletes an existing product" do
      delete api_v1_product_path(product)
      expect(response).to have_http_status(200)
      expect(response.content_type).to eq("application/json; charset=utf-8")
      expect(Product.find_by(id: product.id)).to be_nil
    end

    it "returns an error message with a 400 status code when product deletion fails" do
      allow_any_instance_of(Product).to receive(:destroy).and_return(false)
      delete api_v1_product_path(product)
      expect(response).to have_http_status(400)
      expect(response.body).to include("could not able to delete")
      expect(Product.find_by(id: product.id)).not_to be_nil
    end
  end
end
