# Compatibility

## compatibility -> html + css

### 1. DOCTYPE
1. 首先页面开始部分要有DOCTYPE的声明。
2. 它是告诉浏览器使用什么样的规范来解析HTML文档。
```
会带来一下影响：
1. 对标记、attributes、properties的约束规则
2. 对渲染模式的影响，主要是对CSS代码甚至javascrit脚本的解析
```

### 2. meta标签调节浏览器的渲染方式
```HTML
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
```
- 使用meta标签来强制IE8使用最新的内核渲染页面。
- IE=edge：表示强制使用IE最新内核，chrome=1：表示如果安装了针对低版本浏览器插件Google Chrome Frame，那么就用chrome内核来渲染``这种方式可以让用户的浏览器外观依然是IE的菜单和界面，实际上使用的是chrome内核``
> 关于国内的双核浏览器的做法稍有不同。代码如下：
```HTML
<meta name="renderer" content="webkit">
```

### 3. CSS3的某些特性
- IE8不支持css3的很多新特性，一般都是用比较成熟的hack方法来解决。
- 例：[CSS3 PIE](http://css3pie.com/)
- **特别注意：** 一定阅读CSS PIE给出的[Know Issues](http://css3pie.com/documentation/known-issues/)

### 4. HTML5元素
- 前端代码HTML的新标签，``nav/footer``等，在IE中无法正常显示，使用[html5shiv](https://github.com/aFarkas/html5shiv)

### 5. max-width
- ``max-width: 100%;``一般来显示图片的宽度最大为父容器的宽度。有时候却不奏效。
- IE解析max-width所遵循的规则：严格要求**直接父元素**的宽度是固定的。
- (1)td中的max-width
针对td中的img元素设置max-width: 100%; 在IE和FF中不奏效，需要给table设置``table-layout： fixed；`` 该属性的具体解释[W3School](http://www.w3school.com.cn/cssref/pr_tab_table-layout.asp)
- (2)嵌套标签中的max-width
```HTML
<div class="box">
    <a href="#" class="box-link">
        <img src="sample.jpg" class="box-image img-responsive">
    </a>
</div>
```
- 如果``.box``设置了固定宽度，但是对img设置``max-width: 100%;``是无效的。
- 必须再对a标签设置``width: 100%;``，才能让最内层的img标签充满整个div.

### 6. 嵌套inline-block下padding元素重叠
```HTML
<ul>
    <li><a>1</a></li>
    <li><a>2</a></li>
    <li><a>3</a></li>
</ul>
```
```css
ul li{
    display: inline-block;
}
ul li a{
    display: inline-block;
    padding: 10px 15px;
}
```
- 按理说，a标签的水平距离应该是30px, 但是在IE8中出现了重叠，只有15px。解决方法：``float: left;``代替``display: inline-block;``实现水平布局。
- http://stackoverflow.com/questions/11783084/menu-items-overlapping-in-ie8
- http://forums.devshed.com/css-help-116/overlapping-text-list-ie-8-a-936017.html

### 7. placeholder
- IE8不支持HTML5属性placeholder, 解决方案：js插件。[jquery-placeholder](https://github.com/mathiasbynens/jquery-placeholder)

### 8. last-child
- first-child是css2的内容。但是last-child就不是了，所以IE8不买账。
- 推荐方案：不使用，**对，你没有看错，不用这个属性。**而是给最后一个元素设置一个``.last``的**class** ，然后对此样式设置，这样就全部兼容了。

### 9. background-size: cover;
- 设置全屏背景，很遗憾，IE8真的做不到。但是IE独有的AlphaImageLoader滤镜可以实现，添加下面的CSS样式：
```
filter: progid:DXImageTransform.Microsoft.AlphaImageLoader(enabled=Enabled, sizingMethod=Size , src=URL)
```
再把sizingMethod设置成scale就OK了。
> 还没完，在此背景上放置的链接是无法点击的。一般解决方案: 为链接或按钮添加``position: relative;``让它相对浮动。

### filter blur
- CSS3中提供支持滤镜效果的属性``filter``，比如支持高斯模糊效果的blur
```javascript
filter: blur(10px);
-webkit-filter: blur(10px);
-moz-filter: blur(10px);
```
- IE8对``filter: blur(10px)``的显示效果是对HTML元素进行小范围的模糊处理，并不是高斯模糊，如果想要高斯模糊，设置如下：
```javascript
filter: progid:DXImageTransform.Microsoft.Blur(PixelRadius='10');
```
> **pit:** 实践中发现，所有``position: relative;``的元素都不会生效。
- 其他的发现，IE9对``filter: blur(10px)``无效，而对``filter: progid:DXImageTransform.Microsoft.Blur(PixelRadius='10');``是针对小范围的模糊效果。




## compatibility -> javasScript 
- className: 获取拥有这个类名的所有标签，在进行判断
- 事件参数e: window.event
- 添加事件：主流是addEventListener, IE是：attachEvent
- 获取目标元素：主流是e.target, IE是：e.srcElement
- 获取标签文本之间的内容：IE8+是：obj.innerText, FF+是：obj.tentContent
- IE浮动之后有个双边距现象
- margin合并现象：垂直方向可以合并，但是不能包含合并。解决：良好的编码习惯避免
- IE8以下的版本，宽高不包括padding 和 border。
- 获取滚动距离

### javasScript

- 获取滚动距离
```javascript
function scroll() {
    var scrollTop = document.body.scrollTop || document.documentElement.scrollTop;;
    var scrollLeft = document.body.scrollLeft || document.documentElement.scrollLeft;

    var obj = {
        scrollTop : scrollTop,
        scrollLeft : scrollLeft
    };

    return obj;
};
```
