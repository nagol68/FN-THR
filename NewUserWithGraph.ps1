$authparams = @{
    ClientId     = '0aaf57ae-79a3-4734-8ae2-b20ce044d4fa'
    TenantId     = '20e6409c-b699-411b-8c99-290b59466444'
    ClientSecret = ('12-7Q~TkKMlCkT.3VqATKreZMii-zCXvVZvN3' | ConvertTo-SecureString -AsPlainText -Force)
}
$auth = Get-MsalToken @authParams

Connect-MsolService -AdGraphAccessToken $auth