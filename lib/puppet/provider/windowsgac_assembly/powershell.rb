require_relative '../../../puppet_x/windowsgac_scripts'

Puppet::Type.type(:windowsgac_assembly).provide(:powershell) do
    confine :osfamily => :windows
    commands :powershell => "powershell.exe"

    def exists?
        assembly_path = resource[:path]

        begin
            script = WindowsGacScripts.get_exist_script(assembly_path)
            powershell(script)
            return true
        rescue Puppet::ExecutionFailure => e
            return false
        end
    end

    def create
        assembly_path = resource[:path]
        script = WindowsGacScripts.get_create_script(assembly_path)
        powershell(script)
        return true
    end

    def destroy
        assembly_path = resource[:path]
        script = WindowsGacScripts.get_destroy_script(assembly_path)
        powershell(script)
        return true
    end
end