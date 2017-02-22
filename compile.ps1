$isMSBuildThere = test-path C:\Windows\Microsoft.NET\Framework64\v4.*\MSBuild.exe
if(!$isMSBuildThere) {
    Write-Error 'MSBuild.exe not found in C:\Windows\Microsoft.NET\Framework64\v4.x\'
    exit
}

$isBoostInstalled = test-path C:\boost*
if(!$isBoostInstalled) {
    Write-Error 'boost library not found in C:\'
    exit
}

try {
    git
}
catch {
    Write-Error 'git not installed or not in the PATH'
    exit
}

try {
    git clone https://github.com/mongodb/mongo-c-driver.git
    Set-Location -Path mongo-c-driver\
    git checkout 1.4.2 

    Set-Location -Path src\
    rm -r libbson
    git clone https://github.com/mongodb/libbson.git 
    Set-Location -Path libbson
    git checkout 1.4.2

    cmake -G "Visual Studio 14 2015 Win64" "-DCMAKE_INSTALL_PREFIX=C:\mongo-c-driver"
    C:\Windows\Microsoft.NET\Framework64\v4.*\MSBuild.exe ALL_BUILD.vcxproj
    C:\Windows\Microsoft.NET\Framework64\v4.*\MSBuild.exe INSTALL.vcxproj

    Set-Location -Path ..\..
    cmake -G "Visual Studio 14 2015 Win64" "-DCMAKE_INSTALL_PREFIX=C:\mongo-c-driver" "-DBSON_ROOT_DIR=C:\mongo-c-driver"
    C:\Windows\Microsoft.NET\Framework64\v4.*\MSBuild.exe ALL_BUILD.vcxproj
    C:\Windows\Microsoft.NET\Framework64\v4.*\MSBuild.exe INSTALL.vcxproj

    Set-Location -Path ..
    git clone https://github.com/mongodb/mongo-cxx-driver.git 
    Set-Location -Path mongo-cxx-driver
    git checkout 3.0.3

    New-Item cmakeInstructions.ps1 -type file
    $boostDirName = Get-ChildItem -name C:\boost_*
    "cmake -G `"Visual Studio 14 Win64`" -DCMAKE_INSTALL_PREFIX=C:\mongo-cxx-driver -DLIBBSON_DIR=C:\mongo-c-driver -DBOOST_ROOT=C:\$boostDirName -DLIBMONGOC_DIR=C:\mongo-c-driver -DBSONCXX_POLY_USE_BOOST=1" | Out-File cmakeInstructions.ps1
    .\cmakeInstructions.ps1
    rm cmakeInstructions.ps1
    C:\Windows\Microsoft.NET\Framework64\v4.*\MSBuild.exe ALL_BUILD.vcxproj
    C:\Windows\Microsoft.NET\Framework64\v4.*\MSBuild.exe INSTALL.vcxproj
}
catch {
    exit
}