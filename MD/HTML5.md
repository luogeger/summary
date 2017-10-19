# HTML5 CSS3

## First

### 语义化更强的标签
```html
<header>
     <nav>nav</nav>
</header>

<main>
    <article>article</article>
    <aside>aside</aside>
</main>

<footer>
</footer>
<!--宽度百分比布局,再浮动-->
```

### form标签的用法
- **datalist标签**：id必须和input标签的list属性值一样。input获取焦点以后才会有下拉框的效果。--类似select
- **keygen标签**：基本不用
- **output标签**：配合``type='range'``使用。它的作用类似于span 本身没有任何功能,没有任何默认的外观,只是语义性强,可以用来放结果如果要使用一般是配合用来显示结果
```html
<form>
    <fieldset>
        <legend>新form标签</legend>
        <input type="text" placeholder="请输入晚餐的食物" list="foodList">
        <!-- datalist  可以为input 标签增加选项为用户提供默认的选项 select也是可以实现类似的效果-->
        <datalist id='foodList'>
            <option value="臭豆腐盖饭">臭豆腐盖饭</option>
            <option value="榴莲肉饼汤">榴莲肉饼汤</option>
            <option value="肉夹馍">肉夹馍</option>
        </datalist>
            <br>
        <!-- 加密了解即可,实际开发中基本不用-->
        <keygen keytype="rsa"></keygen>
            <br>
        <output name=""></output>
            <br>
        <input type="range" oninput='changeNum(this)'>
    </fieldset>
</form>
```

```javascript
function changeNum(obj) {
    document.querySelector('output').innerText = obj.value;
}
```

### input标签的新属性
- ``autofocus``: 自动获取焦点
- ``autocomplete``:
- ``multiple``: 针对``type='file'``，添加之后可以选择多个文件
- ``name="jserAge"``: 提交之后输入框有提示，必须加``name``属性
- ``form='formTest'``: 表单之外的``input``被获取，要关联一下，form的属性必须和form标签的ID一样。
```html
    <form id='formTest'>
        <input type="text" value='' placeholder="请输入用户名">
        <br>
        <input type="text" placeholder="请输入电话号码" autofocus>
        <br>
        <input type="text" name='userEmail' autocomplete placeholder="请输入邮箱">
        <input type="file" multiple>
        <input type="submit" name="">
    </form>
    <input type="text" name="userAge" placeholder="请输入你的年龄" form='formTest'>
```
> **label** 标签及**for**属性：点击前面的文字，输入框也获取焦点
```HTML
<label for="textBtn">请输入你的爱好:</label>
<input type="text" id='textBtn'>
```
- for属性和input标签的ID必须一样。

### input标签的type属性
- color、date、email、month、number、range、search、tel、time、week
```html
    <fieldset>
        <legend>input的新type属性</legend>
        <label>color:
        <input type="color" name="" value=""></label>
        <label>date:
        <input type="date" name="" value=""></label>
    </fieldset>
</form>
```
### 表单验证
- H5的自定义验证有一定的兼容性问题。弹框和外观是无法自定义的
```HTML
<form>
    <fieldset>
        <legend>用户注册</legend>
        <label for="">用户名
            <input type="text" name="" value="" required>
        </label>
        <label for="">手机号
            <input type="tel" name="" value="" required pattern="[0-9]{11}" id='btnTel'>
        </label>
        <input type="submit" name="">
    </fieldset>
</form>
```
- 添加required属性，在提交时候会自动进行非空验证。
- pattern属性，设置正则就可以进行内容的筛选。
- oninvalis添加了变淡验证。验证失败以后会调用
```javascript
$('#btnTel').oninvalid = function (){
    if(this.value == ''){
        this.setCustomValidity('请输入内容');
    }
    else{
        this.setCustomValidity('登陆成功');
    }
};
```
> 如果pattren属性设置了正则，就不需要些oninvalid验证。


### 获取dom元素
> 在不需要导入jQuery的情况下。也能使用类似的语法获取dom元素
- **document.querySelector('li[skill]')**
- **document.querySelectorAll('li')**: 返回的是一个数组，哪怕只有一个元素也是数组。
```HTML
<ul>
    <li>榴莲</li>
    <li skill='逆风十里'>臭豆腐</li>
    <li id='greenGua'>苦瓜</li>
    <li class='innerOil'>咸蛋</li>
</ul>
```
```javascript
document.querySelector('li').style.backgroundColor = 'yellow';
// $(li[skill]) 可以使用属性选择器
document.querySelector('li[skill]').style.backgroundColor = 'pink' ;
document.querySelector('.innerOil').style.color = 'orange';
document.querySelector('#greenGua').style.backgroundColor = 'yellowgreen';

var liLists = document.querySelectorAll('li');
console.log(liLists.length);
for (var i = 0; i < liLists.length; i++) {
    liLists[i].onclick = function (event) {
        // 修改文字大小
        this.style.fontSize = '30px';
    }
}
```

