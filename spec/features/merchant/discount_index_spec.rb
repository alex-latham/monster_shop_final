require 'rails_helper'

RSpec.describe "As a Merchant Employee" do
  before(:each) do
    @merchant = create(:merchant)
    @m_user = create(:merchant_employee, merchant: @merchant)
    @discount1 = @merchant.discounts.create(percent_off: 5, minimum_quantity: 20)
    @discount2 = @merchant.discounts.create(percent_off: 10, minimum_quantity: 25)
    @item1 = create(:item, merchant: @merchant)
    @item2 = create(:item, merchant: @merchant)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@m_user)
  end

  it "I can view my all of my discounts" do
    visit "/merchant/discounts"

    within("#discount-#{@discount1.id}") do
      expect(page).to have_content("Discount ##{@discount1.id}")
      expect(page).to have_content("Percent Off: #{@discount1.percent_off}%")
      expect(page).to have_content("Minimum Quantity: #{@discount1.minimum_quantity}")
    end

    within("#discount-#{@discount2.id}") do
      expect(page).to have_content("Discount ##{@discount2.id}")
      expect(page).to have_content("Percent Off: #{@discount2.percent_off}%")
      expect(page).to have_content("Minimum Quantity: #{@discount2.minimum_quantity}")
    end
  end
end