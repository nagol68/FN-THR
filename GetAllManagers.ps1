Get-ADUser -Filter * -SearchBase 'OU=Supportworks,DC=TBS,DC=local' -Properties *| Select name, @{n='Manager';e={(Get-ADUser $_.manager).name}} | Export-Csv "C:\Users\fivenines\Desktop\DirectReports.csv" -NoTypeInformation