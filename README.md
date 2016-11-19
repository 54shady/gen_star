# 脚本命名

- genk generate kernel image
- gens generate system image
- genc generate kernel dot config file
- genr generate ramdisk image
- genb generate boot image

# 最新genc已经需要带参数操作具体操作如下

	genc 等价与make menuconfig
	genc -r 等价与make savedefconfig

# 使用方法

将脚本加上执行权限

	chmod a+x genk

放到环境变量中,比如在.bashrc中设置了PATH

	export PATH=$PATH:/home/zeroway/mytools

将脚本放到/home/zeroway/mytools目录下

在android源代码顶层目录下执行genk来编译内核代码

还可以在vim中来调用genk,比如

	:!genk

或者是写一个映射,这样在vim中修改完内核代码后

直接按<F9>就能编译内核,映射如下,可以写入到vimrc里

	noremap <F9> :!genk

## genr使用方法

### 解压ramdisk.img到当前目录下tmp目录里

	genr -r /path/ramdisk.img

### 打包当前tmp里的文件到ramdisk.img

	genr
