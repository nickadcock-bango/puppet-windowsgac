define windowsgac::gacassembly (
    $assemblypath = $name,
    $ensure,
) {
    $exists_script = sprintf('
        $full_name = [System.Reflection.AssemblyName]::GetAssemblyName("%s").FullName
            [System.Reflection.Assembly]::Load($full_name)
        ', $assemblypath)

    $get_enterprise_services_script = '
        [System.Reflection.Assembly]::Load("System.EnterpriseServices, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a")
        $publish = New-Object System.EnterpriseServices.Internal.Publish'
    
    if $ensure == present {
        $command = sprintf('
            %s; $publish.GacInstall("%s")
            ', $get_enterprise_services_script, $assemblypath)
        
        exec { "GacInstall($assemblypath)": 
            provider => powershell,
            command => $command,
            onlyif => "try { $exists_script; exit 1 } catch { exit 0 }"
        }   
    }
    else {
        $command = sprintf('
            %s; $publish.GacRemove("%s")
            ', $get_enterprise_services_script, $assemblypath)
        
        exec { "GacRemove($assemblypath)": 
            provider => powershell,
            command => $command,
            onlyif => $exists_script
        }   
    }
}