### 操作class
- classList属性可以让我们像jQuery那样操作class
    - .classList.add('red');
    - .classList.remove('red');
    - .classList.toggle('blue');
    - .classList.contains('green'); 是否包含``green``这个类，返回Boolean
```html
<div></div>

<input type="button" value='添加class' id='btnAdd'>
<input type="button" value='移除class' id='btnRemove'>
<input type="button" value='切换class' id='btnToggle'>
<input type="button" value='判断是否包含' id='btnContains'>
```
```css
div {
    width: 100px;
    height: 100px;
    border: 1px solid #0094ff;
}
.gray {
    background-color: gray;
}

.red {
    background-color: red;
}
```
```javascript
    var div = document.querySelector('div');
    document.querySelector('#btnAdd').onclick = function (e) {
        div.classList.add('red');
    };
    document.querySelector('#btnRemove').onclick = function (e) {
        div.classList.remove('red');
    };
    document.querySelector('#btnToggle').onclick = function (e) {
        div.classList.toggle('gray');
    };
    document.querySelector('#btnContains').onclick = function (e) {
        alert(div.classList.contains('gray'));
    };
```
> 注意：css样式中的类名，前后的顺序会影响``add``和``toggle``的样式是否有效。

### 两种进度条
- **progress**标签、**meter**标签
    - progress：value当前值；max最大值。
```HTML
	<progress value="50" max="100"></progress>
	<progress value="50" max="200"></progress>
		<br>
	<meter value="" min="0" low="30" high="60" max="100"></meter>
		<br>
	<input type="range" id='rangeBtn'>
	<span id='result'></span>
```
```javascript
document.querySelector('#rangeBtn').oninput = function(){
	console.log(this.value);
	document.querySelector('#result').innerText = this.value;
	document.querySelector('progress').value=this.value;
	document.querySelector('meter').value=this.value;
}
```
> 注意： oninput = function (){ }

### 自定义进度条
```html
<div class='container'>
    <div class="progress"></div>
</div>

<input type="range">
```
```css
.container {
    width: 300px;
    height: 30px;
    border: 1px solid #0094ff;
}

.progress {
    height: 100%;
    width: 0%;
    background-color: pink;
}
```
```javascript
document.querySelector('input').oninput = function (e) {
    // 找到 progress 修改 宽度即可
    document.querySelector('.progress').style.width = this.value + '%';
    if (this.value > 50) {
        document.querySelector('.progress').style.backgroundColor = 'green';
    } else {
        document.querySelector('.progress').style.backgroundColor = 'red';
    }
}
```

### **data—** 获取自定义属性
- ``data-path='img/wbq.jpg' ``: ``alert(this.dataset['path'])``
```HTML
<div class="imgBox"></div>
<div class='infoBox'></div>
<div class='btnBox'>
    <input type="button" value='王宝强' data-path='img/wbq.jpg' data-info='宝宝不哭,站起来'>
    <input type="button" value='宋仲基' data-path='img/szj.jpg' data-info='专业撩妹,大众老公'>
    <input type="button" value='贾玲' data-path='img/jl.jpg' data-info='贾玲，原名贾裕玲。'>
</div>
```
```javascript
var btnLists = document.querySelectorAll('input');
for (var i = 0; i < btnLists.length; i++) {
    btnLists[i].onclick = function (argument) {
    // dataset 传入key (键)
    console.log(this.dataset['path']);
    console.log(this.dataset['info'])
    document.querySelector('.imgBox').style.background = "url("+this.dataset['path']+")";
    document.querySelector('.infoBox').innerText = this.dataset['info'];
    }
}
```
- ``data-``: 后面设置多个属性。
    - 设置的时候'data-'后面的字母不能大写。
    - 获取的时候要采用驼峰命名法。
