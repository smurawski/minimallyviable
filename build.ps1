$WorkingDir = $env:AGENT_WORKFOLDER
if (-not (get-command hugo -ErrorAction SilentlyContinue)) {
    invoke-webrequest -UseBasicParsing -Uri 'https://github.com/gohugoio/hugo/releases/download/v0.26/hugo_0.26_Windows-64bit.zip' -OutFile $WorkingDir/hugo.zip
    Unblock-File $WorkingDir/hugo.zip
    mkdir $WorkingDir/bin -force
    Expand-Archive -Path $WorkingDir/hugo.zip -DestinationPath $WorkingDir/bin
    $env:Path += ";$WorkingDir/bin"
}

if (Test-Path ./public) {
    Remove-Item -Path ./public -Recurse -Force
} 

hugo -d ./public/staging -b "http://staging.minimallyviable.io/" 
hugo -d ./public/prod -b "http://minimallyviable.io/"
