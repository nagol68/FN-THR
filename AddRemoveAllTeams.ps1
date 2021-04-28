#
# !!!Must call Connect-MicrosoftTeams before running!!!
#
# Paste entire list of Teams between single set of quotes
#

$TeamsToAdd = "FN: Testing Grounds
Garden Club - Admin
Garden Club 2020
Garden Club 2021
H: Hello Garage HQ
H: Hello Garage Mall Showroom
Hello Garage Referral Cards
HQ Omaha
S: Creative
S: Dealer Performance Directors
S: Design
S: Garage Corporate Store
S: Marketing and Creative
S: Production Training
S: Redefine Conference
S: Ripple
S: Sales and Business Development
S: Software Pre-Release
S: Supportworks
S: Supportworks Software
S: Technology
S: Training and Development
S: Training and Development, Business Development, Sales
S: Training and Events
Supportworks Conceptual
T: 911 Customer Alerts
T: Accounting and Finance
T: Accounts Receivable
T: Action Items - Coord/Mgr
T: Appointment Rescheduling
T: Backup Phone Support
T: Brand Ambassadors
T: BRO-Tang Clan
T: Business Dev TCG
T: Calendar Review
T: Cell Phone Issues and Requests
T: Concrete Repair Training Blitz
T: Coordinator Chatter
T: Customer Care
T: Customer Financing
T: Dehire
T: Delta Team
T: Des Moines 911
T: Employee Relations Team
T: Equipment
T: ER/Recruitment-Hires
T: Finance Team
T: Fishbowl
T: Future AM Scheduling
T: General Managers
T: Gutter Shutter
T: Hello Garage of KC
T: Leadership Immersion 2020
T: Leadership Immersion 2021
T: Leadership Team
T: Learning Ops Des Moines
T: Learning Ops Grand Island
T: Learning Ops Kansas City
T: Learning Ops Omaha
T: Learning Ops Sioux City
T: Learning Ops Springfield
T: Learning Ops Wichita
T: Management Team
T: Marketing
T: Marketing and Customer Care Updates
T: Men In Blue
T: New Hire
T: New-Hire Sales and Service
T: Omaha BU Leadership Team
T: One Team Des Moines
T: One Team Grand Island
T: One Team Kansas City
T: One Team Omaha
T: One Team Sioux City
T: One Team Springfield
T: One Team TCG
T: One Team Wichita
T: PolyLEVEL Maintenance
T: Pro Pack
T: Production and Warehouse
T: Production Des Moines
T: Production Grand Island
T: Production Kansas City
T: Production Omaha
T: Production Schedule Changes
T: Production Sioux City
T: Production Springfield
T: Production TCG
T: Production Wichita
T: Project Management Production
T: Project Management Team
T: Project Management Team
T: Project Scheduling
T: Sales and Service Collections
T: Sales and Service Des Moines
T: Sales and Service Grand Island
T: Sales and Service Kansas City
T: Sales and Service Sioux City
T: Sales and Service Springfield
T: Sales and Service Wichita
T: Sales Omaha
T: Sales Training
T: Service Omaha
T: Service Training
T: Spanish Help for Customer Care
T: Special Promotions
T: Supply Chain
T: Team Thrasher - All
T: The Machines
T: Thrasher Office Omaha
T: Thrasher Technology
T: Waterproofing and Wall Repair Training Blitz
T: Whiteboard - CC and Marketing"

$User = "EMAIL"

$TeamsToAdd = $TeamsToAdd.Split([string[]]"`r`n", [StringSplitOptions]::None)

$TeamsIDs = ForEach ($Team in $TeamsToAdd) {
    $TeamID = Get-Team -DisplayName $Team | Where {$_.DisplayName -match "$Team$"} | Select -expand GroupID
    # Change to Remove-TeamUser if removing
	Add-TeamUser -GroupId $TeamID -User $User -Role Owner
}

