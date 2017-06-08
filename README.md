
# CSS



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





