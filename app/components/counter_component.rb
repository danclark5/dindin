class CounterComponent < ViewComponentReflex::Component
  def initialize
    @count = 20
  end

  def increment
    @count += 1
  end
end
