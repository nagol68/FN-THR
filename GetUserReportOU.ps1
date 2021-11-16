$OUpaths = 'OU=Sioux City,OU=Thrasher,DC=TBS,DC=local'

Get-ADUser -Filter * -SearchBase $OUpaths -Properties *| 
    Select Name, @{n='Manager';e={(Get-ADUser $_.manager).name}}, Office, Department, Description, Title, Enabled |
    Export-Csv "C:\Users\lmccarthy-admin\Desktop\Users - Sioux City.csv" -NoTypeInformation