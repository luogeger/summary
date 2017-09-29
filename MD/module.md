# CommonJS、AMD、CMD
> 其实，js模块化需要考虑的第一个问题就是，为什么要模块化，或者说，模块化为什么很重要。
> 指定或约束js表现的规范，不然大家各自使用自己的规范，就会乱套。
- 1.约束怎么写模块
- 2.约束怎么调用模块

|    | service|browser|
|:--:|   :--: |  :--: |
| 代码| 相同代码多次执行|需要从一个服务器端分发到过个客户端执行|
| 瓶颈| CPU和内存资源|带宽|
| 加载| 从磁盘加载|通过网络加载|


- 网页越来越像桌面程序，需要一个团队分工协作、进度管理、单元测试等等......开发者不得不使用软件工程的方法，管理网页的业务逻辑

- 理想情况下，开发者只需要实现核心的业务逻辑，其他都可以加载别人已经写好的模块。

- 但是，Javascript不是一种模块化编程语言，它不支持``类``（class），更甭说``模块``（module）了。同时，我们希望js代码能在服务器端运行，不仅是浏览器端。所以，有了模块化，我们可以很方便地使用别人的代码，想要什么功能，就加载什么模块。

- 但是，这样做需要一个前提，就是代码规范，不然大家各自使用自己的规范，就会乱套。

- CommonJS就是为js的表现指定的规范。
    - 在CommonJS中，有一个全局性的方法``require()``,用于加载模块。假定要加载一个数学模块
    ```javascript
        var math = require('math');
    ```
    - 然后调用模块提供的方法。
    ```javascript
        var math = require('math');
        math.add(2,3); // 5
    ```

- 假如：第二行代码在第一行之后运行，必须等待math.js加载完成，也就是说，如果加载时间很长，整个网页就会停在那里等。

> 以上代码在服务器端执行不成问题，因为，所有模块都放在本地硬盘，可以同步加载完成，等待时间就是硬盘的读取时间。但是，放在浏览器端，却是以很大的问题，因为所有的模块都在服务器端，等待时间取决于网速，可能要等待很长时间，浏览器处于**假死**状态

- 因此，浏览器端的模块，不能才用**同步加载** ``synchronous``,只能采用**异步加载**``asunchronous``。这就是AMD规范诞生的背景。

- **AMD** ``Asynchronous Module Definition 异步模块定义``, 模块的加载不会影响它后面**语句**的运行。所有依赖这个模块的语句，都定义在一个回调函数中，等到加载完成之后，这个回调函数才会执行。

- AMD也采用require()语句加载模块，但是不同CommonJS，它要求2个参数
```javascript
    require( [ ], callback);//前面是数组，成员是要加载的模块
    //改写上面加载math.js的代码
    require(['math'], function (math){
        math.add(2, 3);
    })
```

- 看以下的代码，相信都再熟悉不过了吧，缺点如下：
    - 1.加载的时候，浏览器停止网页渲染，文件越多，失去响应的时间就会越长。
    - 2.js文件之间存在依赖关系，因此，必须严格保证加载顺序。
    - 3.如果这是别人写的代码，而且注释不详，你难道就没有怼他的想法。（妹纸的话，另当别论）.
```html
<script src="1.js"></script>
<script src="2.js"></script>
<script src="3.js"></script>
<script src="4.js"></script>
<script src="5.js"></script>
<script src="6.js"></script>
```
- RequireJS的诞生，就是为了解决这2个问题：
    - 1.实现js文件的异步加载，避免网页失去响应。
    - 2.管理模块之间的依赖性，便于代码的编写和维护。

- RequireJS遵循的是AMD规范.
    - 对于依赖的模块，AMD是**提前执行** ,CMD是**延迟执行** 。不过，RequireJS从2.0开始，也改成可以延迟执行(根据写法不同，处理方式不同)。

- SeaJS遵循的是CMD规范. **懒加载模式是为了提升初始化的加载性能**
    - CMD推崇 as lazy as possible. **依赖就近**，AMD推崇**依赖前置**，

```javascript
    //CMD
    define(function (require, exports, module){
        var a = require('./a');
        a.doSomething();

        var b = require('./b');  //依赖可以就近书写
        b.doSomething();
    })

    //AMD
    define(['./a', './b'], function (a, b){ //依赖一开始就要写好
        a.doSomething();
        b.doSomething();
    })
```

## 模块化的演变
### 全局函数：在全局定义 add, sub, mul, div. 4个函数
    - 执行运算的时候，获取``type`` 类型，进行判断``switch``