```HTML
<input type="button" value='王思聪' data-dog='可可' data-dog-friend='黄毛' data-father='王健林'>
```
```javascript
var inputLists = document.querySelectorAll('input');
for (var i = 0; i < inputLists.length; i++) {
    inputLists[i].onclick = function (e) {
        alert(this.dataset['dog']);
        alert(this.dataset['father']);
        alert(this.dataset['dogFriend']);
    }
}
```

### Video标签
- **poster**: 封面``如果自动播放，封面就没有意义``
- **loop**：循环播放
- **autoplay**: 自动播放
- **controls**: 控制栏

```HTML
<video controls loop  poster="img/wbq.jpg" width="300px" height="300px">
    <!--source 可以指定多个同的视频格式,想要 自定义播放器的控制栏需要自己使用html代码-->
    <source src="movie/rabbit.ogg" >
    <source src="movie/movie01.mp4">
</video>
```

### Audio标签
- 如果没有controls属性，就属于隐藏状态
```HTML
<audio  controls autoplay loop>
    <!-- 从上往下解析 找到 可以播放的 即开始播放 -->
    <source src="music/music.ogg" type="" media="">
    <source src="music/music.mp3" type="" media="">
    <!-- 当视频 都无法播放 可以 通过提示信息 来告诉用户解决方案 -->
    亲爱的用户,您的浏览器版本过低,可以点击下载<a href="#">360急速全家桶</a>
</audio>
```

## Second
### 选择器
- 兄弟选择器: 以第一个选择器作为开始,往后的所有满足 选择器2的 元素
```css
.secondH2~p{
    background-color: orange;
}
.secondH2~.lastP{
    font-size:30px;
}
```

- 属性选择器
```css
/*所有拥有skill属性的值不考虑*/
li[skill]{
    background-color: red;
}
/*属性=某个具体值*/
li[skill=fire]{
    background-color: yellow;
}
/*属性以 某个值 开头*/
li[skill^=sell]{
    background-color: blue;
}
/*属性以 某个值结尾*/
li[friend$=s]{
    background-color: green;
}
/*属性中 包含了 某个值 */
li[skill*=it]{
    background-color: deepskyblue;
}
/*|= :属性以 - 进行分割, 第一个值为 dog的 */
li[people|=dog]{
    background-color: purple;
}
/*属性选择器中括号 [属性名 符号 属性值]*/
```
- 伪类选择器
    - li:fist-child{}
    - li:last-child{}
    - li:nth-child(7){}
    - li:nth-child(2n-1){}
    - li:nth-child(odd){}
    - li:nth-child(even){}
    - li:not([ price='18' ]){} : 找到没有price=18的所有标签。
    - h2:target{} : 锚链接
```html
        <ul>
            <li><a href="#title1">去往标题1</a></li>
            <li><a href="#title2">去往标题2</a></li>
            <li><a href="#title3">去往标题3</a></li>
            <li><a href="#title4">去往标题4</a></li>
        </ul>
        <h2 id="title1">标题1</h2>
        <p>lorem</p>
        <h2 id="title2">标题2</h2>
        <p>lorem</p>
        <h2 id="title3">标题3</h2>
        <p>lorem</p>
        <h2 id="title4">标题4</h2>
        <p>lorem</p>
```
```css
        h2:target {
            background-color: skyblue;
            font-size: 100px;
        }
```
- 伪元素选择器
    - 可以为双标签添加子元素
    - **必须**添加``content``属性，可以是具体内容，也可以为空
    - 默认是行内元素
    ```css
    div::after{
        content:'❤';
        position: absolute;
        background-color: skyblue;
        width: 50px;
        height: 50px;
        text-align: center;
        line-height: 50px;
        right:-50px;
        top:25px;
    }
    /*伪元素hover事件语法*/
    div:hover::after{
        top:0px;
    }
    ```
> 首字母：``p::first-letter{}``

> 首行： ``p::first-line{}``

> 选中的文字：``p::selection{}``

> input标签里的placeholder: ``input::-webkit-input-placeholder{}`` 不同的浏览器对应不同的前缀


### 背景图片
### 图片边框
### 过渡
### 动画
### 3D动画
### 渐变
### web字体
### web图标















































## [animate.css](https://github.com/daneden/animate.css)













## 布局
- 自动换行：word-wrap:break-word; (包括数字)


```css
{
    overflow: hidden;
    text-overflow: ellipsis;/* 文字超出用...*/
    white-space: nowrap;/* 文字不换行*/
}
```




## 弹性布局
- 基本概念：分为容器``container``和项目``item``


### container有6个属性
- 1.``flex-direction``: 决定主轴的方向 -> 就是item的排列方向

