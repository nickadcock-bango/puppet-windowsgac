# windowsgac

#### Table of Contents

1. [Description](#description)
2. [Usage](#usage)

## Description
Adds and removes assemblies in the .NET Framework Global Assembly Cache (GAC)

## Usage
Ensures assembly at path $assemblypath is installed into the GAC

```puppet
windowsgac::gacassembly { $assemblypath:
    ensure => present,
}
```

Ensures assembly at path $assemblypath is not installed into the GAC

```puppet
windowsgac::gacassembly { $assemblypath:
    ensure => absent,
}
```
