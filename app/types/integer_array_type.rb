class IntegerArrayType < ActiveRecord::Type::Value
  def cast(value)
    return value.respond_to?(:to_i) ? super([value.to_i]) : nil unless value.kind_of?(Array)

    value.delete("")
    super(value.filter{|v| v.respond_to? :to_i}.map(&:to_i))
  end
end
