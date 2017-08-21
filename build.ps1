if (-not get-command hugo -ErrorAction SilentlyContinue) {
    invoke-webrequest -UseBasicParsing -Uri https://github.com/gohugoio/hugo/releases/download/v0.26/hugo_0.26_Windows-64bit.zip -OutFile hugo.zip
    Unblock-File hugo.zip
    mkdir $env:UserProfile/bin -force
    Expand-Archive -Path hugo.zip -DestinationPath $env:UserProfile/bin
    $env:Path += ";$env:UserProfile/bin"
}

hugo -d ./public/staging -b "http://minimallyviable-staging.azurewebsites.net/" 
hugo -d ./public/prod

Compress-Archive .\public\* -DestinationPath site.zip