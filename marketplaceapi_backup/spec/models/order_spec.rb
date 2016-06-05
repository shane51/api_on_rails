require 'spec_helper'

describe Order do
  let(:order)  { FactoryGirl.build :order }
  subject { order}

  it  { should respond_to(:total) }
  it  { should respond_to(:user_id) }

  it  { should validate_presence_of :user_id }
  # TODO fixed
  # it  { should validate_presence_of :total }
  # it  { should validate_numericality_of(:total).is_greater_than_or_equal_to(0) }

  it  { should belong_to :user}

  it  { should have_many(:placements)}
  it  { should have_many(:products).through(:placements) }

  describe "#set_total!" do
    before(:each) do
      product_1 = FactoryGirl.create :product, price: 80
      product_2 = FactoryGirl.create :product, price: 100

      @order = FactoryGirl.build :order, product_ids: [product_1.id, product_2.id]
    end

    it "return the total price of the order" do
       expect{@order.set_total!}.to change{@order.total}.from(0).to(180)
    end
  end
end
