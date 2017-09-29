# webpack

- 1.在文件夹先下载执行命令``npm init``，生成package.json文件

- 2.默认的文件名是：webpage.config.js , 默认执行：webpage
    - 但是，改了文件名：webpack.develop.config.js, 运行：webpack --config webpack.develop.config.js

- 3.命令配置
    - 把命令配置到``'scripts': {}``里面
    ```javascirpt
    'scripts' : {
        "develop" : "webpack --config webpack.develop.config.js",
    }
    ```
    - 这样话，命令行就可以简化为``npm run develop``

- 4.如果文件进行修改，还需要再次运行``npm run develop``
    - 1.webpack还可以实现页面的自动刷新，在开发的过程中监听每一个文件的变价，进行实时打包，通知前端页面代码发生了变化，做到实时更新

    ``npm install webpack-dev-server --save-dev``: 这个文件只是在开发阶段使用
    - 2.在对原来的配置文件做点修改
    ``"develop": "webpack-dev-server  --config webpack.develop.config.js --devtool eval --progress --colors --hot --content-base src",``
        - localhost:8080，结合了Node服务器，但是文件都在内存中，命令行中最后的**src** 是以src文件夹创建服务器

# Imooc webpack

## webpack的基本配置，和配置里面参数的功能

- 1.初始化文件夹
    - ``npm init``: 然后一路回车

- 2.紧接着在这个目录下安装webpack
    - ``npm install webpack --save-dev``

- 3.建立文件夹供项目使用以及初始化页面

- 4.给项目建一个webpack配置文件 ，类似gulp的gulpfile.js
    - 开始配置
    - 1.首先用到commonJS的模块化
    ```javascript
        module.exports = {

        };
    ```
    - 2.配置package.json里面的``scripts``
    ```javascript
    //希望看到打包的过程，打包的模块，打包的字是彩色的，打包的原因
    "asd": "webpack --config webpack.config.js --progress --display-modules --colors --display-reason"
    ```
        - 启动命令行变成： ``npm run asd``

## 配置信息详细说明
- 1.CLI
    - 对webpack.config.js的配置
    - **entry** 有3种不同的写入方式来应付不同的需求
        - ``string``
        - 数组：``entry: ['./one.js', 'two.js']``
            - 是为了解决2个平行的，互相依赖的文件想打包在一起的情况
        - 对象的形式
            ```javascript
            entry: {
              main: './js/main.js',
              a: './js/a.js'
            },
            output: {
              path: 'dist/js',
              filename: '[name]-[hash].js'
            }
            // 这个hash是代表的本次，而且打包出来的是2个文件
            ```
- 2.Node.js API
    - webpack在node中的使用

### 插件的使用
- 1.index.html文件中引入的是bundle.js文件，这个文件名是写死的，但是实际中是动态的
    - 用``html-webpack-plugin``插件解决
        - ``npm install html-webpack-plugin --save-dev``
        - ``注意：``html文件和js文件的路径修改

- 2.在模板``index.html``获取插件配置中的参数
    ```html
    <title><%= htmlWebpackPlugin.options.title %></title>
    <%= htmlWebpackPlugin.options.date %>

    <h3>htmlWebpackPlugin</h3>
    <%for(var key in htmlWebpackPlugin){%>
    <%= key%>
    <%}%>

    <h3>htmlWebpackPlugin.files</h3>
    <%for(var key in htmlWebpackPlugin.files){%>
    <%= key%> : <%= JSON.stringify(htmlWebpackPlugin.files[key])%>
    <%}%>

    <h3>htmlWebpackPlugin.options</h3>
    <%for(var key in htmlWebpackPlugin.options){%>
    <%= key%> : <%= JSON.stringify(htmlWebpackPlugin.options[key])%>
    <%}%>
    ```
    ```javascript
    plugins: [
        new htmlPlugin({
            //filename: 'index-[hash].html',
            //inject: 'head', //把script标签放到顶部
            template: 'index.html',
            title: 'htmlWebpackPlugin.options.title',
            date: new Date(),
        })
    ]
    ```
    - 插件的详细解释 -> [npmjs.com](npmjs.com)

- 3.js代码放在不同位置，分别在head标签和body标签，必须改变模板，因为模板直接可以引用.
    - **pit：** 底部有a.js文件的同时，main.js和a.js都存在 ->plugins配置里面inject的值要改变为false.

- 4.项目打包上线之后，文件的相对位置肯定和现在不一样了。
    - 1.用到output的新属性``publicPath`` -> 在``path``的基础上加前缀
    - 2.html文件压缩, ``minify: {}``对当前生成的HTML文件进行压缩

- 5.生成多个html文件，处理多个页面
    - 把index.html生成多个html，但是引用不同的js文件。用一个模板生成3个不同的页面。
        - ``chunks: []``和``excludeChunks: []``

> **bug:** 只要改变c.js文件，不会覆盖而是重新生成新文件

- 6.把main.js文件里的内容放在html文件里面，使用inline的方式，不是放在src属性里面，减少请求。
    - <%= htmlWebpackPlugin.files.chunks.main.entry %>
    - <%= htmlWebpackPlugin.files.chunks.main.entry.substr(htmlWebpackPlugin.files.publicPath.length) %>
    - <%= compilation.assets[htmlWebpackPlugin.files.chunks.main.entry.substr( htmlWebpackPlugin.files.publicPath.length )].source() %>
    ```html
    <body>
    <% for(var key in htmlWebpackPlugin.files.chunks){ %>
        <% if(key == !'main') { %>
            <script src="<%=  htmlWebpackPlugin.files.chunks[key].entry %>">

            </script>
        <% } %>
    <% } %>
    ```
    - ``pit: ``
        - 1.每次 npm run asd　生成的文件不能覆盖
        - 2.设置了inject：'body', main.js文件还是会被外链引入