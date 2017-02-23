# mongoDB_Cxx_drivers_compile_script
## compile.sh
该脚本文件为在Ubuntu下运行的，而compile.ps1为Windows下的Powershell脚本，见下文。运行时需要输入root密码以安装一些依赖软件，
请保持网络畅通。请在运行该脚本的用户有写入权限的目录下，新建目录，
将该脚本装入其中并运行。运行完毕后，该目录中还会留下下载的驱动文件。

驱动编译后使用默认的安装路径，文件被分别放入 /usr/local/bin , /usr/local/include 和 /usr/local/lib

**注意：该脚本并未设置成自动安装最新版本的驱动，而是编写脚本时被测试可用的版本。
在新驱动进行手动编译测试后，才会将其版本号写入该脚本**

运行方法

    ./compile.sh

如果提示权限不够，可以尝试给脚本添加可执行权限

    sudo chmod +x compile.sh

运行时编译过程如果耗时过长，sudo make install 过程可能要求重新输入root密码