```html
    <input type="text" id="t1">
    <select id="sel">
        <option value="1">+</option>
        <option value="2">-</option>
        <option value="3">*</option>
        <option value="4">/</option>
    </select>
    <input type="text" id="t2">
    <input type="button" value="计算" id="btn">
    <span id="result"></span>
```
```javascript
      window.onload = function () {
          var btn = document.getElementById("btn");
          btn.onclick = function () {
              var n1 = document.getElementById("t1").value;
              var n2 = document.getElementById("t2").value;
              var type = document.getElementById("sel").value;
              var result = document.getElementById("result");

              //进行计算
              switch (type) {
                  case "1":
                      result.innerText = add(n1, n2);
                      break;
                  
              }
          };
      }
```

### 对象封装
> 全局函数造成变量污染，但是，对象封装还是无法提供私有成员
```javascript
    var obj = {
        add: function add(a, b) {
            return parseInt(a) + parseInt(b);
        },
        sub: function sub(a, b) {
            return parseInt(a) - parseInt(b);
        },
        mul: function mul(a, b) {
            return parseInt(a) * parseInt(b);
        },
        div: function div(a, b) {
            return parseInt(a) / parseInt(b);
        }
    };

```

### 隔离私有空间 
- 通过``自执行函数``
```javascript
    var obj = (function () { 
                function log() {
                    console.log("我是打酱油的");
                };// 这就是私有的成员
    
                return {
                    add: function add(a, b) {
                        log();
                        return parseInt(a) + parseInt(b);
                    },
                    sub: function sub(a, b) {
                        log();
                        return parseInt(a) - parseInt(b);
                    },
                    mul: function mul(a, b) {
                        return parseInt(a) * parseInt(b);
                    },
                    div: function div(a, b) {
                        return parseInt(a) / parseInt(b);
                    }
                };
            }())
```

#### 还可以对模块进行扩展
```javascript
    var obj = (function (o) {
        //求平方
        o.power = function (a) {
            return parseInt(a) * parseInt(a);
        }
   
        return o;
    }(obj || {}));
```

### 引用模块
> 首先，定义一个模块A
```javascript
define(function (require, exports, module) {
    // -require 需要 -exports 输出 -module  模块
    exports.add = function (a, b) {
        return parseInt(a) + parseInt(b);
    }
    exports.sub = function (a, b) {
        return parseInt(a) - parseInt(b);
    }
});
// 还有简写方式
define(function (){
    return{
        add: function (a, b){
            return parseInt(a) + parseInt(b);
        }
    }
})
```
```
        1.exports和module.exports使用上的区别
        2.exports  只能输出成员，不可以导出对象
        3.module   可以使用module.exports的方式输出成员， 也可以导出对象
        
        4.exports和module.exports 本质的区别
        5.exports = module.exports = {},  exprots被赋值的是引用，```module.exports``被重新赋值对象，``exports``的指向也改变，但是反之就不行了。
        
        6.模块在执行之前，先创建一个空对象
```
> 然后在引用模块
```
利用sea.js的能力，``seajs.use("A","B")``;
A: 想调用的模块的地址，相对于seajs的相对地址
B: 是一个方法，
```
```html
    <script src="scripts/sea-debug.js"></script>
```
```javascript
seajs.use("module1/math.js", function (obj) {
    console.log(obj.add(5, 6));
    console.log(obj.sub(5, 6));
});
```

### 同时使用多个模块
```javascript
seajs.use(["module3/math.js", "module3/power.js"], function (obj, obj1) {
    console.log(obj.add(5, 6));
    console.log(obj.sub(5, 6));
    
    
    //
    console.log(obj1.power(5));
});
```
### 模块之间的依赖
- 例：3次方的需求，模块需要依赖power.js的时候
```javascript
// math code  注意math和power是在同一个文件夹下，目录为：sea,sea-debug\\script\\mosules\\math,power
define(function (require, exports, module) {
    var obj = require("./power"); // 不爽：依赖的模块，这里的``./``是相对编写文件的位置
    module.exports = {
        add: function (a, b) {
            return parseInt(a) + parseInt(b);

        },
        sub: function (a, b) {
            return parseInt(a) - parseInt(b);
        },
        three: function (a) {
            return obj.power(a) * parseInt(a);
        }
    };
    
});

