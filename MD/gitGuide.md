## 1.Linux基础知识

   - 什么是Linux
    + `Linux作者：林纳斯·托瓦兹`
        林纳斯·本纳第克特·托瓦兹（Linus Benedict Torvalds, 1969年~ ），著名的电脑程序员、黑客。Linux内核的发明人及该计划的合作者。
     托瓦兹利用个人时间及器材创造出了这套当今全球最流行的操作系统（作业系统）内核之一。现受聘于开放源代码开发实验室（OSDL：Open Source Development Labs, Inc），全力开发Linux内核。
        Linux是一套免费使用和自由传播的类Unix操作系统，是一个基于POSIX和UNIX的多用户、多任务、支持多线程和多CPU的操作系统。它能运行主要的UNIX工具软件、应用程序和网络协议。
     它支持32位和64位硬件。Linux继承了Unix以网络为核心的设计思想，是一个性能稳定的多用户网络操作系统。
        Linux操作系统诞生于1991 年10 月5 日（这是第一次正式向外公布时间）。Linux存在着许多不同的Linux版本，但它们都使用了Linux内核。
        Linux可安装在各种计算机硬件设备中，比如手机、平板电脑、路由器、视频游戏控制台、台式计算机、大型机和超级计算机。
      严格来讲，Linux这个词本身只表示Linux内核，但实际上人们已经习惯了用Linux来形容整个基于Linux内核，并且使用GNU 工程各种工具和数据库的操作系统`
   - 如何模拟Linux
     + 我们需要通过gitBash工具模拟Linux
     + gitBash下载地址：[下载地址](http://git-scm.com/download/win)
      - Windows安装:
        + 下载Git客户端软件，和普通软件安装方式一样。
      - Linux安装
        + CentOS发行版：sudo yum install git
        + Ubuntu发行版：sudo apt-get install git
      - Mac安装
        + 打开Terminal直接输入git命令，会自动提示，按提示引导安装即可。
   - 如何学习更多的Git知识
     + 通过 git --help
     + 网站
        - http://www.liaoxuefeng.com/wiki/0013739516305929606dd18361248578c67b8067c8c017b000
        - http://backlogtool.com/git-guide/cn/
        - http://www.ruanyifeng.com/blog/2015/12/git-cheat-sheet.html
        - http://rogerdudler.github.io/git-guide/index.zh.html
        - https://git-scm.com/book/zh/v2

## 2.Shell 
   - 什么是shell
    +   在计算机科学中，Shell俗称壳，用来区别于Kernel（核），是指“提供使用者使用界面”的软件（命令解析器）。
       它类似于DOS下的command和后来的cmd.exe。它接收用户命令，然后调用相应的应用程序。
   -  shell分类
    + 图形界面shell: 通过提供友好的可视化界面，调用相应应用程序，如windows系列操作系统，Linux系统上的图形化应用程序GNOME、KDE等。
    + 命令行shell：通过键盘输入特定命令的方式，调用相应的应用程序，如windows系统的cmd.exe、Windows PowerShell，Linux系统的Bourne shell ( sh)、Bourne Again shell ( bash)等
   - shell命令
	+  就是围绕增删查改
    +  pwd (Print Working Directory) 查看当前目录
    +  cd (Change Directory) 切换目录，如 cd /etc
    +  ls (List) 查看当前目录下内容，如 ls -al,“.”(表示当前目录)和“..”(表示当前目录的父目录)。
    +  mkdir (Make Directory) 创建目录，如 mkdir blog
    +  touch 创建文件，如 touch index.html
    +  echo >>追加文件 >重新添加一行
    +  wc (Word Count) 字数信息统计，如 wc index.html
    +  cat 查看文件全部内容，如 cat index.html
    +  more less 查看文件，如more /etc/passwd、less /etc/passwd  不用学习
    +  rm (remove) 删除文件，如 rm index.html、rm -rf  blog
    +  rmdir (Remove Directory) 删除文件夹，只能删除空文件夹，不常用
    +  mv (move) 移动文件或重命名，如 mv index.html ./demo/index.html
    +  cp (copy) 复制文件，cp index.html ./demo/index.html
    +  head 查看文件前几行，如 head -5 index.html
    +  tail 查看文件后几行 –n –f，如 tail index.html、tail -5 index.html 
    +  history 查看操作历史
    +  whoami 查看当前用户
## 3.Git简单介绍
  - 什么是Git
    + Git是一款源代码管理工具（版本控制工具）
    + 什么又是源代码：凡是由我们手写的代码都称之为源代码
    + 源代码有必要管理起吗？
        - 有必要，因为人工的去处理不同的版本，做相应备份会比较麻烦。
        - Git是linux之父当年为了维护linux---linus之前也是手动维护合并把文件发给Linus
  - 集中式和分布式
    + 集中式：Svn
    + 分布式：Git
## 4.Git命令使用
   - Git初次使用添加用户名和邮箱 
     + 配置用户名：` git config --global user.name "你的用户名" `
     + 配置邮箱  ：` git config --global user.email "你的邮箱" `
     + 删除错误配置  ：` git config --global --unset   "错误的key删除掉" `
     + 查看配置  ：` git config --list `
     + 去任何一家公司现完成上面的步骤
   - 初始化一个空的仓储
     + 初始化空仓储:` git init `
     + 这个命令会在当前目录中新建一个隐藏的名为.git的文件夹,里面存储的是项目的各个版本。
     + 千万不要更改.git目录里文件。 
   - 查看当前目录文件的状态
       + 命令  : ` git status ` 
         - 查看当前工作目录的状态，是已经放到暂存区，还是提交到仓库了。
       + 或命令: ` git status -s ` 查看简要的状态信息
   - 将文件添加到暂存区
       + 命令: ` git add ./file.txt`
         - 将当前目录中的file.txt添加到暂存区
       + 或者: ` git add .`
         - 表示将当前目录所有文件都添加的暂存区.
         - 这是批量添加.
     + 可以对文件执行多次add命令，都会把最新的修改添加到暂存，但是，后页面执行add命令，会把前面执行add命令添加到暂存区的文件覆盖(相同的文件会覆盖)
   - 将文件添加到仓储中
      + 命令  : ` git commit -m "这次我添加了一个变量" `
         - -m 表示需要指定一个字符串，表示本次提交的代码与上一次相比多了哪些功能，或者是做了哪些修改。
         - 每次提交时都需要写上相应的字符串以做出说明
      + 或命令: ` git commit -m  -c`
         - -c 表示可以在提交时，不提供说明。
         - 不推荐这么做，不利于后期代码维护
         - 提交时只是提交暂存区的代码，没有添加到暂存区的代码不会提交
   -  查看日志
     + 命令:`git log`
     + 或命令:`git log --oneline`
     + 以图形化查看:`git log –graph`
   - 忽略文件
     + 不要省略/ 除非有必要
     + 需要新建一个名为:  .gitignore 的文件
     + 这个文件话.git同级目录.
       - 该文件用来告诉我们的git哪些文件不要被添加一仓储中。
       - 忽略某个目录:  /node_modules
       - 忽略某个文件:  /css/my.css
       - 忽略某一类文件:  /css/*.css
       - 忽略目录下所有文件:  *.*
       - 忽略所有名为node_modules的目录:  node_modules
       - \#号表示注释
   - 版本回退
     + 命令:`git reset --hard Head`
        - 回到最近一次提交的版本的文件状态
        - git指向的是上一次提交
        - 'git reset --hard Head^^ 表示回到最近往前第二次的提交'
        - Head后面的^表示回退到第几次
     + 命令: `git reset --hard Head~1`
        - 表示回到最近一次提交的前一次提交.
        - Head~2,回退到最近一次提交的前2次提交. 
     + 命令: `git reset --hard [版本号]`
        - 示例: `git reset --hard 12dad211` 
        - 回退到某个具体的版本。
        - 可以配合git reflog命令查看历史操作来进行回退 
     + 这里进行版本回退，并不会对文件进行真实的删除
        - 通过git reflog 可以查看到每一次对版本的切换来提交。
   - 创建Git分支，并切换分支
     + 正在做功能呢，才做了一半，但是为了不丢失代码要提交，又不能影响别人工作。
     + 查看有多少分支
        - `git branch`
     + 命令: git branch dev
        - 创建了一个名为dev的分支
     + 命令: git checkout dev
         - 切换到dev分支
     + 创建并切换到指定分支
       - `git checkout -b dev`
   - 合并Git分支
     + 画图
     + 命令: git merge dev
        - 表示将当前分支与dev分支合并
        - 在主分支下执行合并命令. 
     + 命令: git branch -d dev
        - 表示删除dev分支,当合并分支后，如果不需要再使用dev分支，则可以直接删除。
        - 不要在dev分支执行这个命令，在别的的分支执行.
   - 解决冲突
     + 应该是如何合并冲突。
     + 冲突是不可避免的。
     + 当在新功能完成后合并前，修改并提交了主分支对应的文件，合并时两个分支中的文件有冲突。
     + 手动修改文件，然后提交

   - 查看冲突未处理的文件列表
   ```markdown
        git ls-files -u
   ```

   - 如果我对某文件进行了修改，但我不想要push到远程仓库，同时我又想获取最新的修改记录
   ```markdown
        git stash save
        git pull --rebase
   ```

   - 如果暂存内容现在不想在当前分支恢复了，而是想单独起一个分支
   ```markdown
        git stash branch [newBranchName]
   ```

   - 想要查看当前工作区与暂存状态内容区别
   ```markdown
        git stash show -p stash{0}
   ```

   - 本地代码已经commit后，解决与远程代码冲突问题
   ```markdown
        # 获取远端库最新信息 【分支名称】
        git fetch origin [master]

        # 做比较
        git diff [本地分支名] origin/[远程分支名]

        # 拉取最新代码，同时会让你merge冲突
        git pull
   ```

## 5.Git原理以及常用步骤
   -  Git内部结构
       + 为了更好的学习Git，我们们必须了解Git管理我们文件的3种状态，分别是已`提交（committed）、已修改（modified）和已暂存（staged）`，由此引入 Git 项目的三个工作区域的概念：Git 仓库、工作目录以及暂存区域。
           Git仓库目录是Git用来保存项目的元数据和对象数据库的地方。 这是Git 中最重要的部分，从其它计算机克隆仓库时，拷贝的就是这里的数据。
           工作目录是对项目的某个版本独立提取出来的内容。 这些从Git仓库的压缩数据库中提取出来的文件，放在磁盘上供你使用或修改。
           暂存区域是一个文件，保存了下次将提交的文件列表信息，一般在Git仓库目录中。有时候也被称作“索引”（Index），不过一般说法还是叫暂存区域。
       + 基本的Git工作流程如下：
          - 1、在工作目录中修改文件。
          - 2、暂存文件，将文件的快照放入暂存区域。
          - 3、提交更新，找到暂存区域的文件，将快照永久性存储到Git仓库目录。
   -  git本地基本操作步骤
       + 1.新建一个项目文件夹，进行文件夹中,打git bash执行命令: `git init`
         - 初始化一个git仓储,其实就是一个隐藏的.git文件夹
         - 不要轻易改变里面文件
       + 2.开始新文件，写我们的代码，写完一个功能，执行命令:
         `git add [文件路径]`
         - 示例：`git add ./READEME.md`
         - 表示要把相应的文件添加到暂存区,暂存区和仓储其实都在.git目录中
         - 批量添加 `git add .` 或者 `git add *`
       + 3.把添加到暂存区的文件提交到仓储中.
         - 命令: `git commit -m "这时写类似注释的东西" `
         -  注意：在提交之前需要配置个人信息 
            `git config --global user.name "xiaoming"`
            `git config --global user.email "xiaoming@sina.cn"`
       + 4.所有需要备份或者提交的文件及目录都必须在.git所在目录。不要超出.git所在目录
      x: 在这几步前后，都可以执行命令：`git status`
   -  撤销操作 
      + 撤销已修改状态
	    git checkout -- 文件路径
	  + 撤销add
	    git status 先看一下add 中的文件 
		git reset HEAD 如果后面什么都不跟的话 就是上一次add 里面的全部撤销了 
		git reset HEAD XXX/XXX/XXX.html 就是对某个文件进行撤销了
	  + 撤销 commit
		git reset HEAD
# 6.Git网上操作
   - gitHub、gitLab和国内的git网站
     + 这些托管网站就相当于 百度云盘、360云盘 只不过这里上传的是源代码而不是其他东西
     + gitHub大部分收费  [官网地址](https://github.com)
     + gitLab大部分免费 [官网地址](https://gitlab.com)
   - git clone
     + 命令:'git clone [仓储地址]'
     + 会把指定仓储的整个下载来
     + 如果不需要下载整个仓储，只需要最新的一次提交,加上参数--depth
   - 登录
      +  直接通过账号密码登录，太麻烦了
      +  通过SSH登录，不用在输入用户名和密码
        - 1.在任意位置输入 ssh-keygen -t rsa 创建rsa密钥
        - 2.将rsa密钥给网站
        - 3.选clone路径的时候选择ssh登录
   - push（推送）
      + 命令：`git push [地址] master`
      + 或命令：`git push origin master`
   - pull（拉回)
      + 命令：`git pull [地址] master`
      + 或命令：`git pull origin master`
   - remote命令使用
      + git remote add “主机名称” “远程仓库地址”添加远程主机，即给远程主机起个别名，方便使用
      + git remote rm“主机名称” 命令用于删除远程主机。
      + git remote 可以查看已添加的远程主机
      + git remote show “主机名称”可以查看远程主机的信息

## 7.GitLab网上使用
-  两种登录方式
	+ 通过Http登录，需要用户名和密码
	+ 通过SSH登录，不需要用户名和密码只需要RSA密钥就行，RSA通过在git bash中输入 ssh-keygen -t rsa生成，
		生成好的密钥通过生成的路径找到对应的id_rsa.pub文件，将其内容添加到gitlab中并保存ssh密钥，以后的push 或者pull操作都不会需要用户名和 密码。
- 克隆仓库
	+ git clone 你的地址（这里可以通过https地址或者通过SSH方式获取你的网上仓库）
- 获取仓库内容
	+ git pull 地址/origin master  可以通过https地址获取仓库数据，但是这样做太麻烦了，使用origin相当于替换了之前的地址用法都是一样的。
		-  其实这样使用包含了两个操作
		-  git fetch origin (获取远端的分支)
		-  git merge origin/master （合并远端分支）
- 远端分支管理
	+ 创建远端分支
		- 1.在本地创建好分支以后，本地 push 该分支即可
		- 2.在网页上创建分支好以后，通过git fetch获取该分支
	+ 删除远端分支
	 - git push origin --delete 需要删除的分支，那么其他人如果需要更新分支 需要 git fetch -p
- git 补充知识
  + 保存当前的工作现场
		  - 使用git stash保存当前的工作现场，那么就可以切换到其他分支进行工作，或者在当前分支上完成其他紧急的工作，比如修订一个bug测试提交。
		  - 1 在通过git add 提交完代码到缓存区以后 输入git stash 保存现场，完成以后通过创建其他分支或者跳转其他分支解决对应的工作
		  - 2 解决完对应的工作后跳转到之前的工作分支中在通过 git stash pop 还原现场
	+ 查看隐藏分支
	 git branch -a
	 
	 