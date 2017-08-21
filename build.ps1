$WorkingDir = $env:AGENT_WORKFOLDER
if (-not (get-command hugo -ErrorAction SilentlyContinue)) {
    invoke-webrequest -UseBasicParsing -Uri 'https://github.com/gohugoio/hugo/releases/download/v0.26/hugo_0.26_Windows-64bit.zip' -OutFile $WorkingDir/hugo.zip
    Unblock-File $WorkingDir/hugo.zip
    mkdir $WorkingDir/bin -force
    Expand-Archive -Path $WorkingDir/hugo.zip -DestinationPath $WorkingDir/bin
    $env:Path += ";$WorkingDir/bin"
}

hugo -d ./public/staging -b "http://minimallyviable-staging.azurewebsites.net/" 
hugo -d ./public/prod
