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

    定义了多根轴线的对齐方式，**如果只有一根轴线，这个属性就不起作用**
    
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

### 3.``box-sizing``

### 4.``text-shadow``




























































- 1.an- 在词根前，表示"不，无"

    anarchism无政府主义（an+arch统治+ism→无统治→无政府主义）

    anharmonic不和谐的(an+hamonic和谐的→不和谐的)

    anechoic无回声的（an+echo回声+ic→无回声的）

    anonymous匿名的（an+onym名字+ous→匿名的）



- 2.anti-表示"反对，相反"

    antiwar反战的（anti+war战争）

    antipathy反感（anti+pathy感情）

    antithesis对立；反论（anti+thesis论文；观点）

    antibacterial 抗菌的（anti+bacterial细菌的）

- 3.bi-表示"两个，两"

    biweekly双周刊（bi+week星期+ly→两星期）

    bilingual双语种的（bi+lingu语言+al→双语的）

    biennial两年一次的（bi+enn年+ial→两年〔一次〕的）

    biannual一年两次的（bi+ann[年]+ual→一年两次的）

- 4.contra-表示"反对，相反"

    contrary相反的（contra+ary→相反的）

    contradict反驳；矛盾（contra+dict说→反着说→反驳）

    contravene违反，违背（contra+vene走→反着走→违反）

    contraband走私（contra+band命令→违反命令做事→走私；参考：ban禁止）

- 5.counter-表示"反对，相反"

    counteract对抗；抵消（counter+act行为→反着行动→对抗）

    counterbalance平衡（counter+balance平衡→两边一样→达到平衡）

    countermand撤消（counter+mand命令→反命令→撤消〔命令〕）

- 6.de- 表示"去掉，变坏，离开，变慢，向下"等

    destruction破坏（de+struct结构；建造＋ion→弄坏结构→破坏）

    desalt除去盐分（de+salt盐→去掉盐分）

    deforest砍伐森林（de+forest森林→去掉森林）

    devalue降低价值（de+value价值→去掉价值）

    depress压制，压抑（de+press压→向下压→压制）

    detrain下火车（de+train火车）

    decelerate减速（de+celer速度＋ate→使速度变慢）

    decode破译（de+code密码→去掉密码）

    defame诽谤，中伤（de+fame名声→名声变坏→诽谤）

- 7.semi-表示“半”

    semimonthly半月刊（semi+monthly月刊）

    semicolony半殖民地（semi+colony殖民地）

    semiconductor半导体（semi+conductor导体）

    semicircle半圆（semi+circle圆）

    semiautomatic半自动的（semi+automatic自动的）

- 8.父，祖－patr(i); part(o); pater

    patriarch[patri父，祖arch首脑，长]家长；族长

    patriarchal[见上，－al…的]家长的；族长的；家长似的

    patriot[patri祖→祖国，-ot名词字尾，表示人]爱祖国者，爱国主义者

    patriotic〔见上，-otic形容词字尾，…的〕爱国的

    patriotism[见上，-ism主义]爱国主义；爱国心

    unpatriotic〔un-不，见上〕不爱国的

    patenal〔pater父，-n-,-al…的〕父亲的，父系的

    paternalism[见上，-ism表示行为，现象]家长式统治，家长作风

- 9.ex-① 表示"出，出去"

    exclude排外（ex+clude关闭→关出去→排外）

    expel赶出，逐出（ex+pel推→推出去→逐出）

    expose暴露（ex+plse放→放出去→暴露）
    
    extract抽出，拔出（ex+tract拉→拉出→拔出）

    excise切除(ex+cise切→切出→切除)

    exceed超过，超出（ex+ceed走→走出→超出）

    exhale呼气（ex+hale气→出气→呼气）

    exhume掘出，挖出（ex+hume土→出土→挖出） 

    expurgate净化；删去（ex+purg冲洗＋ate→冲洗出来→净化）

    - ② 表示"前面的，前任的"

    ex-wife前妻（ex前+wife妻子）

    ex-president前任总统（ex前+president总统）


- 10.extra-表示"以外的，超过的"

    extracurriculum课外的(extra+curriculum课程表)

    extraordinary格外的（extra+ordinary变通的→超出普通）

    extrasolar太阳系以外的（extra+solar太阳的）

    extraneous外来的（extra+aneous…的→从外面来的）

    extravagant奢侈的（extra+vag走＋ant→走得过分→奢侈的）

    extrovert性格外向的（extra+vert转→〔性格〕向外转→外向）

    extrapolate推断（extra+polate放→放到〔事实〕外→推断）

- 11.fore-表示"前面，预先"

    forestall阻止（fore+stall阻止）

    forebode预兆；凶兆（fore+bode兆头→预兆）

    forefather前人，祖先（fore+father父亲；祖先）

    forearm前人，祖先（fore+amr胳膊）

    forecast预料（fore+cast扔→预先扔下→预料）

    foreshadow预示，暗示（fore+shadow影子→影子预先来）

- 12.hetero-表示“异类，异种”

    heterosexual异性的（hetero+sexual性别的）

    heterodoxy异教，异端（hetero+doxy观点→观点不同）

    heterogeneous异类的，不同的（hetero+gen产生＋eous→产生不同的）

- 13.homo-表示“同类的”

    homogeneous同类的；同族的（homo+gen产生＋eous→产生相同的）

    homosexual同性恋的（homo+sexual性别的）

    homocentric同中心的（home+centric中心的）相同的方面治疗）

    homogenize使一致（home+gen产生＋ize→产生一致→使一致）



