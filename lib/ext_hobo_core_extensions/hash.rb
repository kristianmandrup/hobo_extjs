module ExtHoboCoreExtensions
  module Hash

    def except(*blacklist)
      {}.tap do |h|
        (keys - blacklist).each { |k| h[k] = self[k] }
      end
    end

    def only(*whitelist)
      {}.tap do |h|
        (keys & whitelist).each { |k| h[k] = self[k] }
      end
    end
  end
end