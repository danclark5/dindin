class IngredientSelectComponent < ViewComponentReflex::Component
  def initialize(data)
    @name = 'A Name'
    @options = [['a', '1'], ['b', '2'], ['c', '3']]
    @selected = nil
    @data = data 
  end
  
  def update_select_options
    puts 'hello'
  end

  def hello
  end
end