// 对应的页面代码
seajs.use("module4/math", function (obj) { 
    console.log(obj.add(4, 5));
    console.log(obj.three(5));// 求3次方的时候，math依赖power这个模块，
})
```

### sea.js配置
```javascript
// 注意： 这是写html页面的js code
seajs.config({
    base: "module5",//这个文件夹下面有math.js 和 powwer.js
    alias: {
        m: "math",
        p: "power"
    }
});
seajs.use(["m", "p"], function (o1, o2) {
    console.log(o1.add(5, 6));
    console.log(o2.power(4));
})
```

### sea.js原理
- 页面中只引用了``sea-debug.js``, 但是还用到了math.js和power.js, 这些我们并没有引入，但是可以用``seajs.use()``方法来用到``math.js, power.js``里面的功能。
所以，sea.js帮我们引入这些文件，所以，sea.js最基本的原理就是动态创建script标签，最后在删除，reduce memory leak
```javascript
function loadJS(path, callback) {
    var head = document.getElementsByTagName("head")[0];
    var node = document.createElement("script");
    node.src = path;
    head.appendChild(node);
    //浏览器兼容处理
    var supportOnload = "onload" in node;//查看node这个标签支不支持onload这个属性，返回Boolean
    if(supportOnload) {
        node.onload = function () {
            callback();
        }
    }else{
        node.onreadystatechange = function () {
            if(node.readyState == "loaded" || node.readyState == "complete") {
                callback();
            }
        }
    }
}

loadJS("test.js", function () {
    alert('callback');
})
```

### 把jQuery当做sea.js的模块
- 2种写法, main.js 和 jquery 在 ``module6-jq``的文件里，htmlh和``module6-jq``在同级目录
> 1.如果在html 写配置
```javascript
// main.js
define(function (require) {
    var $ = require("jquery");//需要先配置路径和别名
    $(function () {
        $("#box").css("color","red");
    })
})
// html
seajs.config({
    base: "module6-jq",
    alias: {
        jquery: "jquery-1.12.4.js"
    }
})
seajs.use("main");
```
> 2.不在html里面写配置
```javascript
// main.js
define(function (require) {
    var $ = require("./jquery-1.12.4");
    $(function () {
        $("#box").css("color","red");
    })
})
//html
seajs.use("module6-jq/main");
```

### sea.js的懒加载，用到才会执行
> 懒加载：先准备入口和模块文件
```javascript
// add.js
define(function () {
    console.log("加载了add");
    return {
        add: function (a, b) {
            return parseInt(a) + parseInt(b);
        }
    }
});

// sub.js
define(function () {
    console.log("加载了sub");
    return {
        sub: function (a, b) {
            return parseInt(a) - parseInt(b);
        }
    }
});

// main.js
define(function (require) {
    console.log("加载了main");
    var addObj = require("./add");

    console.log(addObj.add(5, 6));
    var subObj = require("./sub");
    
    console.log(subObj.sub(5, 6));
});

//html
seajs.use("module8/main");

// 结果是从上到下依次执行，然后require.js是先加载文件，在执行运算结果
```


### require.js的预加载模式
```html
<!-- 这样的话就直接运行了main.js里面的代码了, alert('hello require.js') -->
<script data-main="scripts/main" src="scripts/require.js"></script>

<!-- 另外一种形式 -->
<script src="scripts/require.js"></script>
<script>
    requirejs(["scripts/main.js"]);//1.这里引入路径一定是 数组的形式，和sea.js不同 2.这里是相对于当前html来写的
</script>
```
> 预加载：先准备入口和模块文件
```javascript
// add.js
define(function (require, exports, module) {
    console.log("加载模块 add");
    exports.add = function (a, b) {
        return parseInt(a) + parseInt(b);
    }
});

// sub.js
define(function (require, exports, module) {
    console.log("加载模块 sub");

    exports.sub = function (a, b) {
        return parseInt(a) + parseInt(b);
    }
});

// main.js
define(function (require) {
    console.log("加载模块 main");

    var objAdd = require("./add");// 不爽：依赖的模块，这里的``./``是相对编写文件的位置
    console.log(objAdd.add(5,6));

    var objSub = require("./sub");// 不爽：依赖的模块，这里的``./``是相对编写文件的位置
    console.log(objSub.sub(5,6));

});

```
```html
<script src="scripts/require.js"></script>
<script>
    requirejs.config({
        baseUrl: "scripts/module"
    });
    requirejs(["main"]);
    //如果不写config的话可以写成 requirejs(["scripts/module/main"]);
</script>
```
注意：main.js入口文件引入模块都是``./``, 相对编写文件的位置

### 原生ajax
- 1.解决跨域的方式： 
    - 1.客户端： jsonp
    - 2.服务端：设置响应头
    
- 2.jsonp只能支持get请求的跨域，不支持post

- 3.原生ajax的5种状态
```javascript
//1 创建xml对象
//2 open  设置请求的地址
//3 注册事件
//4 发送请求
var xhr = new XMLHttpRequest();
xhr.open("get", "http://182.254.146.100:8080/api/itemcat.php", true);// true 表示异步请求
xhr.onreadystatechange = function () {
    if(xhr.readyState === 4) {
        if(xhr.status === 200) {
            var res = xhr.responseText;
        }
    }
};
xhr.send();
//xhr.readyState
//0  new完了
//1  open完了
//2  调用了send()
//3  正在接收数据
//4  接收完毕
```


















