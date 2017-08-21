Puppet::Type.newtype(:windowsgac_assembly) do
    @doc = 'Manages an assembly within the Global Assembly Cache'
    
    ensurable

    newparam(:path, :namevar => true) do
        desc 'Fully qualified name of assembly to manage'
        validate do |value|
            unless value.kind_of?(String)
              fail("Invalid value '#{value}'. Should be a string")
            end

            unless File.file?(value)
                fail("Assembly at path '#{value}' does not exist")
            end
        end
    end
end