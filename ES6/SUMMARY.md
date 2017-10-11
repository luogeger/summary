# ECMAScript 2015

## 命令行环境
### 安装
- npm install --global babel-cli 
    - 全局安装
- npm install -- save babel-preset-es2015
    - 安装在目录，并在目录下新建配置文件 .babelrc
    - "presets": ['es2015']
    
### 01直接运行es6文件
- babel-node es6.js

### 02把单个es6文件转化es5文件，输出在同级目录下
- babel es6.js -o es5.js

### 03整个文件夹的转化以及输出
- babel -d build-dir source-dir
- babel -d build-dir source-dir -s
    - ``-s``参数会生成source map 文件

