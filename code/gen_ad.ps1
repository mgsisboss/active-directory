param( [Parameter(Mandatory=$true)] $JSONFile )

function CreateADGroup(){
    param( [Parameter(Mandatory=$true)] $groupObject )

    $name = $groupObject.name
    New-ADGroup -name $name -GroupScope Global
}

function CreateADuser(){
    param( [Parameter(Mandatory=$true)] $userObject )
    
    # Pull out the name from the JSON object
    $name = $userObject.name
    $password = $userObject.password

    # Generate a "first initial, last name' structure for actual username"
    $firstname, $lastname = $name.Split(" ")
    $username = ($firstname[0] + $lastname).ToLower()
    $samAccountName = $username
    $principalname = $username

    # Actually Create the AD User Group
     New-ADUser -Name "$name" -GivenName $firstname -Surname $lastname -SamAccountName $SamAccountName -UserPrincipalName $principalname@$Global:Domain -AccountPassword (ConvertTo-SecureString $password -AsPlainText -Force) -PassThru | Enable-ADAccount 

     # Add the user to its appropriate group 
     foreach($group_name in $userObject.groups) {

        try {
            Get-ADGroup -Identity “$group_name”
            Add-ADGroupMember -Identity $group_name -Members $username
         }
         catch [Microsoft.ActiveDirectory.Management.ADIdentityNotFoundException]
         {
            Write-Warning “user $name MOT added to group $group_name because it does not exist”
         }        
     }
}


$json = ( Get-Content $JSONFile | ConvertFrom-JSON)

$Global:Domain = $json.domain

foreach ( $group in $json.groups ){
    CreateADGroup $group
}

foreach ( $user in $json.users ){
    CreateADuser $user
}