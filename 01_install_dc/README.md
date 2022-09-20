#01 Installing the Domain Controller

1. Use `sconfig` to:
    - Change the hostname
    - Change the IP Address to static
    - Change the DNS server to our own IP Address

2. Install the Active Directory Windows Feature

    Install-windowsfeature AD-Domain-Services -IncludemanagementTools

    import-Module ADDSDeployment

    install-ADDSForest

    DomainName: OuterHeaven.com
    Password: ******** `OPSEC`


    

3. Create Snapshot of DC and change DNS on DC
    
      Set-DnsClientServerAddress -InterfaceIndex 4 -ServerAddress 192.168.159.155


4. Create clone of Management CLient and call it WS01

5. Join Ws01 to Domain
    Set-DnsClientServerAddress -InterfaceIndex 6 -ServerAddress 192.168.159.155


    Add-Computer -DomainName OuterHeaven.com -Credential OuterHeaven\Administrator -Force -Restart

    `Enter Password COmputer Should Restart and Join Domain`


6. Create Snapshot of WS01


