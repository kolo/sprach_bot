# Hash methods ported from activesupport/lib/active_support/core_ext/hash/keys.rb.
class Hash
  def transform_keys
    return enum_for(:transform_keys) { size } unless block_given?
    result = self.class.new
    each_key do |key|
      result[yield(key)] = self[key]
    end
    result
  end

  def transform_keys!
    return enum_for(:transform_keys!) { size } unless block_given?
    keys.each do |key|
      self[yield(key)] = delete(key)
    end
    self
  end

  def symbolize_keys
    transform_keys{ |key| key.to_sym rescue key }
  end

  def symbolize_keys!
    transform_keys!{ |key| key.to_sym rescue key }
  end
end