- 2.``flex-wrap``: 默认下，item在一条轴线上，这个属性定义轴线放不了那么多item，决定如何换行

- 3.``flex-flow``: 是上面2个的合并属性

- 4.``justify-content``: 定义item在主轴上面的对齐方式

- 5.``align-items``: 定义item在交叉轴上的对齐方式

- 6.``align-content``: 定义了多根轴线的对齐方式，**如果只有一根轴线，这个属性就不起作用**


> 1.``flex-direction``: row | row-reverse | column | column | column-reverse ;

    决定主轴的方向 -> 就是item的排列方向
    
1``row``(默认)：主轴为水平方向，起点在左

2``row-reverse``: 水平，起点在右

3``column``： 主轴为垂直方向，起点在上

4``column-reverse``：垂直方向，起点在下

    
> 2.``flex-wrap``: nowrap | wrap | wrap-reverse;

    默认下，item在一条轴线上，这个属性定义轴线放不了那么多item，决定如何换行
    
1``nowrap``(默认): 不换行

2``wrap``: 正常换行，多余的一次向下排放

3 ``wrap-reverse``: 多余的往上面放
    
    
> 3.``flex-flow``: row nowrap;

    是上面2个的合并属性；



> 4.``justify-content``: flex-start | flex-end | center | space-between | space-around;

    定义item在主轴上面的对齐方式
    
1``flex-start``：左对齐

2``flex-end``：右对齐

3``center``：居中

4``space-between``：两端对齐，item之间的距离相等

5``space-around``：也是item之间的距离相等，但是两边的item与边框有距离，这个距离是item之间距离的1/2


> 5.``align-items``: flex-start | flex-end | center | baseline | stretch ;

    定义item在交叉轴上的对齐方式
    
1``flex-start``：全部靠边框``交叉轴``上面对齐

2``flex-end``：下面对齐

3``center``：中点线对齐

4``baseLine``：和项目第一行文字的基线对齐

5``stretch``：``默认值``，如果item没有设置高度或auto，item将占满整个容器的高度


> 6.``align-content``: flex-start | flex-end | center | space-between | space-around | stretch ;

    定义了多根轴线的对齐方式，如果只有一根轴线，这个属性就不起作用
    
1``stretch``：默认，轴线占满整个交叉轴

2``flex-start``：上面对齐

3``flex-end``：下面对齐

4``center``：中间对齐

5``space-between``：两端对齐，轴线之间的间隔均分

6``space-around``：轴线之间的距离 是 轴线到边框距离 的 2倍



### item也有6个属性
- 1.``order``: 定义item的排列顺序，数值越小，排列越靠前，默认为0

- 2.``flex-grow``:

- 3.``flex-shrink``:

- 4.``flex-basis``:

- 5.``flex``:

- 6.``align-self``:


> 1.``order``: integer;

    定义item的排列顺序，数值越小，排列越靠前，默认为0；

> 2.``flex-grow``: number;

    定义了item的放大比例额，默认是0，即使存在剩余空间，也不放大。
    
    

> 3.``flex-shrink``: number;
    
    定义了item的缩小比例，默认是1，如果空间不足，这个item缩小。
    
空间不足的时候，所有item都等比缩小，设置有``flex-shrink: 0;``的item不会缩小

> 4.``flex-basis``: 
    
    定义item的固定值，可以用px为单位
    
flex-basis: 100%; 单个item占据整行, 可以实现骰子5的形状
    

> 5.``flex``: 

    前面3个属性的简写，有1个默认值，和2个快捷值
    
1.``default``: 0 1 auto;
2.``auto``: 1 1 auto;
3.``none``: 0 0 auto;
    

> 6.``align-self``: auto | flex-start | flex-end | center | baseline | stretch ;

    为自己单独设置和其他item不一样的对齐方式，会覆盖align-items属性。
    默认是auto,表示继承container的align-items属性，
    如果没有container，就等同于stretch
    
1.``auto``: 除了这个属性，其他都与``align-itmes``完全一样
    










# css property
### 1.``overflow``
```css
{
    overflow: visible; /*(默认) 明显地*/
    overflow: hidden; 
    overflow: scroll;
    overflow: auto;
    overflow: inherit; /*继承*/
}
```

### 2.``background``
- ``background-attachment``: scroll  |  fixed;
    - 设置背景图像是否固定或者随着页面的其余部分滚动。


- ``background-color``: transparent;


