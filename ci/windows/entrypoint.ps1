# Check if config exists, throw an error if not
if (-not (Test-Path 'C:\runner\'))
{
  throw 'Forgejo Runner config directory is not found!'
};

# Grant the Users group a privilege to modify any file
Enable-NtTokenPrivilege SeBackupPrivilege,SeRestorePrivilege;
Write-Host 'User privileges granted'

# Get current directory permissions
$existing = [Security.AccessControl.DirectorySecurity]::new('C:\runner', 'Access')

# Set desired directory permissions
$required = [Security.AccessControl.FileSystemRights]'ReadAndExecute, Write'

if (-not ($existing.Access | Where-Object {
      $_.IdentityReference  -eq 'BUILTIN\Users' -and
      $_.AccessControlType  -eq 'Allow'         -and
      ($_.FileSystemRights -band $required) -eq $required
    }))
{
  $existing.AddAccessRule([Security.AccessControl.FileSystemAccessRule]::new(
      'BUILTIN\Users', 'Modify', 'ContainerInherit, ObjectInherit', 'None', 'Allow'
    ))
  [IO.Directory]::SetAccessControl('C:\runner', $existing)
  Write-Host 'Config directory permissions modified'
} else
{
  Write-Host 'Config directory permissions are already sufficient'
}

# Take back that privilege
Remove-NtTokenPrivilege SeBackupPrivilege,SeRestorePrivilege;
Write-Host 'User privileges removed'

# Launch!
C:\forgejo-runner.exe daemon -c C:\runner\config.yml
