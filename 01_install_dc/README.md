#01 Installing the Domain Controller

1. Use `sconfig` to:
    - Change the hostname
    - Change the IP Address to static
    - Change the DNS server to our own IP Address

2. Install the Active Directory Windows Feature

    Install-windowsfeature AD-Domain-Services -IncludemanagementTools

    