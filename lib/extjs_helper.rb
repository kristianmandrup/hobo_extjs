module ExtjsHelper
  
  def attrs_always_skip
    [:show]
  end

  # subtract attrs_skip from attrs
  def ext_attrs(values, attrs_skip = [])
    result = values.except *attrs_always_skip
    return result
  end

  # take a map of symbol => value and convert to joined list
  # of "symbol1  : value1, symbol2  : value2, ..."
  def ext_attributes(values)
    ext_attrib_list = []
    values.each do |key, value|
      ext_attrib_list << "#{key.to_s}    : #{value}"
    end

    result = ext_attrib_list.join(",\n")  
    return result
  end
  
  
  def help_me_pls
    "Help me!!!"
  end
end
