# 脚本命名

genk generate kernel image

gens generate system image

genc generate kernel dot config file

genr generate ramdisk image

# 最新genk已经需要带参数操作具体操作如下

	genk -4 编译3.10.49
	genk -5 编译3.10.79

# 使用方法

因为脚本中的所有路径都写成了绝对路径

所以只要将脚本加上执行权限

放到环境变量中,比如在.bashrc中设置了PATH

	export PATH=$PATH:/home/zeroway/mytools

将脚本放到/home/zeroway/mytools目录下

	chmod a+x genk

在任意路径下都可以通过执行genk来编译内核代码

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
