require 'spec_helper'

# JDF - These test cases are not the best

  describe 'Married Individual Filing Joint Return' do
    before :each do
      @taxreturn = TaxReturn.new
      @taxreturn.type = :marriedjoint
    end
    describe "With Taxable Income Not Over $36,900" do
      before :each do
        @taxreturn.income = 30000
      end
      it "Should Tax At 15% Of Income" do
        TaxCalculator::Tax(@taxreturn).should eql (30000 * 0.15)
      end
    end
    describe "With Taxable Income Over $36,900 But Not Over $89,150" do
      before :each do
        @taxreturn.income = 70000
      end
      it "Should Tax At $5,535 plus 28% of the excess over $36,900" do
        TaxCalculator::Tax(@taxreturn).should eql (5535 + ((@taxreturn.income - 36900) * 0.28))
      end
    end
    describe "With Taxable Income Over $89,150 but not over $140,000" do
      before :each do
        @taxreturn.income = 100000
      end
      it "Should Tax At $20,165 plus 31% of the excess over $89,150" do
        TaxCalculator::Tax(@taxreturn).should eql (20165 + ((@taxreturn.income - 89150) * 0.31))
      end
    end
    describe "With taxable income over $140,000 but not over $250,000" do
      before :each do
        @taxreturn.income = 225000
      end
      it "should tax at #35,928.50 plus 36% of the excess over $140,000" do
        TaxCalculator::Tax(@taxreturn).should eql (35928.50 + ((@taxreturn.income - 140000) * 0.36))
      end
    end
    describe "With taxable income over $250,000" do
      before :each do
        @taxreturn.income = 500000
      end
      it "should tax at $75,528.50 plus 39.6% of the excess over $250,000" do
        TaxCalculator::Tax(@taxreturn).should eql (75528.50 + ((@taxreturn.income - 250000) * 0.396))
      end
    end
  end
  
  describe 'Surviving Spouses' do
    before :each do
      @taxreturn = TaxReturn.new
      @taxreturn.type = :survivingspouse
    end
  end
