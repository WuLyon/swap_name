# swap_name
一个用于方便交换两个文件的名字的终端小工具-A little terminal utility for swapping the names of two files

## Background
这只是一个简单的练手项目，它所实现的功能和使用场景比较单一，可能对很多人来说也并不常见。

但由于我在工作中经常需要调整或更换一些配置文件，旧的配置文件需要留档或备份，因此实际操作中需要先将旧的配置文件重命名为一个临时的名字，再把新的文件更改为能够让程序读取的正确文件名。

为了避免这样繁琐的操作，我想将原来需要手动执行的两三步操作合并为一条指令就可以完成。实际使用起来可能并不会提高多少工作效率，但简化后的操作更**符合直觉**，能够减少工作时的脑力负担。（另外，作为一个初学者，使用自己开发的小工具也能比较让自己心情愉悦～～～祝各位使用愉快）

## Features
- 基本功能是一条命令交换两个文件的文件名
- 支持终端命令自动补全
- 轻量安装，干净卸载，卸载后不会留下任何注册表、配置、数据等文件(_毕竟它已经如此轻量了，也很难有什么多余的文件_)

## Install
- 在终端执行以下指令进行安装
```shell
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/WuLyon/swap_name/main/install.sh)"
```
> 注：请先确保环境中已安装curl，可以用`curl --version`检查。

执行后需要重新加载你的Shell配置文件，根据你使用的shell，选择下面其中一个执行即可。
```shell
source ~/.bashrc
```
```shell
source ~/.zshrc
```
然后就可以在终端使用swap_name命令了！

如果需要卸载，则执行以下指令：
```shell
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/WuLyon/swap_name/main/uninstall.sh)"
```

## Usage
```shell
swap_name <file1> <file2>
```
在终端执行上述指令即可，文件名使用相对路径或绝对路径都行。成功执行后结果如下图所示：
![执行结果](https://github.com/WuLyon/swap_name/raw/main/image/usage1.png)

## Update plan
### v_1.0.1
- [x] Add comments to the swap_name.py script.
- [x] Optimize the installation and uninstallation methods.
- [x] Refine the README documentation.
### v_1.1.0
- [ ] Add new feature: -b and -d arguments.