- 14.il-,ir- 放在同辅音词根前表示“不，无”

    illegal非法的（il+legal合法的）

    illiterate 不识字的（il+literate认字的）

    illogical不合逻辑的（il+logical逻辑的）

    illimitable无限的（il+limit限制+able）

    irregular不规则的（ir+regular规则的）

    irrational不合理的（ir+rational合理的）

    irrelative无关的（ir+relative相关的）

    irresolute无决断力的（ir+resolute果断的）

    irreproadchable　无可指责的（ir+reproachable能被指责的）

- 15.inter-表示“在…之间，相互”

    international国际的（inter+national国家的）

    interpersonal人与人之间的（inter+personal个人的）

    interpose置于，介入（inter+pose放→放在二者之间）

    intersect横断（inter+sect切割 →在中间切→横断）

    intervene干涉（inter+vene走→走在二者之间→干涉）

    interaction相互影响（inter+action行动→相互行动→影响）

    interchangeable可互换的（inter+changeable可改变的）

    interlude（活动间的）休息（inter+lude玩→在中间玩→活动间休息）

    interrelate相互关连（inter+relate关连）

- 16.intro-表示“向内，入内”

    introduce引入，介绍（intro+duce引→引进）

    introspect内省，反省（intro+pect看→向内看→内省）

    introvert内向（intro+vert转→向内转→内向）

    intromit插入，干预（intro+mit放→放进去→插入）

    introversible可向内翻的（intro+vers转＋able→能向内转的）

- 17.mono-表示“单个，一个”

    monarch君主，独裁者（mon+arch统治者→一个统治者）

    monogamy 一夫一妻制（mono+gamy婚姻）

    monologue独白（mono+logue说话→一个人说话→独白）

    monopoly垄断（mono+poly→独家卖→垄断）

    monotonous单调的（mono+ton声音+ous→一个声音→单调的）

- 18.Multi-表示”很多,很多”

    multilingual a. 多种语言的(multi+lingual方向的)

    multidirectional a. 多方向的(multi+directional方向的)

    multiple a.多样的;多功能的(multi+pile→多的→多功能的)

    multiply a.乘;繁殖(multi+ply表动词→变多→乘)

    multiform a.多种多样的(multi+form形式)

    multicultural a.多种文化的(multi+cultural文化的)

    multimedia a.多媒体的(multi+media媒介)

    multitude a.多数;群众(multi+tude状态→多的状态→多数)

- 19.poly-表示“多”

    polyandry一妻多制（poly+andry男人）

    polyglot通晓多种语言者（poly+math数学；知识）

    polyfunctional多功能的（poly+functional有功能的）



- 20.neo-表示”新的”

    neonatal a.新生的,被生的(neo+natal出生的)

    neogamist a.新婚者(neo+gamist结婚者)

    neolithic a.新石器时代的(neo+lith石头+ic)

    neophilia a.喜新成癖(neo+phil爱+ia 病→爱新的病)

    neologism a.新词(neo+log词语+ism→新词语)

    neoteric a.新近的;现代的(neo+oteric表形容词→新近的)

- 21.omni-表示”全部.到处”

    omnipresent a.无所不在的(omni+present出现的)

    omnipotent a.全能的(omni+potent的能力的)

    omniscient a.无所示在的(omni+scient知道的)

- 22.pseudo-表示“假，伪”

    pseudo 假的,虚伪的

    pseudonym 假名,笔名(pseudo+nym名字)

    pseudoscience 伪科学(pseudo+science科学)

    pseudograph 冒名作品(pseudo+graph写→写出的假东西)

    pseudology 谎话(pseudo+ology说话→学科说假话)

- 23.sub- 表示“在下面，次一等，副手”

    subdue征服；减轻（sub+due从属→从属在下面→征服）

    subjugate镇压；征服（sub+jug牛轭＋ate→套上牛轭→镇压）

    subliminal潜意识的（sub+limin门槛＋al→在门槛下→在意识之下→潜意识的）

    submerge沉没，淹没(sub+merge淹没→淹没下去)

    submissive恭顺的（sub+miss给→ive→在下面给→恭顺的）

    subordinate附属的（sub+ordin顺序＋ate→顺序在下→附属的）

    suborn收买，贿赂（sub+orn装饰→在下面装饰→贿赂）

    subscribe捐献，订购（sub+scribe写→在下面写上名字→订购）

    subside下陷；平息（sub+terr地＋anean→地下的）

    subterranean地下的（sub+terr转→转下去→推翻）

    subcontinent次大陆（sub+continetn大陆）

    subtropics亚热带（sub+tropics热带）

    subtitle副标题（sub+tropics热带）

    subeditor助理编辑（sub+editor编辑）

    suboffice分办事处（sub+office办公室）

- 24.ultra- 表示“极端”

    ultrapure极纯的（ultra＋pure纯的）

    ultramilitant极端好战的（ultra+militant好斗的）

    ultraclean极洁净的（ultra+clean干净的）

    ultra-reactionary极端反动的（ultra+reactionary反动的）

    ultraliberal极端自由主义的（ultra+liberal自由的）

- 25.deci-表示“十分之一”

    decimeter十分之一米（deci+meter米）

    decigram十分之一克（deci+gram克）

    decimate大量毁灭（decim=deci+ate→杀十分之一，大批杀死）

	

	
	
	
	
	
	