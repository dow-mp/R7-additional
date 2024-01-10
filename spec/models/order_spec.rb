require 'rails_helper'
RSpec.describe Order, type: :model do
  subject { Order.new(product_name: "pens", product_count: 100, customer: FactoryBot.create(:customer))}
  it "is valid with valid attributes" do
    expect(subject).to be_valid
  end
  it "is not valid without a product_name" do
    subject.product_name=nil
    expect(subject).to_not be_valid
  end
  it "is not valid without a product_count" do
    subject.product_count=nil
    expect(subject).to_not be_valid
  end
  it "is is not valid if product_count is not a numnber" do
    subject.product_count="a string"
    expect(subject).to_not be_valid
  end
end
