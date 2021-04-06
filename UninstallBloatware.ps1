# Get the list of Provisioned packages if needed
# Get-AppxProvisionedPackage -online | select packagename

# Remove packages that start with the Match string for All Users
Get-AppxProvisionedPackage -online | %{if ($_.packagename -match "Microsoft.Office.Desktop") {$_ | Remove-AppxProvisionedPackage -AllUsers}}
Get-AppxProvisionedPackage -online | %{if ($_.packagename -match "Microsoft.Office.OneNote") {$_ | Remove-AppxProvisionedPackage -AllUsers}}
Get-AppxProvisionedPackage -online | %{if ($_.packagename -match "Microsoft.Xbox") {$_ | Remove-AppxProvisionedPackage -AllUsers}}
Get-AppxProvisionedPackage -online | %{if ($_.packagename -match "Microsoft.SkypeApp") {$_ | Remove-AppxProvisionedPackage -AllUsers}}
Get-AppxProvisionedPackage -online | %{if ($_.packagename -match "Microsoft.Zune") {$_ | Remove-AppxProvisionedPackage -AllUsers}}
Get-AppxProvisionedPackage -online | %{if ($_.packagename -match "Microsoft.MicrosoftOffice") {$_ | Remove-AppxProvisionedPackage -AllUsers}}


# Get the list of other packages if needed
# get-appxpackage | select name

# Remove packages that start with the Match string for All Users
Get-AppxPackage | %{if ($_.name -match "Microsoft.zune") {$_ | Remove-AppxPackage -AllUsers}}
Get-AppxPackage | %{if ($_.name -match "microsoft.skypeapp") {$_ | Remove-AppxPackage -AllUsers}}

# Unpin everything
(New-Object -Com Shell.Application).NameSpace('shell:::{4234d49b-0245-4df3-b780-3893943456e1}').Items()| foreach { ($_).Verbs() | ?{$_.Name.Replace('&', '') -match 'From "Start" UnPin|Unpin from Start'} | %{$_.DoIt()}  }
 