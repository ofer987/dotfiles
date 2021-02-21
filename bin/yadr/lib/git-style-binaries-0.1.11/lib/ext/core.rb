class Object
  def returning(value)
    yield(value)
    value
  end unless Object.respond_to?(:returning)
end

class Symbol
end

class IO
  attr_accessor :use_color
end
