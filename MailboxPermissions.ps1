#
# Paste entire list of users between a single set of quotes
#

$users = "EMAILS"

$users = $users.Split([string[]]"`r`n", [StringSplitOptions]::None)

ForEach ($user in $users) {

    Set-MailboxFolderPermission `
        ${user}:\Calendar `
        -user Default `
        -AccessRights Reviewer

    Add-MailboxFolderPermission `
        ${user}:\Calendar `
        -user ThrasherDefaultAuthor@gothrasher.com `
        -AccessRights Reviewer

}