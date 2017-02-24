# 如何使用编译好的静态库进行编译链接
## Ubuntu
Ubuntu下的静态库和动态库文件（如libbsoncxx.a和libbsoncxx.so等）
存放在 /usr/local/lib/文件夹下。

这里以对MongoDB Cxx驱动官方文档上对驱动进行测试的代码 test.cpp 进行编译为例，
简单说明和编译有关的一些选项

编译命令如下

     c++ --std=c++11 test.cpp -o test $(pkg-config --cflags --libs --static libmongocxx) -l pthread

这里比较关键的是要指明使用C++11标准

    --std=c++11

另外就是指明链接选项。pkg-config在这里的作用相当于提供库的名字，
它可以帮你生成可直接用于g++的链接选项命令。你也可以直接运行 pkg-config 对其输出进行查看，
如果你不使用 pkg-config ，这些输出的链接命令选项基本也就是你要输入的。
这里的 libmongocxx 就是在指明要链接的库。
以下三个 pkg-config 选项比较重要，详见 pkg-config --help

    --cflags --libs --static

另外还注意要加上有关多线程的系统标准库

    -l pthread

## Windows
Windows下的驱动文件直接放在 C:\mongo-c-driver\ 
和C:\mongo-cxx-driver\，要使用其中的静态库进行编译时需要对Visual Studio进行一些设置，
这里以编译官方文档上对驱动进行测试的代码 test.cpp 为例进行简单介绍。

**注意：该方法只在1.4.2版C驱动，3.0.3版C++驱动和3.2版MongoDB上测试过，
在新版驱动上还未进行过成功测试**

首先在Visual Studio里，将编译方式设为x64。

然后打开项目属性 > VC++目录，
在这里选择“包含目录”（IncludePath），在这里添加5个目录，分别为：

* boost所在的目录（例如C:\boost_1_63_0）
* C:\mongo-cxx-driver\include\mongocxx\v_noabi
* C:\mongo-cxx-driver\include\bsoncxx\v_noabi
* C:\mongo-c-driver\include\libmongoc-1.0
* C:\mongo-c-driver\include\libbson-1.0

然后在下面的“库目录”（LibraryPath）里添加两个目录：

* C:\mongo-cxx-driver\lib
* C:\mongo-c-driver\lib

接下来在项目属性的 C/C++ > 预处理器 里面，在“预处理器定义”（PreprocessorDefinitions）
里面添加如下内容：

    MONGOCXX_STATIC;
    BSONCXX_STATIC;
    _DEBUG;
    _CONSOLE;

最后在项目属性的 链接器 > 输入 里面，对“附加依赖项”（AdditionalDependencies）
里面添加如下内容：

    bcrypt.lib;
    secur32.lib;
    crypt32.lib;
    ws2_32.lib;
    libmongocxx.lib;
    libbsoncxx.lib;
    mongoc-static-1.0.lib;
    bson-static-1.0.lib;

一般来说，进行这些设置后，就可以编译链接MongoDB C++和C驱动的静态库了。
