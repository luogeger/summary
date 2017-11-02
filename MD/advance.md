### http 
#### [HTTP 协议入门](http://www.ruanyifeng.com/blog/2016/08/http.html)
#### [互联网协议入门(一)](http://www.ruanyifeng.com/blog/2012/05/internet_protocol_suite_part_i.html)
#### [互联网协议入门(二)](http://www.ruanyifeng.com/blog/2012/06/internet_protocol_suite_part_ii.html)

|1|2|3|
|:--:|:--:|:--:|
| 应用层 | HTPP SMTP FTP | TFTP |
| 传输层 | TCP | UDP |
| 网络层 | IP |
| 数据层 物理层 | |

- layer
    - Application - Transport - Network - Link - Physical
     
- HyperText transfer protocol
    - 0.9 
        - 响应完毕，关闭TCP, 只能返回html格式的字符串
    - 1.0 
        - 响应必须告诉客户端，数据是什么格式, ``content-type``
        - 客户端请求的时候也可以声明自己接受哪些数据格式, ``accept``
        - TCP新建成本很高，**三次握手**, 请求时有非标准字段 ``connection: keeep-alive``
    - 1.1 1997年1月
    - 2 2015年

    
### flow & paint
#### [网页性能管理](http://www.ruanyifeng.com/blog/2015/09/web-page-performance-in-depth.html)
- 渲染(render)
    - layout - 生成布局(flow) - 重排(reflow)
    - paint - 布局绘制(paint) - 重绘(repaint)
    - 重绘不一定重排，比如：改变颜色。 改变元素位置的话，重绘、重排都会发生


    
### performance

#### [火焰图](http://www.ruanyifeng.com/blog/2017/09/flame-graph.html)
#### [简书](http://www.jianshu.com/p/4da0f0bda768)
#### [demo指南](https://zhuanlan.zhihu.com/p/29879682)

