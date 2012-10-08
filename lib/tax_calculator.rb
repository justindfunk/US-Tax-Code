module TaxCalculator

  BRACKET_THRESHOLD = Hash.new
  BRACKET_BASE = Hash.new
  BRACKET_RATE = Hash.new
  # Title 26 > Subtitle A > Chapter 1 > Subchapter A > Part 1 > 1

  # (a) Married individuals filing joint returns and surviving spouses
  # If taxable income is not over $36,900 the tax is 15% of taxable income
  # If taxable income is over $36,900 but not over $89,150 the tax is $5,535 plus 28% of the excess over $36,900
  # If taxable income is over $89,150 but not over $140,000 the tax is $20,165 plus 31% of the excess over $89,150
  # If taxable income is over $140,000 but not over $250,000 the tax is $35,928.50 plus 36% of the excess over $140,000
  # If taxable income is over $250,000 the tax is $75,528.50 plus 39.6% of the excess over $250,000
  BRACKET_THRESHOLD[:marriedjoint] = [ 36900, 89150, 140000, 250000 ]
  BRACKET_THRESHOLD[:survivingspouse] = [ 36900, 89150, 140000, 250000 ]
  BRACKET_BASE[:marriedjoint] = [ 0, 5535, 20165, 35928.50, 75528.50 ]
  BRACKET_BASE[:survivingspouse] = [ 0, 5535, 20165, 35928.50, 75528.50 ]
  BRACKET_RATE[:marriedjoint] = [ 0.15, 0.28, 0.31, 0.36, 0.396 ]
  BRACKET_RATE[:survivingspouse] = [ 0.15, 0.28, 0.31, 0.36, 0.396 ]

  # (b) Heads of households
  # If taxable income is not over $29,600 the tax is 15% of taxable income
  # If taxable income is over $29,600 but not over $76,400 the tax is $4,440 plus 28% of the excess over $29,600
  # If taxable income is over $76,400 but not over $127,500 the tax is $17,544 plus 31% of the excess over $76,400
  # If taxable income is over $127,500 but not over $250,000 the tax is $33,385 plus 36% of the excess over $127,500
  # If taxable income is over $250,000 the tax is $77,485 plus 39.6% of the excess over $250,000
  BRACKET_THRESHOLD[:headofhousehold] = [ 29600, 76400, 127500, 250000 ]
  BRACKET_BASE[:headofhousehold] = [ 0, 4440, 17544, 33385, 77485 ]
  BRACKET_RATE[:headofhousehold] = [ 0.15, 0.28, 0.31, 0.36, 0.396 ]


  # (c) Unmarried individuals
  # If taxable income is not over $22,100 the tax is 15% of taxable income
  # If taxable income is over $22,100 but not over $53,500 the tax is $3315 plus 28% of the excess over $22,100
  # If taxable income is over $53,500 but not over $115,000 the tax is $12,107 plus 31% of the excess over $53,500
  # If taxable income is over $115,000 but not over $250,000 the tax is $31,172 plus 36% of the excess over $115,000
  # If taxable income is over $250,000 the tax is $79772 plus 39.6% of the excess over $250,000
  BRACKET_THRESHOLD[:unmarried] = [ 22100, 53500, 115000, 250000 ]
  BRACKET_BASE[:unmarried] = [ 0, 3315, 12107, 31172, 79772 ]
  BRACKET_RATE[:unmarried] = [ 0.15, 0.28, 0.31, 0.36, 0.396 ]

  def TaxCalculator.Tax(taxreturn)
    flatamt = GetBaseAmount(taxreturn)
    rate = GetRate(taxreturn)
    taxableamt = GetTaxableAmount(taxreturn)

    return flatamt + taxableamt * rate
  end

  def TaxCalculator.GetBracket(taxreturn)
    bracket = 0
    (0...BRACKET_THRESHOLD[taxreturn.type].count).each do |i|
      if taxreturn.income > BRACKET_THRESHOLD[taxreturn.type][i]
        bracket = i+1
      end
    end
    return bracket
  end

  def TaxCalculator.GetBaseAmount(taxreturn)
    return BRACKET_BASE[taxreturn.type][GetBracket(taxreturn)]
  end

  def TaxCalculator.GetRate(taxreturn)
    return BRACKET_RATE[taxreturn.type][GetBracket(taxreturn)]
  end

  def TaxCalculator.GetTaxableAmount(taxreturn)
    bracket = GetBracket(taxreturn)
    if bracket == 0
      return taxreturn.income
    else
      return taxreturn.income - BRACKET_THRESHOLD[taxreturn.type][bracket - 1]
    end
  end

end