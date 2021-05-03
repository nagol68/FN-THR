#
##
###
####
##### Run On SERVER-O365
####
###
##
#

#Variables
$index = 0

Clear-Host

#Gets input and splits by section
$ticketInput = Read-Host "`nPlease paste entire ticket"
$ticketArray = $ticketInput -Split("###")

#Gets name
$index = 4
$name = $ticketArray[$index].Split([string[]]"`r`n", [StringSplitOptions]::None)[1]

#Gets title
$index = 6
$title = $ticketArray[$index].Split([string[]]"`r`n", [StringSplitOptions]::None)
if($title[3] -eq "Other"){
	$index++
	$title = $ticketArray[$index]
	$title = $title.Split([string[]]"`r`n", [StringSplitOptions]::None)[1]
	} else {
	$title = $title[3]
}

#Gets Department
$index++
$department = $ticketArray[$index].Split([string[]]"`r`n", [StringSplitOptions]::None)[3]

#Gets Manager
$index++
$manager = $ticketArray[$index].Split([string[]]"`r`n", [StringSplitOptions]::None)[3]
$manager = $manager.Split("<")[1]
$manager = $manager.Split(">")[0]

#Gets Location
$index++
$location = $ticketArray[$index].Split([string[]]"`r`n", [StringSplitOptions]::None)[3]

#Gets phone number
$index += 2
#
# ADD THIS
#	Will likely require manual input
#		Could check entire ticket for phone numbers, then add. Will look into later
#
$index++

#Gets workstation info
index += 2
$computer = $ticketArray[$index].Split([string[]]"`r`n", [StringSplitOptions]::None)
if($computer[0] -eq "Workstation")
{
	
	
	index += 5 #gets passed dist groups, temp skip
}

#Gets Teams
index++
$TeamsToAdd = $ticketArray[index].Split([string[]]"`r`n", [StringSplitOptions]::None) #Split multi-lined string into list 
$TeamsToAdd = $TeamsToAdd[3..($TeamsToAdd.Length-2)]

#Gets SharePoint

#Skipping for now
index += 2

#Gets Notes
index++
$notes = $ticketArray[index]

Clear-Host

$name
 

