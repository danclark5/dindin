class TestComponent < ViewComponentReflex::Component
  def initialize
    @widget_count = 0 
  end

  def add
    @widget_count += 1
  end 
end

