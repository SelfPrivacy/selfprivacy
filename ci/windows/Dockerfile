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

# Grant the Users group privileges to make symlinks and have elevated rights
# to read and modify files using NtObjectManager. Allow NTFS symlinks and Git
# long paths support needed for Flutter
RUN powershell -Command \
  "Install-PackageProvider -Name NuGet -MinimumVersion 2.8.5.201 -Force; \
  Install-Module NtObjectManager -RequiredVersion 2.0.1 -Force; \
  Import-Module NtObjectManager; \
  Add-NtAccountRight -Sid S-1-5-32-545 -Privilege SeBackupPrivilege,SeCreateSymbolicLinkPrivilege,SeRestorePrivilege; \
  New-ItemProperty -Path 'HKLM:\System\CurrentControlSet\Control\FileSystem' -Name 'LongPathsEnabled' -Value 1 -PropertyType DWORD -Force; \
  git config --system core.longpaths true"

# Allow non-privileged Users to use Flutter
RUN flutter --version \
    && icacls "C:\tools\flutter" /grant Users:F /t /c /q \
    && git config --system --add safe.directory "C:\tools\flutter"

# Download Forgejo Runner
RUN curl -L "https://github.com/Crown0815/Forgejo-runner-windows-builder/releases/download/v12.8.2/forgejo-runner-windows-amd64.exe" \
    --skip-existing -o forgejo-runner.exe

# Download nFPM
RUN curl -L "https://github.com/goreleaser/nfpm/releases/download/v2.46.3/nfpm_2.46.3_Windows_x86_64.zip" \
    --skip-existing -o nfpm.zip \
    && tar -xf nfpm.zip nfpm.exe \
    && del nfpm.zip

RUN setx /m PATH "%PATH%;C:\tools\flutter\bin;C:\\"

USER ContainerUser
COPY ./entrypoint.ps1 C:\\entrypoint.ps1
ENTRYPOINT ["powershell", "C:\\entrypoint.ps1"]
