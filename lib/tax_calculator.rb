module TaxCalculator
  
  def TaxCalculator.Tax(taxreturn)
    flatamt = 0
    rate = 0
    # Title 26 > Subtitle A > Chapter 1 > Subchapter A > Part 1 > 1
    # (a) Married individuals filing joint returns and surviving spouses
    if (taxreturn.type == :marriedjoint || taxreturn == :survivingspouse)
      # If taxable income is not over $36,900
      if (taxreturn.income <= 36900)
        # The tax is 15% of taxable income
        rate = 0.15
        taxableamt = taxreturn.income
      end
      # If taxable income is over $36,900 but not over $89,150
      if (taxreturn.income > 36900 && taxreturn.income <= 89150)
        # The tax is $5,535 plus 28% of the excess over $36,900
        flatamt = 5535
        taxableamt = taxreturn.income - 36900
        rate = 0.28
      end
      # If taxable income is over $89,150 but not over $140,000
      if (taxreturn.income > 89150 && taxreturn.income <= 140000)
        # The tax is $20,165 plus 31% of the excess over $89,150
        flatamt = 20165
        taxableamt = taxreturn.income - 89150
        rate = 0.31
      end
      # If taxable income is over $140,000 but not over $250,000
      if (taxreturn.income > 140000 && taxreturn.income <= 250000)
        # The tax is $35,928.50 plus 36% of the excess over $140,000
        flatamt = 35928.50
        taxableamt = taxreturn.income - 140000
        rate = 0.36
      end
      #If taxable income is over $250,000
      if (taxreturn.income > 250000)
        # The tax is $75,528.50 plus 39.6% of the excess over $250,000
        flatamt = 75528.50
        taxableamt = taxreturn.income - 250000
        rate = 0.396
      end
    end
    
    return flatamt + taxableamt * rate
  end
  
end