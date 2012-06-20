Write-Host "Downloading and installing 7-zip."
iex ((New-Object net.webClient).DownloadString('https://raw.github.com/awmckinley/psScripts/master/Install-7Zip.ps1'))

Write-Host "Downloading and installing the Chocolatey package manager."
iex ((New-Object net.webClient).DownloadString('https://raw.github.com/awmckinley/chocolatey/master/chocolateyInstall/InstallChocolatey.ps1'))

Write-Host "Ensuring that ILMerge is installed."
cinstm ilmerge

Write-Host "Ensuring that Ruby is installed."
cinstm ruby

# Reload the environment path to include the path to Ruby
$env:Path = [System.Environment]::GetEnvironmentVariable("PATH", "Machine")

Write-Host "Ensuring that RubyGems is at the latest version."
gem update --system

Write-Host "Installing the necessary gems."
gem install rake
gem install bundler
bundle install

Write-Host "Running additional preparations."
rake prepare

Write-Host "Done! Happy coding!"