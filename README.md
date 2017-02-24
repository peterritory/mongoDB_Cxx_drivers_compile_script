# mongoDB_Cxx_drivers_compile_script
## compile.sh
该脚本文件为在Ubuntu下运行的，而compile.ps1为Windows下的Powershell脚本，见下文。运行时需要输入root密码以安装一些依赖软件，
请保持网络畅通。请在运行该脚本的用户有写入权限的目录下，新建目录，
将该脚本装入其中并运行。运行完毕后，该目录中还会留下下载的驱动文件。

驱动编译后使用默认的安装路径，文件被分别放入 /usr/local/bin , /usr/local/include 和 /usr/local/lib

**注意：该脚本并未设置成自动安装最新版本的驱动，而是编写脚本时被测试可用的版本。
在新驱动进行手动编译测试后，才会将其版本号写入该脚本**

### 运行方法

    ./compile.sh

如果提示权限不够，可以尝试给脚本添加可执行权限

    sudo chmod +x compile.sh

运行时编译过程如果耗时过长，sudo make install 过程可能要求重新输入root密码

## compile.ps1 
该脚本为在Windows下运行的Powershell脚本，建议以管理员身份打开Powershell后执行该脚本。
新建一个文件夹，将脚本放入其中。请保持网络畅通。运行完毕后，该目录中还会留下下载的驱动文件。

**注意：由于新版MongoDB C++驱动在Windows下静态编译还未成功进行测试，
故这里使用1.4.2的C驱动和libbson，还有3.0.3版的C++驱动。该驱动最高支持MongoDB 3.2**

### 运行所需
* 需要安装.NET Framework 4.0+，脚本需要其安装目录里面的MsBuild.exe，默认认为其安装目录位于C:\Windows\Microsoft.Net\Framework64\v4.*里面

* 需要安装boost并将其放置在C:\下，如C:\boost_1_63_0\

* 需安装git，并将其添加到环境变量（即需要可以在Powershell中使用git命令运行git）

* 需安装cmake，并将其添加到环境变量（即需要可以在Powershell中使用cmake命令运行cmake）

### 运行方法

    .\compile.ps1

如果系统默认禁止了Powershell脚本的运行，请在以管理员身份打开的Powershell脚本中执行一下命令

    Set-Executionpolicy RemoteSigned