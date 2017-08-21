class WindowsGacScripts
    def self.get_exist_script(assembly_path)
        return "
            $full_name = [System.Reflection.AssemblyName]::GetAssemblyName('#{assembly_path}').FullName
            [System.Reflection.Assembly]::Load($full_name)
        "
    end

    def self.get_create_script(assembly_path)
        return "
            #{self.get_enterprise_services}
            $publish.GacInstall('#{assembly_path}')
        "
    end

    def self.get_destroy_script(assembly_path)
        return "
            #{self.get_enterprise_services}
            $publish.GacRemove('#{assembly_path}')
        "
    end

    private
    def self.get_enterprise_services
        return "
            [System.Reflection.Assembly]::Load('System.EnterpriseServices, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a')
            $publish = New-Object System.EnterpriseServices.Internal.Publish
        "
    end
end