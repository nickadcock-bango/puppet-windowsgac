Puppet::Type.type(:windowsgac_assembly).provide(:powershell) do
    confine :osfamily => :windows
    commands :powershell => "powershell.exe"

    def exists?
        assembly_path = resource[:path]

        begin
            script = "
            $full_name = [System.Reflection.AssemblyName]::GetAssemblyName('#{assembly_path}').FullName
            [System.Reflection.Assembly]::Load($full_name)"
            powershell(script)
            return true
        rescue Puppet::ExecutionFailure => e
            return false
        end
    end

    def create
        assembly_path = resource[:path]
        script = "
        [System.Reflection.Assembly]::Load('System.EnterpriseServices, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a')
        $publish = New-Object System.EnterpriseServices.Internal.Publish
        $publish.GacInstall('#{assembly_path}')"
        powershell(script)
        return true
    end

    def destroy
        assembly_path = resource[:path]
        script = "
        [System.Reflection.Assembly]::Load('System.EnterpriseServices, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a')
        $publish = New-Object System.EnterpriseServices.Internal.Publish
        $publish.GacRemove('#{assembly_path}')"
        powershell(script)
        return true
    end
end