- ``background-repeat``: 0% 0%  |  left top|left center|left bottom|right top|right center|right bottom|center top|center center|center bottom;
    - 如果仅指定一个关键字，其他值将会是"center"
    
    
- ``background-origin``: border-box  |  content-box  |  padding-box;

- ``background-clip``: border-box  |  content-box  |  padding-box;

- ``background-size``: auto  |  length  |  percentage  |  cover  |  contain;
    - ``length``: 设置背景图片的高度和宽度，first宽度，second高度。如果只给一个值，second值为auto
    - ``percentage``: 将计算相对于背景定位区域的百分比
    - ``cover``: 图片会铺满 - 不会有留白，可能部分显示不了 - 相当于``100%``，
    - ``contain``: 图片完全显示 - 可能有留白
    

- background-position: 0 0;

- background-position-x: ;

- background-position-y: ;






### 3.``box-shadow``

### 4.``box-sizing``

### 5.``text-shadow``







# css 总结

- 1.文字超过宽度以...的形式
```css
  .new-item {
    display: inline-block;
    width: 230px;
    overflow: hidden;
    text-overflow: ellipsis;/* 文字超出用...*/
    white-space: nowrap;/* 文字不换行*/
  }
```


- 2.input-placeholder 还可以配合opacity 
```css
::-webkit-input-placeholder{ /* Chrome/Opera/Safari */
    color: pink;
}

::-moz-placeholder{ /* FF 19+ */
    color: pink;
}

:-ms-input-placeholder{ /* IE 10+ */
    color: pink;
}

:-moz-placeholder{ /* FF 18- */
    color: pink;
}
```


- 3.clearfix 清除浮动
```css
.clearfix{
    zoom: 1;
}

.clearfix:after{
    visibility: hidden;
    display: block;
    font-size: 0;
    content: '';
    clear:both;
    height: 0;
}

/* 还有另一种 */
.clearfix:before, .clearfix:after {
    content: "";
    display: table;
}

.clearfix:after {
    clear: both;
}

.clearfix {
    *zoom: 1; /*IE/7/6*/  /*兼容IE6下的写法*/
}
```


- 4.禁止用户选中文本 
```css
div{
    user-select: none;
}
```



- 5.移除浏览器的默认样式，chrome的input的默认样式
```css
input, button, textarea, select{
    *font-size: 100%;
    -webkit-appearance: none;
}
```


- 6.CSS transition 或者 animations , 页面会有闪烁
```
    -webkit-backface-visibility: hidden;
```


- 7.禁止长按链接与图片弹出菜单
``` 
    -webkit-touch-callout: none;
```


- 8.不换行，自动换行， 强制换行
``` 
    white-space: nowrap; // 不换行
    
    // 自动换行
    word-wrap: break-word;
    word-break: normal;
    
    word-break: break-all; // 强制换行
```

- 9.宽度计算: 宽度为100%减去100px的值，IE9+才兼容
```css
    div{
        width: calc( 100% - 100px);
    }
```
- 10.线性渐变 (linear-gradient) , 默认从top开始，也可以自定义方向
```css
    div{
        linear-gradient(red, yellow)
    }
    background: linearGradient(direction, color-stop1, color-stop2, ...);
```

- 11.颜色
```scss
    $baseColor: #ff8a41;
    .normal{
      background: $baseColor;
    }
    .lighten {
      background: lighten($baseColor,15%);
    }
    .darken{
      background: darken($baseColor,15%);
    }
```




# scss

### 1.  变量声明
- 普通变量、默认变量
- 局部变量、全局变量
    

### 2.  嵌套
- 选择器嵌套
- 属性嵌套
- 伪类嵌套

### 3.  混合宏
- 声明宏``@mixin``
- 调用宏``@include``
- 混合宏的参数
    - 不传参
    - 不传参的默认值
    - 传入多个参
    
### 4.  继承
- ``@extend`` 在sass中的继承，可以继承类样式块中所有样式代码，而且编译出来的css会将选择器合并在一起，形成组合选择器
```scss
/*scss*/
.btn {
  border: 1px solid #ccc;
  padding: 6px 10px;
  font-size: 14px;
}
.btn-primary {
  background-color: #f36;
  color: #fff;
  @extend .btn;
}


/*css*/
.btn, .btn-primary {
  border: 1px solid #ccc;
  padding: 6px 10px;
  font-size: 14px;
 }
.btn-primary {
  background-color: #f36;
  color: #fff; 
}
```

