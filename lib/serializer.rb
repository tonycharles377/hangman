require 'yaml'

module Serializer
    @@serializer = YAML

    def serialize
        obj = {}

        instance_variables.map do |var|
            obj[var] = instance_variable_get(var)
        end

        @@serializer.dump obj
    end

    def deserialize(string)
        obj = @@serialize.parse(string)

        obj.keys.each do |key|
            instance_variable_set(key, obj[key])
        end
    end
end