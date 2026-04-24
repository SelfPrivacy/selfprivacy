FROM mcr.microsoft.com/windows/servercore:ltsc2025-amd64 AS base

USER ContainerAdministrator
WORKDIR "C:\\"

# Install Chocolatey
RUN powershell -Command \
    "Set-ExecutionPolicy Bypass -Scope Process -Force; \
    [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; \
    iex ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))"

# Install base dependencies
RUN choco install -y git.install --params \
    "'/GitOnlyOnPath /NoAutoCrlf /SChannel /NoOpenSSH /Symlinks'" \
    && choco install -y nodejs-lts --version=24.15.0

# Install Flutter
RUN choco install -y flutter --version=3.35.7

# Install MSVC
RUN choco install -y visualstudio2022buildtools --params \
    "'--add Microsoft.VisualStudio.Workload.VCTools \
    --add Microsoft.VisualStudio.Component.VC.ATL \
    --add Microsoft.VisualStudio.Component.VC.142.x86.x64 \
    --add Microsoft.VisualStudio.Component.VC.Tools.x86.x64 \
    --add Microsoft.VisualStudio.Component.VC.CMake.Project \
    --add Microsoft.VisualStudio.Component.Windows10SDK.19041'"

FROM base AS runner

USER ContainerAdministrator
WORKDIR "C:\\"

# Allow NTFS symlinks and Git long paths support needed for Flutter
# Simply adds Users group to the list of allowed SIDs to make symlinks
RUN powershell -Command \
    "secedit /export /cfg security.inf; $content = Get-Content security.inf; \
    $content = $content -Replace '(SeCreateSymbolicLinkPrivilege\s*=\s*)(.*)', ('$1$2,' + '*S-1-5-32-545'); \
    $content | Out-File security.inf; secedit /configure /db security.sdb /cfg security.inf; \
    Remove-Item security.sdb, security.inf, security.jfm -ErrorAction SilentlyContinue; \
    New-ItemProperty -Path 'HKLM:\System\CurrentControlSet\Control\FileSystem' -Name 'LongPathsEnabled' -Value 1 -PropertyType DWORD -Force; \
    git config --system core.longpaths true"

# Allow non-privileged Users to use Flutter
RUN flutter --version \
    && icacls "C:\tools\flutter" /grant Users:F /t /c /q \
    && git config --system --add safe.directory "C:\tools\flutter"

# Download Forgejo Runner
RUN curl -L "https://github.com/Crown0815/Forgejo-runner-windows-builder/releases/download/v12.8.2/forgejo-runner-windows-amd64.exe" \
    --skip-existing -o forgejo-runner.exe

# A scheduled task as an utility for unprivileged users to change permissions at runtime
RUN powershell -Command \
    # Register a task \
    "$action = New-ScheduledTaskAction -Execute 'cmd.exe' -Argument '/c icacls C:\runner\config.yml /grant ''Users:F'' /t /c /q'; \
    $principal = New-ScheduledTaskPrincipal -UserId 'ContainerAdministrator' -RunLevel Highest; \
    Register-ScheduledTask -TaskName 'FixRunnerPermissions' -Action $action -Principal $principal; \
    # Grant access for Users to run the task using COM \
    $scheduler = New-Object -ComObject Schedule.Service; $scheduler.Connect(); \
    $task = $scheduler.GetFolder('\').GetTask('FixRunnerPermissions'); \
    $currentSddl = $task.GetSecurityDescriptor(0xF); $newSddl = $currentSddl + '(A;;0x1200a9;;;BU)'; \
    $task.SetSecurityDescriptor($newSddl, 0)"

RUN setx /m PATH "%PATH%;C:\tools\flutter\bin"

USER ContainerUser

ENTRYPOINT ["powershell", "-Command", \
    "$ErrorActionPreference = 'Stop'; $timeout = 30; $elapsed = 0; \
    # Check if config exists, throw error if not \
    if (-not (Test-Path 'C:\\runner\\config.yml')) { throw 'Forgejo Runner config is not found!' }; \
    # If file has Users with (F) rights, True \
    ((Get-Acl 'C:\\runner\\config.yml').Access | Where-Object { $_.IdentityReference -like '*Users*' -and $_.FileSystemRights -eq 'FullControl' }) \
    # If not, start the scheduled task to fix permissions \
    -or (schtasks /run /tn 'FixRunnerPermissions'); \
    # Wait for permissions to propagate and throw error if they don't \
    while (-not ((Get-Acl 'C:\\runner\\config.yml').Access | Where-Object { $_.IdentityReference -like '*Users*' -and $_.FileSystemRights -eq 'FullControl' })) \
        { if ($elapsed -ge $timeout) { throw 'Time out waiting for permissions fix' }; Start-Sleep 1; echo 'Waiting for permissions…'; $elapsed++ }; \
    # Launch! \
    C:\\forgejo-runner.exe daemon -c C:\\runner\\config.yml"]
