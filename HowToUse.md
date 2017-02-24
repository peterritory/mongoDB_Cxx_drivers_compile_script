# 如何使用编译好的静态库进行编译
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