### 5.  占位符
用占位符声明的代码，如果不被``@extend``调用就不会被编译。
```scss
/*scss*/
%mt5 {
  margin-top: 5px;
}
%pt5{
  padding-top: 5px;
}

.btn {
  @extend %mt5;//使用@extend调用占位符代码
  @extend %pt5;
}
.block {
  @extend %mt5;
  span {
    @extend %pt5;
  }
}

/*css*/
.btn, .block {
  margin-top: 5px;
}
.btn, .block span {
  padding-top: 5px;
}

```

### 6.  插值

### 7.  注释

### 8.  运算
- 加法、减法
- 乘法
- 除法
- 变量计算
- 数字计算
- 颜色计算
- 字符运算


# bootstrap

### Core variables and mixins    (2)
- ``@import "variables.less";``  定义变量，方便后面调用
- ``@import "mixins.less";``    定义混合 这类似定义函数或者宏，在mixins文件夹中可看到所定义的函数   

### Reset and dependencies    (3)
- ``@import "normalize.less";``     标准化css，这是一个专门将不同浏览器的默认css特性设置为统一效果的css库，编译后对应源码为8~190行
- ``@import "print.less";``     打印样式，编译后对应源码为192~266行
- ``@import "glyphicons.less";``     图标样式，编译后对应源码为267~885行

### Core css    (7)
- ``@import "scaffolding.less";``     脚手架，相当于全局样式，编译后对应源码为886~989行
- ``@import "type.less";``     排版样式，编译后对应源码为990~1335行
- ``@import "code.less";``     代码样式，编译后对应源码为1336~1389行
- ``@import "grid.less";``     栅格系统，这是Bootstrap支持响应式的重点，编译后对应源码为1390~2056行
- ``@import "tables.less";``     表格样式，编译后对应源码为2057~2296行
- ``@import "forms.less";``     表单样式，编译后对应源码为2297~2781行
- ``@import "buttons.less";``    按钮样式，编译后对应源码为2782~3171行
 
### Components 组件    (21)
- ``@import "component-animations.less";``    组件中折叠和隐藏动画，编译后对应源码为2782~3171行
- ``@import "dropdowns.less";``    下拉菜单及下三角符号，编译后对应源码为3209~3348行
- ``@import "button-groups.less";``    按钮组，编译后对应源码为3349~3520行
- ``@import "input-groups.less";``    输入框组，编译后对应源码为3521~3674行
- ``@import "navs.less";``    导航，编译后对应源码为3675~3868行
- ``@import "navbar.less";``   导航条，编译后对应源码为3869~4393行 
- ``@import "breadcrumbs.less";``    面包屑，编译后对应源码为4394~4411行
- ``@import "pagination.less";``    默认分页，编译后对应源码为4412~4504行
- ``@import "pager.less";``    翻页，编译后对应源码为4505~4542行
- ``@import "labels.less";``    标签，编译后对应源码为4543~4609行
- ``@import "badges.less";``    徽章，编译后对应源码为4610~4648行
- ``@import "jumbotron.less";``    巨幕，编译后对应源码为4649~4686行
- ``@import "thumbnails.less";``    缩略图，编译后对应源码为4687~4712行
- ``@import "alerts.less";``    警告框，编译后对应源码为4713~4787行
- ``@import "progress-bars.less";``    进度条，编译后对应源码为4788~4881行
- ``@import "media.less";``    媒体对象，编译后对应源码为4882~4915行
- ``@import "list-group.less";``    列表组，编译后对应源码为4916~5091行
- ``@import "panels.less";``    面板，编译后对应源码为5092~5426行
- ``@import "responsive-embed.less";``    具有响应式特性的嵌入内容，编译后对应源码为5427~5452行
- ``@import "wells.less";``    well效果，编译后对应源码为5453~5474行
- ``@import "close.less";``    关闭按钮图标，编译后对应源码为5475~5499行

### Components w/ JavaScript    (4)
- ``@import "modals.less";``    模态框，编译后对应源码为5500~5622行
- ``@import "tooltip.less";``    工具提示，编译后对应源码为5623~5720行
- ``@import "popovers.less";``    弹出框，编译后对应源码为5721~5841行
- ``@import "carousel.less";``    轮播，编译后对应源码为5842~6063行


### Utility classes    (2)
- ``@import "utilities.less";``    实用工具类，编译后对应源码为6064~6147行
- ``@import "responsive-utilities.less";``    响应式工具类，编译后对应源码为6148~6357行
















































