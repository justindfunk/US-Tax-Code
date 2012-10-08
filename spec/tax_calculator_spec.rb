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

describe 'Surviving spouse' do
  before :each do
    @taxreturn = TaxReturn.new
    @taxreturn.type = :survivingspouse
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

describe 'Heads of households' do
  before :each do
    @taxreturn = TaxReturn.new
    @taxreturn.type = :headofhousehold
  end
  describe "With taxabile income not over $29,600" do
    before :each do
      @taxreturn.income = 25000
    end
    it "should tax at 15% of taxable income." do
      TaxCalculator::Tax(@taxreturn).should eql @taxreturn.income * 0.15
    end
  end
  describe "With taxable income over $29,600 but not over $76,400" do
    before :each do
      @taxreturn.income = 65000
    end
    it "should tax at $4,440 plus 28% of the excess over $29,600." do
      TaxCalculator::Tax(@taxreturn).should eql (4440 + ((@taxreturn.income - 29600) * 0.28))
    end
  end
  describe "With taxable income over $76,400 but not over $127,500" do
    before :each do
      @taxreturn.income = 110000
    end
    it "should tax at $17,544 plus 31% of the excess over $76,400." do
      TaxCalculator::Tax(@taxreturn).should eql (17544 + ((@taxreturn.income - 76400) * 0.31))
    end
  end
  describe "With taxable income over $127,500 but not over $250,000" do
    before :each do
      @taxreturn.income = 200000
    end
    it "should tax at $33,385 plus 36% of the excess over $127,500." do
      TaxCalculator::Tax(@taxreturn).should eql (33385 + ((@taxreturn.income - 127500) * 0.36))
    end
  end
  describe "With taxable income over $250,000" do
    before :each do
      @taxreturn.income = 350000
    end
    it "should tax at $77,485 plus 39.6% of the excess over $250,000." do
      TaxCalculator::Tax(@taxreturn).should eql (77485 + ((@taxreturn.income - 250000) * 0.396))
    end
  end
end

describe 'Unmarried individuals' do
  before :each do
    @taxreturn = TaxReturn.new
    @taxreturn.type = :unmarried
  end
  describe "With taxabile income not over $22,100" do
    before :each do
      @taxreturn.income = 20000
    end
    it "should tax at 15% of taxable income." do
      TaxCalculator::Tax(@taxreturn).should eql @taxreturn.income * 0.15
    end
  end
  describe "With taxable income over $22,100 but not over $53,500" do
    before :each do
      @taxreturn.income = 50000
    end
    it "should tax at $3,315 plus 28% of the excess over $22,100." do
      TaxCalculator::Tax(@taxreturn).should eql (3315 + ((@taxreturn.income - 22100) * 0.28))
    end
  end
  describe "With taxable income over $53,500 but not over $115,000" do
    before :each do
      @taxreturn.income = 110000
    end
    it "should tax at $12,107 plus 31% of the excess over $53,500." do
      TaxCalculator::Tax(@taxreturn).should eql (12107 + ((@taxreturn.income - 53500) * 0.31))
    end
  end
  describe "With taxable income over $115,000 but not over $250,000" do
    before :each do
      @taxreturn.income = 200000
    end
    it "should tax at $31,172 plus 36% of the excess over $115,000." do
      TaxCalculator::Tax(@taxreturn).should eql (31172 + ((@taxreturn.income - 115000) * 0.36))
    end
  end
  describe "With taxable income over $250,000" do
    before :each do
      @taxreturn.income = 350000
    end
    it "should tax at $79772 plus 39.6% of the excess over $250,000." do
      TaxCalculator::Tax(@taxreturn).should eql (79772 + ((@taxreturn.income - 250000) * 0.396))
    end
  end
end
