/**
 * Created by luogege on 2017.07.21.
 */


console.log('xiaoiInit');


// -- 点击 document 的事件
$(document).click(function (){
    // 1. 下拉框消失
    $('.dropdown').removeClass('flag-open').removeClass('drop-hover-border');// 清除打开标记 + 边框颜色
    $('.dropdown ul').css({'display':'none'});// 点击页面任何地方，下拉框隐藏
    $('.dropdown i').css({'transform':'rotate(0deg)'});

    // 2. tree-view 改名状态消失
    $('.tree-view li .change .cancel').each(function (i, v){
        $(v).trigger('click');// 双击的时候，让其他的 未保存/取消 的状态消失,
    });

    // 3. datePicker
    $('.datePicker .dateBox').slideUp(10);
});


xiaoiInit();
function xiaoiInit (){
    /*
     *   输入框
     *   1. readonly 属性
     *   2. 是否添加 tip 提示
     * */
    $('.input-group-xs, .input-group-sm, .input-group-md, .input-group-lg').each(function (index, item){
        if($(item).hasClass('readonly')){
            $(this).children('input').attr('readonly', 'readonly');
        }

        if($(item).hasClass('tip-verify')){
            $(this).append('<span class="tip">已经超过6个字</span>');
        }
    })


    /*
     *   单选框
     *   1. 只有最后一个包含 checked 的 input 才能被选中
     *   2. 点击事件
     * */
    var items = []; // 所有包含 checked 属性的 input-radio
    $('.radio-group input:radio').each(function (index, item){
        var spans = '<span class="icon-circle-empty"></span><span class="icon-circle hide"></span>';// 追加的元素

        $(item).wrap('<div class="radio-parent"></div>').after(spans).addClass('hide');
        // 只让最后一个单选框被选中
        if(item.hasAttribute('checked')){
            items.push(item);
        }
    });
    $(items[items.length - 1]).siblings('.icon-circle').removeClass('hide');//给最后一个包含checked的 input-radio 选中

    $('.radio-parent').click(function (){
        $(this).siblings().children('.icon-circle').addClass('hide');
        $(this).children('.icon-circle').toggleClass('hide');
    });


    /*
     *   多选框
     * */
    $('.check-box-group input:checkbox').each(function (index, item){
        var spans = '<span class="icon-check-empty"></span><span class="icon-check hide"></span>';// 追加的元素

        $(item).wrap('<div class="check-parent"></div>').after(spans).addClass('hide');
        if(item.hasAttribute('checked')){
            $(item).siblings('.icon-check').removeClass('hide');
        }
    });
    $('.check-parent').click(function (){
        $(this).children('.icon-check').toggleClass('hide');
    });


    /*
     *   下拉框 -- 自定义属性data-value
     *   1. 下拉框的的宽度保持一致
     * */
    // 1. 下拉框的的宽度保持一致
    $('.dropdown').children('ul').each(function (index, item){
        var width = $(item).parent('.dropdown').css('width');
        $(item).css('width', width);
    })

    $('.dropdown').each(function (index, item){
        //追加icon
        $(item).prepend('<i class="icon-arrow-down"></i>');

        // a 标签设置 自定义属性
        $(item).children('a').attr('data-value', '');

        // li 标签设置 自定义属性
        $(item).children('ul').each(function (index, item){
            $(item).children().each(function (index, item){
                $(item).attr('data-value', index);
            })
        });

        // 点击输入框
        $(item).children('a').click(function (e){
            e.stopPropagation();
            if($(this).parent().hasClass('flag-open')){
                $(this).siblings('i').css({'transform':'rotate(0deg)'});
                $(this).siblings('ul').slideUp(100);
                $(this).parent().removeClass('flag-open').toggleClass('drop-hover-border');
                return;
            }
            $('.dropdown').removeClass('flag-open').removeClass('drop-hover-border');
            $('.dropdown ul').css({'display':'none'});// 点击页面任何地方，下拉框隐藏
            $('.dropdown i').css({'transform':'rotate(0deg)'});
            $(this).parent().addClass('flag-open').toggleClass('drop-hover-border');
            $(this).siblings('i').css({'transform':'rotate(180deg)'});
            $(this).siblings('ul').slideToggle(100);
        });

        // 点击icon
        $(item).children('i').click(function (e){
            e.stopPropagation();
            $(item).children('a').trigger('click');// 相当于点击了 a 标签
        });

        // 点击选项 -- 给 a 标签赋值
        $(item).find('li').click(function (e){
            e.stopPropagation();
            var _a = $(this).parent().siblings('a');
            var txt = $(this).text();
            var val = $(this).data('value');
            _a.text(txt);
            _a.attr('data-value', val);
            _a.siblings('ul').slideToggle(100);
            _a.siblings('i').css({'transform':'rotate(0deg)'});
            $('.dropdown').removeClass('flag-open');
            $(this).parent().parent().toggleClass('drop-hover-border');
        });
    });

    /*
     *   动态生成li标签，重新给 li 标签加上 data-value 属性
     * */
    function dynamicDataValue (){
        $('.dropdown').each(function (index, item){
            $(item).children('ul').each(function (index, item){
                $(item).children().each(function (index, item){
                    $(item).attr('data-value', index);
                })
            });
        })
    };


    /*
     *   tab栏
     *   1. 面包屑 动态添加图标
     *   2. tab 的点击效果
     * */
    // 1.
        $('.tab-crumb .tab-item:not(:first-child)').each(function (index, item){
            $(item).before('<i class="icon-arrow-dbRight"></i>')
        });

    // 2.
        tabEffect($('.tab-underline'), 'contra-underline');
        tabEffect($('.tab-button'), 'contra-button');
        tabEffect($('.tab-border'), 'contra-border');
        tabEffect($('.tab-btn-border'), 'contra-btn-border');
        function tabEffect (dom, cls){
            dom.each(function (index, item){
                $(item).children().each(function (_index, _item){
                    $(_item).click(function (){
                        $(this).parent().children().each(function (i, v){
                            $(v).removeClass(cls);
                        });// 排他
                        $(this).addClass(cls);
                    })
                })
            })
        };


    /*
     *   tree-view
     *   1. 展开目录
     *   2. 改名
     *   3. 取消改名
     *   4. 保存改名
     * */
    ;(function (){
        $('.tree-view li').each(function (index, item){
            var _item = $(item);// 这个是 li 标签

            _item.prepend('<i class="icon-fold-close-fill"></i>');
            if(_item.has('ul').length){
                _item.prepend('<i class="icon-plus-square"></i>');
                collapse(_item);// 展开目录
            }else{
                _item.prepend('<i class="icon-min-square"></i>');
            }

            _item.children('span').dblclick(function (){
                // 双击的时候，让其他的 未保存/取消 的状态消失, -- 必须放在 rename() 的前面
                $('.tree-view li .change .cancel').each(function (i, v){ $(v).trigger('click'); });

                rename(this);// 改名
            });
        });

        // 展开目录
        function collapse (_item){
            _item.children('ul').css({'display': 'none'});
            _item.children('.icon-min-square').addClass('icon-plus').removeClass('icon-min-square');
            _item.children('.icon-plus-square').click(function (){
                if($(this).hasClass('flag-open')){
                    $(this).removeClass('flag-open');
                    $(this).addClass('icon-plus-square').removeClass('icon-min-square');
                    $(this).siblings('ul').slideToggle(100);
                    return;
                }
                $(this).addClass('icon-min-square').removeClass('icon-plus-square');
                $(this).siblings('ul').slideToggle(100);
                $(this).addClass('flag-open');
            })
        };

        // 改名
        function rename (self){
            var _this = $(self);// 这个是 span 标签
            var width = _this.width() + 15 + 'px';
            var html = '<div class="change">' +
                '<input type="text">' +
                '<i class="cancel icon-close-square"></i>' +
                '<i class="save icon-check-square"></i>' +
                '</div>';
            _this.after(html);
            addPrefix();// 添加前缀
            _this.siblings('.change').children('input').css('width', width);
            _this.siblings('.change').children('input').val(_this.text());
            _this.css({'display': 'none'});

            var changeDiv = _this.siblings('.change');// input、cancel、save 的父元素div

            changeDiv.children('input')[0].select();// input 里面的文字被选中
            changeDiv.children('input').click(function (e){
                e.stopPropagation();
            });

            changeDiv.children('.cancel').click(function (e){
                e.stopPropagation();
                cancelRename(_this, changeDiv);// 取消改名
            });

            changeDiv.children('.save').click(function (e){
                saveRename(_this, changeDiv);// 保存改名
                e.stopPropagation();
            });
        };

        // 取消改名
        function cancelRename (span, div){
            div.remove();
            span.css({'display': 'inline-block'});
        };

        // 保存改名
        function saveRename (span, div){
            var text = div.children('input').val();
            span.text(text);
            div.remove();
            span.css({'display': 'inline-block'});
        };
    })();


    /*
     *   tree-view-slim -- 目录结构
     * */
    ;(function (){
        $('.tree-view-slim li').each(function (index, item){
            var _item = $(item);// 这是 li 标签
            // hover -- 效果
            _item.children('a').hover(function (){
                var _this = $(this);
                if(_this.hasClass('flag-open')){
                    return;
                }
                _this.toggleClass('a-hover');
            },function (){
                var _this = $(this);
                _this.removeClass('a-hover');
            })

            // 点击 -- 展开目录
            if(_item.has('ul').length){
                collapse(_item, 'if');// 展开目录 -- 如果有 子级菜单
            }else{
                collapse(_item);// 展开目录 -- 没有 子级菜单
            };
        });

        // 展开目录
        function collapse (_item, flag){
            if(flag == 'if'){
                _item.children('a').prepend('<i class="icon-contract"></i>');
                _item.children('ul').css({'display': 'none'});
                _item.children('a').click(function (){
                    var _this = $(this);
                    clearClick();// 遍历所有 a 标签，清除 点击样式
                    if(_this.hasClass('flag-open')){
                        _this.siblings('ul').slideToggle(100);
                        _this.children('i').css({'transform':'rotate(0deg)'});
                        _this.removeClass('flag-open');
                        _this.addClass('a-hasChild');
                        return;
                    }
                    _this.siblings('ul').slideToggle(100);
                    _this.children('i').css({'transform':'rotate(90deg)'});
                    _this.addClass('flag-open a-hasChild');
                });
            }
            else{
                _item.children('a').prepend('<i class="icon-circle"></i>');
                _item.children('a').click(function (){
                    clearClick();// 遍历所有 a 标签，清除 点击样式
                    $(this).addClass('a-noChild');
                });
            };

            // 遍历所有 a 标签，清除 点击样式
            function clearClick (){
                $('.tree-view-slim li').each(function (i, v){
                    $(v).children('a').removeClass('a-noChild a-hasChild');
                })
            };
        };
    })();


    /*
     *   分页
     *    - 2种样式的分页
     * */
    $('.pages-line>ul>li:not(.line-point)').click(function (){
        $('.pages-line ul>li:not(.line-point)').each(function (index, item){
            $(item).removeClass('line-contra');
        });
        $(this).addClass('line-contra');
    });

    $('.pages-filled>ul>li:not(.line-point)').click(function (){
        $('.pages-filled>ul>li:not(.line-point)').each(function (index, item){
            $(item).removeClass('filled-contra');
        });
        $(this).addClass('filled-contra');
    })


    /*
     *   datePicker
     * */
    ;(function (){
        //  字符串拼接、追加
        $('.datePicker').each(function (index, item){
            var inputStr = $(item).html();
            var htmlStr = '';

            strJoin();
            function strJoin (){
                htmlStr =
                    '<div class="container">'+
                    '<div class="inputBox">'+
                    inputStr +
                    '<i class="icon-cale-a"></i>'+
                    '</div>'+
                    '<div class="dateBox">'+
                    '<!-- 初始化 -->'+
                    '<div class="init-box">'+
                    '<div class="date-head">'+
                    '<i class="icon-arrow-dbLeft prev-year"></i>'+
                    '<i class="icon-arrow-left prev-month"></i>'+
                    '<span class="select-time">'+
                    '<span class="select-year" data-val="2017">2017年</span>'+
                    '<span class="select-month" data-val="09">9月</span>'+
                    '</span>'+
                    '<i class="icon-arrow-right next-month"></i>'+
                    '<i class="icon-arrow-dbRight next-year"></i>'+
                    '</div>'+
                    '<div class="date-body">'+
                    '<table>'+
                    '<thead>'+
                    '<tr>'+
                    '<th>一</th>'+
                    '<th>二</th>'+
                    '<th>三</th>'+
                    '<th>四</th>'+
                    '<th>五</th>'+
                    '<th>六</th>'+
                    '<th>日</th>'+
                    '</tr>'+
                    '</thead>'+
                    '<tbody>'+
                    '<tr>'+
                    '<td class="inactive">28</td>'+
                    '<td class="inactive">29</td>'+
                    '<td class="inactive">30</td>'+
                    '<td class="inactive">31</td>'+
                    '<td>1</td>'+
                    '<td>2</td>'+
                    '<td>3</td>'+
                    '</tr>'+
                    '<tr>'+
                    '<td>4</td>'+
                    '<td>5</td>'+
                    '<td>6</td>'+
                    '<td>7</td>'+
                    '<td>8</td>'+
                    '<td>9</td>'+
                    '<td>10</td>'+
                    '</tr>'+
                    '<tr>'+
                    '<td class="active today">11</td>'+
                    '<td>12</td>'+
                    '<td>13</td>'+
                    '<td>14</td>'+
                    '<td>15</td>'+
                    '<td>16</td>'+
                    '<td>17</td>'+
                    '</tr>'+
                    '<tr>'+
                    '<td>18</td>'+
                    '<td>19</td>'+
                    '<td>20</td>'+
                    '<td>21</td>'+
                    '<td>22</td>'+
                    '<td>23</td>'+
                    '<td>24</td>'+
                    '</tr>'+
                    '<tr>'+
                    '<td>25</td>'+
                    '<td>26</td>'+
                    '<td>27</td>'+
                    '<td>28</td>'+
                    '<td>29</td>'+
                    '<td>30</td>'+
                    '<td class="inactive">1</td>'+
                    '</tr>'+
                    '<tr>'+
                    '<td class="inactive">2</td>'+
                    '<td class="inactive">3</td>'+
                    '<td class="inactive">4</td>'+
                    '<td class="inactive">5</td>'+
                    '<td class="inactive">6</td>'+
                    '<td class="inactive">7</td>'+
                    '<td class="inactive">8</td>'+
                    '</tr>'+
                    '</tbody>'+
                    '</table>'+
                    '</div>'+
                    '<div class="date-foot">'+
                    '<span class="foot-time">'+
                    '<input type="text" class="select-hour" value="00">:'+
                    '<input type="text" class="select-minute" value="00">:'+
                    '<input type="text" class="select-second" value="00">'+
                    '</span>'+
                    '<span class="foot-btn">'+
                    '<span class="btn-today" class="datePickerNow">此刻</span>'+
                    '<span class="btn-empty" class="datePickerEmpty">清空</span>'+
                    '<span class="btn-ok" class="datePickerConfirm">确认</span>'+
                    '</span>'+
                    '</div>'+
                    '</div>'+
                    '<!-- 年份 -->'+
                    '<div class="year-box">'+
                    '<div class="date-head">'+
                    '<i class="icon-arrow-dbLeft prev-year"></i>'+
                    '<span class="select-year">2010 - 2019</span>'+
                    '<i class="icon-arrow-dbRight next-year"></i>'+
                    '</div>'+
                    '<div class="date-body">'+
                    '<table>'+
                    '<tbody>'+
                    '<tr>'+
                    '<td><span><i class="icon-arrow-dbLeft"></i></span></td>'+
                    '<td><span>2010</span></td>'+
                    '<td><span>2011</span></td>'+
                    '</tr>'+
                    '<tr>'+
                    '<td><span>2012</span></td>'+
                    '<td class="active"><span>2013</span></td>'+
                    '<td><span>2014</span></td>'+
                    '</tr>'+
                    '<tr>'+
                    '<td><span>2015</span></td>'+
                    '<td><span>2016</span></td>'+
                    '<td><span>2017</span></td>'+
                    '</tr>'+
                    '<tr>'+
                    '<td><span>2018</span></td>'+
                    '<td><span>2019</span></td>'+
                    '<td><span><i class="icon-arrow-dbRight"></i></span></td>'+
                    '</tr>'+
                    '</tbody>'+
                    '</table>'+
                    '</div>'+
                    '</div>'+
                    '<!-- 月份 -->'+
                    '<div class="month-box">'+
                    '<div class="date-head">'+
                    '<i class="icon-arrow-dbLeft prev-year"></i>'+
                    '<span class="select-month">2017</span>'+
                    '<i class="icon-arrow-dbRight next-year"></i>'+
                    '</div>'+
                    '<div class="date-body">'+
                    '<table>'+
                    '<tbody>'+
                    '<tr>'+
                    '<td><span>一月</span></td>'+
                    '<td><span>二月</span></td>'+
                    '<td><span>三月</span></td>'+
                    '</tr>'+
                    '<tr>'+
                    '<td><span>四月</span></td>'+
                    '<td><span>五月</span></td>'+
                    '<td><span>六月</span></td>'+
                    '</tr>'+
                    '<tr>'+
                    '<td><span>七月</span></td>'+
                    '<td><span>八月</span></td>'+
                    '<td class="active"><span>九月</span></td>'+
                    '</tr>'+
                    '<tr>'+
                    '<td><span>十月</span></td>'+
                    '<td><span>十一月</span></td>'+
                    '<td><span>十二月</span></td>'+
                    '</tr>'+
                    '</tbody>'+
                    '</table>'+
                    '</div>'+
                    '</div>'+
                    '<!-- 小时 -->'+
                    '<div class="hour-box">'+
                    '<div class="date-head">'+
                    '<span>选择小时</span>'+
                    '</div>'+
                    '<div class="date-body">'+
                    '<table>'+
                    '<tbody>'+
                    '<tr>'+
                    '<td>0</td>'+
                    '<td>1</td>'+
                    '<td>2</td>'+
                    '<td>3</td>'+
                    '</tr>'+
                    '<tr>'+
                    '<td>4</td>'+
                    '<td>5</td>'+
                    '<td>6</td>'+
                    '<td class="active">7</td>'+
                    '</tr>'+
                    '<tr>'+
                    '<td>8</td>'+
                    '<td>9</td>'+
                    '<td>10</td>'+
                    '<td>11</td>'+
                    '</tr>'+
                    '<tr>'+
                    '<td>12</td>'+
                    '<td>13</td>'+
                    '<td>14</td>'+
                    '<td>15</td>'+
                    '</tr>'+
                    '<tr>'+
                    '<td>16</td>'+
                    '<td>17</td>'+
                    '<td>18</td>'+
                    '<td>19</td>'+
                    '</tr>'+
                    '<tr>'+
                    '<td>20</td>'+
                    '<td>21</td>'+
                    '<td>22</td>'+
                    '<td>23</td>'+
                    '</tr>'+
                    '</tbody>'+
                    '</table>'+
                    '</div>'+
                    '</div>'+
                    '<!-- 分钟 -->'+
                    '<div class="minute-box">'+
                    '<div class="date-head">'+
                    '<span>选择小时</span>'+
                    '</div>'+
                    '<div class="date-body">'+
                    '<table>'+
                    '<tbody>'+
                    '<tr>'+
                    '<td>0</td>'+
                    '<td>1</td>'+
                    '<td>2</td>'+
                    '<td>3</td>'+
                    '<td>4</td>'+
                    '<td>5</td>'+
                    '<td>6</td>'+
                    '<td>7</td>'+
                    '<td>8</td>'+
                    '<td>9</td>'+
                    '</tr>'+
                    '<tr>'+
                    '<td>10</td>'+
                    '<td>11</td>'+
                    '<td class="active">12</td>'+
                    '<td>13</td>'+
                    '<td>14</td>'+
                    '<td>15</td>'+
                    '<td>16</td>'+
                    '<td>17</td>'+
                    '<td>18</td>'+
                    '<td>19</td>'+
                    '</tr>'+
                    '<tr>'+
                    '<td>20</td>'+
                    '<td>21</td>'+
                    '<td>22</td>'+
                    '<td>23</td>'+
                    '<td>24</td>'+
                    '<td>25</td>'+
                    '<td>26</td>'+
                    '<td>27</td>'+
                    '<td>28</td>'+
                    '<td>29</td>'+
                    '</tr>'+
                    '<tr>'+
                    '<td>30</td>'+
                    '<td>31</td>'+
                    '<td>32</td>'+
                    '<td>33</td>'+
                    '<td>34</td>'+
                    '<td>35</td>'+
                    '<td>36</td>'+
                    '<td>37</td>'+
                    '<td>38</td>'+
                    '<td>39</td>'+
                    '</tr>'+
                    '<tr>'+
                    '<td>40</td>'+
                    '<td>41</td>'+
                    '<td>42</td>'+
                    '<td>43</td>'+
                    '<td>44</td>'+
                    '<td>45</td>'+
                    '<td>46</td>'+
                    '<td>47</td>'+
                    '<td>48</td>'+
                    '<td>49</td>'+
                    '</tr>'+
                    '<tr>'+
                    '<td>50</td>'+
                    '<td>51</td>'+
                    '<td>52</td>'+
                    '<td>53</td>'+
                    '<td>54</td>'+
                    '<td>55</td>'+
                    '<td>56</td>'+
                    '<td>57</td>'+
                    '<td>58</td>'+
                    '<td>59</td>'+
                    '</tr>'+
                    '</tbody>'+
                    '</table>'+
                    '</div>'+
                    '</div>'+
                    '<!-- 秒数 -->'+
                    '<div class="second-box">'+
                    '<div class="date-head">'+
                    '<span>选择秒</span>'+
                    '</div>'+
                    '<div class="date-body">'+
                    '<table>'+
                    '<tbody>'+
                    '<tr>'+
                    '<td>0</td>'+
                    '<td>1</td>'+
                    '<td>2</td>'+
                    '<td>3</td>'+
                    '<td>4</td>'+
                    '<td>5</td>'+
                    '<td>6</td>'+
                    '<td>7</td>'+
                    '<td>8</td>'+
                    '<td>9</td>'+
                    '</tr>'+
                    '<tr>'+
                    '<td>10</td>'+
                    '<td>11</td>'+
                    '<td>12</td>'+
                    '<td class="active">13</td>'+
                    '<td>14</td>'+
                    '<td>15</td>'+
                    '<td>16</td>'+
                    '<td>17</td>'+
                    '<td>18</td>'+
                    '<td>19</td>'+
                    '</tr>'+
                    '<tr>'+
                    '<td>20</td>'+
                    '<td>21</td>'+
                    '<td>22</td>'+
                    '<td>23</td>'+
                    '<td>24</td>'+
                    '<td>25</td>'+
                    '<td>26</td>'+
                    '<td>27</td>'+
                    '<td>28</td>'+
                    '<td>29</td>'+
                    '</tr>'+
                    '<tr>'+
                    '<td>30</td>'+
                    '<td>31</td>'+
                    '<td>32</td>'+
                    '<td>33</td>'+
                    '<td>34</td>'+
                    '<td>35</td>'+
                    '<td>36</td>'+
                    '<td>37</td>'+
                    '<td>38</td>'+
                    '<td>39</td>'+
                    '</tr>'+
                    '<tr>'+
                    '<td>40</td>'+
                    '<td>41</td>'+
                    '<td>42</td>'+
                    '<td>43</td>'+
                    '<td>44</td>'+
                    '<td>45</td>'+
                    '<td>46</td>'+
                    '<td>47</td>'+
                    '<td>48</td>'+
                    '<td>49</td>'+
                    '</tr>'+
                    '<tr>'+
                    '<td>50</td>'+
                    '<td>51</td>'+
                    '<td>52</td>'+
                    '<td>53</td>'+
                    '<td>54</td>'+
                    '<td>55</td>'+
                    '<td>56</td>'+
                    '<td>57</td>'+
                    '<td>58</td>'+
                    '<td>59</td>'+
                    '</tr>'+
                    '</tbody>'+
                    '</table>'+
                    '</div>'+
                    '</div>'+
                    '</div>'+
                    '</div>';
            };

            $(item).html(htmlStr);
        })

        //  box 显示隐藏
        $('.datePicker .dateBox').click(function (e){ e.stopPropagation(); });//  阻止冒泡
        $('.datePicker .inputBox').click(function (e){
            e.stopPropagation();// 先阻止冒泡
            $('.datePicker .dateBox').each(function (index, item){ $(item).slideUp(10); })// 在排他
            $(this).siblings('.dateBox').slideDown(10);
        });




        var $initBox = $('.datePicker .init-box');// 初始化
        var $yearBox = $('.datePicker .year-box');// 年份
        var $monthBox = $('.datePicker .month-box');// 月份
        var $hourBox = $('.datePicker .hour-box');// 小时
        var $minuteBox = $('.datePicker .minute-box');// 分钟
        var $secondBox = $('.datePicker .second-box');// 秒数
        // td 外面追加 span, 初始化、小时、分钟、秒数
        $('.datePicker .init-box td, .datePicker .hour-box td, .datePicker .minute-box td, .datePicker .second-box td').each(function (index, item){
            var text = $(item).text();
            $(item).text('').append('<span>'+ text +'</span>');
        });

        // 年 (4)
        $('.datePicker  .select-year').click(function (){
            var _this = $(this);
            _this.parents('.init-box').css('display', 'none');
            _this.parents('.init-box').siblings('.year-box').css('display','block');
            var allTd= $(this).parents('.init-box').siblings('.year-box').find('td');
            allTd.each(function (index, item){
                $(item).click(function (){
                    if(index !== 0 && index !== allTd.length - 1){
                        _this.parents('.init-box').css('display', 'block');
                        $(item).parents('.year-box').css('display','none');
                    }
                })
            })
        })

        // 月 (2)
        $('.datePicker  .select-month').click(function (){
            var _this = $(this);
            _this.parents('.init-box').css('display', 'none');
            _this.parents('.init-box').siblings('.month-box').css('display','block');
            var allTd= $(this).parents('.init-box').siblings('.month-box').find('td');
            allTd.each(function (index, item){
                $(item).click(function (){
                    _this.parents('.init-box').css('display', 'block');
                    $(item).parents('.month-box').css('display','none');
                })
            })
        })

        // 日
        $('.datePicker  .init-box .date-body tbody td').each(function (index, item){
            var _item = $(item);
            _item.click(function (){
                $(this).parents('tbody').find('td').each(function (i, v){ $(v).removeClass('active'); });// 先排他
                $(this).addClass('active');// 再加上
                getTime(this);
            })
        })

        // 小时
        $('.datePicker  .select-hour').click(function (){
            var _this = $(this);
            _this.parents('.init-box').css('display', 'none');
            _this.parents('.init-box').siblings('.hour-box').css('display','block');
            $(this).parents('.init-box').siblings('.hour-box').find('td').each(function (index, item){
                $(item).click(function (){
                    _this.parents('.init-box').css('display', 'block');
                    $(item).parents('.hour-box').css('display','none');
                    var val = $(this).children('span').text();// 获取值
                    if(parseInt(val) <  10){ val = '0' + val; };//  前面加0
                    $(this).parents('.hour-box').siblings('.init-box').find('.select-hour').val(val)[0].focus();// 返回input获取焦点
                    getTime(this);
                })
            })
        })

        // 分钟
        $('.datePicker  .select-minute').click(function (){
            var _this = $(this);
            _this.parents('.init-box').css('display', 'none');
            _this.parents('.init-box').siblings('.minute-box').css('display','block');
            $(this).parents('.init-box').siblings('.minute-box').find('td').each(function (index, item){
                $(item).click(function (){
                    _this.parents('.init-box').css('display', 'block');
                    $(item).parents('.minute-box').css('display','none');
                    var val = $(this).children('span').text();// 获取值
                    if(parseInt(val) <  10){ val = '0' + val; };//  前面加0
                    $(this).parents('.minute-box').siblings('.init-box').find('.select-minute').val(val)[0].focus();// 返回input获取焦点
                    getTime(this);
                })
            })
        })

        // 秒数
        $('.datePicker  .select-second').click(function (){
            var _this = $(this);
            _this.parents('.init-box').css('display', 'none');
            _this.parents('.init-box').siblings('.second-box').css('display','block');
            $(this).parents('.init-box').siblings('.second-box').find('td').each(function (index, item){
                $(item).click(function (){
                    _this.parents('.init-box').css('display', 'block');
                    $(item).parents('.second-box').css('display','none');
                    var val = $(this).children('span').text();// 获取值
                    if(parseInt(val) <  10){ val = '0' + val; };//  前面加0
                    $(this).parents('.second-box').siblings('.init-box').find('.select-second').val(val)[0].focus();// 返回input获取焦点
                    getTime(this);
                })
            })
        })

        // 清空
        $('.datePicker .init-box .btn-empty').click(function (){
            $(this).parents('.dateBox').siblings('.inputBox').children('input').val('');
        })

        // 确认
        $('.datePicker .init-box .btn-ok').click(function (){
            $(this).parents('.dateBox').slideUp(10);
        })

        // 此刻
        $('.datePicker .init-box .btn-today').click(function (){

        })


        /*
         *   获取值显示到input
         * */
        function getTime (ele){
            var initBox = $(ele).parents('.container').find('.init-box');
            var year = initBox.children('.date-head').find('.select-year').data('val');
            var month = initBox.children('.date-head').find('.select-month').data('val');
            var today = initBox.children('.date-body').find('.active span').text();
            if(parseInt(today) <  10){ today = '0' + today; };//  前面加0
            var hour = initBox.children('.date-foot').find('.select-hour').val();
            var minute = initBox.children('.date-foot').find('.select-minute').val();
            var second = initBox.children('.date-foot').find('.select-second').val();


            var results = year +'-'+ month +'-'+ today +'  '+ hour +':'+ minute +':'+ second;
            initBox.parent('.dateBox').siblings('.inputBox').children('input').val(results);
        };

    })();// end - datePicker
};//  end  inputInit();


// -- 1. 弹出层 -- model
// -- 2. 侧边滑出-- sidle
// -- 3. **每次都要 remove #mask-layer
window.ui = {
    modal: function (ele){
        uiModal(ele);
    },
    sidle: function (ele){
        uiSidle(ele);
    },
    slider: function (ele, option){
        uiSlider(ele, option);
        window.onload = function (){
            var height = $('.slider').find('.slider-main-item').eq(0).css('height');
            $('.slider').css('height', height)

        }
    }
};

function uiModal (ele){
    // dom元素
    if(typeof ele == 'string' && $(ele).length > 0){
        $(ele).wrap(("<div id='mask-layer'></div>"));// 给 id 元素包裹 遮罩层
        $('body').css({'overflow': 'hidden', 'padding-right': '17px'});// body 滚动条消失
        $(ele).animate({'top': '0px'}, 300, function (){
            $('#mask-layer').css({'overflow-y': 'auto'});// 背景层的滚动条显示
        });// 弹窗内容 显示
        $(ele).click(function (e){  e.stopPropagation(); });// 阻止冒泡

        $('#mask-layer').click(function (){
            $(ele).animate({'top': '-3000px'}, 100, function (){
                $(this).parent().before($(this));// 保留 dom 元素
                $('#mask-layer').remove();// 删除 #mask-layer
                $('body').css({'overflow': 'auto', 'padding-right': '0'});
            });
        });
    }
    // 数组
    else if(ele instanceof Array){
        var html =
            '<div id="mask-layer">'+
            '<div class="layer-popup">'+
            '<div class="title">'+
            '<span>提示</span>'+
            '<i class="icon iconfont icon-close-line close"></i>'+
            '</div>'+
            '<div class="content">'+
            '<div class="content-text">'+ ele[0] +'</div>'+
            '</div>'+
            '<div class="opera clearfix">'+
            '<button class="btn btn-sm pull-right cancel">取消</button>'+
            '<button class="btn btn-sm btn-theme pull-right confirm">确认</button>'+
            '</div>'+
            '</div>'+
            '</div>';
        $('body').css({'overflow': 'hidden', 'padding-right': '17px'}).append(html);// 弹窗 追加
        $('.layer-popup').animate({'top': '0px'}, 100).click(function (e){
            e.stopPropagation();
        });// 弹窗 显示

        // 点击 #mask-layer、关闭、取消
        $('#mask-layer, #mask-layer .close, #mask-layer .cancel').each(function (index, item){
            $(item).click(function (){
                $('.layer-popup').animate({'top': '-1000px'}, 100, function (){
                    $('#mask-layer').remove();// 删除 整个遮罩层 以及里面的 弹窗
                    $('body').css({'overflow': 'auto', 'padding-right': '0'});
                });// 弹窗 消失
            });
        });

        // 点击确认
        $('#mask-layer .confirm').click(function (){
            ele[1]();// 传过来的函数执行
            $('.layer-popup').animate({'top': '-1000px'}, 100, function (){
                $('#mask-layer').remove();// 清除 整个遮罩层 以及 弹窗
                $('body').css({'overflow': 'auto', 'padding-right': '0'});
            });// 弹窗 消失
        });

    }
    // 其他
    else{
        alert('ui.model(参数错误)');
    }
};

function uiSidle (ele){
    var _ele = $(ele);
    var html =
        '<div id="mask-layer">'+
            '<div class="layer-sidle">'+
                '<div class="title">'+
                    '<span>提示</span>'+
                    '<i class="icon iconfont icon-close-line close"></i>'+
                '</div>'+
                '<div class="content"></div>'+
            '</div>'+
        '</div>';
    _ele.before(html);
    var _body = $('body');
    var _layer = $('#mask-layer');
    var _sidle = $('.layer-sidle');
    var _content = $('.layer-sidle .content');
    var css = {'left': '-1000px', 'borderRadius': '0px 6px 6px 0px'};
    var height = _sidle.outerHeight() - $('.title').outerHeight() + 'px';
    var width = $(ele).outerWidth();// 获取dom元素的宽度


    _content.append(_ele.remove());
    _sidle.css(css).animate({'left': '0px'}, 300);// sidle 显示
    _sidle.click(function (e){ e.stopPropagation(); });// 阻止冒泡
    _body.css({'overflow': 'hidden', 'padding-right': '17px'});

    // 滚动条
    _content.append(_ele.css({'display': 'block'})).css({'max-height': height}).slimScroll({ height: "100%", width: width, });

    // 隐藏 滑动事件
    $('#mask-layer, #mask-layer .icon-close-line').each(function (index, item){
        $(item).click(function (){
            _sidle.animate({'left': '-1000px'}, 150);// sidle 消失
            _ele.parents('#mask-layer').before(_ele.css({'display': 'none'}));// 保留 dom 元素
            _layer.animate({'opacity': '0'}, 200, function (){
                _layer.remove()
            });// 删除 #mask-layer
            _body.css({'overflow': 'auto', 'padding-right': '0'});
        });
    });
};

function uiSlider (ele, obj){
    var $ele = $(ele);
    var data = obj.data;// data 必须是数组，每一项是对象
    var sliderWidth = obj.data.length + 1 + '00%';// .slider-main 的宽度
    $ele.html(parserDataHtml())
    var $arrow = $ele.find('.extra-page a');// 左右箭头
    var $extraNav = $ele.find('.extra-nav');// 数字导航 -- ul
    var $navItem = $extraNav.children('.extra-nav-item');// 数字导航 -- li
    var $sliderMain = $ele.find('.slider-main');// 图片的 ul
    var $imgAll = $ele.find('.slider-main-item');// 所有图片 -- li
    var $imgNum = $ele.find('.slider-main-item').length;// 所有图片的数量
    var $imgWidth = $ele.width();// 每张图片的宽度

    var $prev = $ele.find('.extra-page-prev');// 上一页
    var $next = $ele.find('.extra-page-next');// 下一页




    bindEvent();
    function parserDataHtml (){
        var sliderMainList = [],
            sliderNavList = [],
            resultsList = [];

        sliderMainList.push('<ul class="slider-main clearfix" style="width:'+ sliderWidth +'">');
        data.forEach(function (item, index){
            sliderMainList.push('<li class="slider-main-item" style="width:'+ $ele.width()+'px' +'">');
            //sliderMainList.push('<li class="slider-main-item">');
            sliderMainList.push('<a href="'+ item.href +'">');
            sliderMainList.push('<img src="'+ item.src +'" title="'+ item.title +'"/>');
            sliderMainList.push('</a>');
            sliderMainList.push('</li>');
        });
        sliderMainList.push('</ul>');


        sliderNavList.push('<ul class="extra-nav clearfix">');
        data.forEach(function (item, i){
            var index = i +1;
            if(i >= 1){
                sliderNavList.push('<li class="extra-nav-item"><span></span><i class=" icon iconfont icon-circle"></i></li>');

            }else{
                sliderNavList.push('<li class="extra-nav-item"><span></span><i class=" icon iconfont icon-circle"></i></li>');
            }
        });
        sliderNavList.push('</ul>');


        resultsList.push('<div class="slider" data-index="0">');
        resultsList.push(sliderMainList.join(''));
        resultsList.push('<div class="slider-extra">');
        resultsList.push(sliderNavList.join(''));


        resultsList.push('<div class="extra-page">');
        resultsList.push('<a href="javascript:;" class="extra-page-prev">&lt;</a>');
        resultsList.push('<a href="javascript:;" class="extra-page-next">&gt;</a>');
        resultsList.push('</div>');
        resultsList.push('</div>');

        return resultsList.join('');
    };

    function bindEvent (){
        //左右导航的显示隐藏
        $ele.hover(function (){
            $arrow.css('z-index', '0');
        },function (){
            $arrow.css('z-index', '-1');
        });


        //数字导航
        var currentIndex = '';// 当前索引
        $navItem.each(function (index, item){
            var _item = $(item);
            _item.click(function (){
                currentIndex = index;
                $navItem.each(function (i, v){ $(v).children('span').css('opacity', '.3'); });// 排他
                $(this).children('span').css('opacity', '0');
                setIndex(index);// 设置索引 -> 确定移动的距离
            });
        });

        //克隆
        $sliderMain.append($imgAll.eq(0).clone(true));

        //左右导航
        $prev.click(function (){
            currentIndex--;
            if(currentIndex <= 0){
                currentIndex = $imgNum -1;
            }
            setIndex(currentIndex);// 设置索引 -> 确定移动的距离
        });
        $next.click(function (){
            currentIndex++;
            if(currentIndex >= $imgNum){
                currentIndex = 0;
            }
            setIndex(currentIndex);// 设置索引 -> 确定移动的距离
        });


        //设置索引 -> 确定移动的距离
        function setIndex (index){
            var target = -index * $imgWidth;// 目标距离
            autoPlay($sliderMain, target);
        };
    };

    function autoPlay (ele, target){
        clearInterval(ele.timeId);// 清除当前对象的定时器
        ele.timeId = setInterval(function (){
            var step = 30;
            var distance = ele[0].offsetLeft;// 当前距离
            step =  distance < target ? step : -step;


            if(Math.abs(distance - target) > Math.abs(step)){// 判断步长和最后的距离
                distance = distance + step;
                ele[0].style.left = distance + 'px';
            }else {
                clearInterval(ele.timeId);// 清除当前对象的定时器
                ele[0].style.left = target + 'px';// 给到一个最后的定值
            }
        }, 10);
    };
};// end -- uiSlider


// -- 滚动条
;(function (f) {
    jQuery.fn.extend({
        slimScroll: function (h) {
            var a = f.extend({
                width: "auto",
                height: "250px",
                size: "5px",
                color: "#000",
                position: "right",
                distance: "1px",
                start: "top",
                opacity: 0.4,
                alwaysVisible: !1,
                disableFadeOut: !1,
                railVisible: !1,
                railColor: "#333",
                railOpacity: 0.2,
                railDraggable: !0,
                railClass: "slimScrollRail",
                barClass: "slimScrollBar",
                wrapperClass: "slimScrollDiv",
                allowPageScroll: !1,
                wheelStep: 2,
                touchScrollStep: 200,
                borderRadius: "7px",
                railBorderRadius: "7px"
            }, h);
            this.each(function () {
                function r(d) {
                    if (s) {
                        d = d ||
                            window.event;
                        var c = 0;
                        d.wheelDelta && (c = -d.wheelDelta / 120);
                        d.detail && (c = d.detail / 3);
                        f(d.target || d.srcTarget || d.srcElement).closest("." + a.wrapperClass).is(b.parent()) && m(c, !0);
                        d.preventDefault && !k && d.preventDefault();
                        k || (d.returnValue = !1)
                    }
                }

                function m(d, f, h) {
                    k = !1;
                    var e = d, g = b.outerHeight(false) - c.outerHeight(false);
                    f && (e = parseInt(c.css("top")) + d * parseInt(a.wheelStep) / 100 * c.outerHeight(false), e = Math.min(Math.max(e, 0), g), e = 0 < d ? Math.ceil(e) : Math.floor(e), c.css({top: e + "px"}));
                    l = parseInt(c.css("top")) / (b.outerHeight(false) - c.outerHeight(false));
                    e = l * (b[0].scrollHeight - b.outerHeight(false));
                    h && (e = d, d = e / b[0].scrollHeight * b.outerHeight(false), d = Math.min(Math.max(d, 0), g), c.css({top: d + "px"}));
                    b.scrollTop(e);
                    b.trigger("slimscrolling", ~~e);
                    v();
                    p()
                }

                function C() {
                    window.addEventListener ? (this.addEventListener("DOMMouseScroll", r, !1), this.addEventListener("mousewheel", r, !1), this.addEventListener("MozMousePixelScroll", r, !1)) : document.attachEvent("onmousewheel", r)
                }

                function w() {
                    u = Math.max(b.outerHeight(false) / b[0].scrollHeight * b.outerHeight(false), D);
                    c.css({height: u + "px"});
                    var a = u == b.outerHeight(false) ? "none" : "block";
                    c.css({display: a})
                }

                function v() {
                    w();
                    clearTimeout(A);
                    l == ~~l ? (k = a.allowPageScroll, B != l && b.trigger("slimscroll", 0 == ~~l ? "top" : "bottom")) : k = !1;
                    B = l;
                    u >= b.outerHeight(false) ? k = !0 : (c.stop(!0, !0).fadeIn("fast"), a.railVisible && g.stop(!0, !0).fadeIn("fast"))
                }

                function p() {
                    a.alwaysVisible || (A = setTimeout(function () {
                        a.disableFadeOut && s || (x || y) || (c.fadeOut("slow"), g.fadeOut("slow"))
                    }, 1E3))
                }

                var s, x, y, A, z, u, l, B, D = 30, k = !1, b = f(this);
                if (b.parent().hasClass(a.wrapperClass)) {
                    var n = b.scrollTop(),
                        c = b.parent().find("." + a.barClass), g = b.parent().find("." + a.railClass);
                    w();
                    if (f.isPlainObject(h)) {
                        if ("height" in h && "auto" == h.height) {
                            b.parent().css("height", "auto");
                            b.css("height", "auto");
                            var q = b.parent().parent().height();
                            b.parent().css("height", q);
                            b.css("height", q)
                        }
                        if ("scrollTo" in h) n = parseInt(a.scrollTo); else if ("scrollBy" in h) n += parseInt(a.scrollBy); else if ("destroy" in h) {
                            c.remove();
                            g.remove();
                            b.unwrap();
                            return
                        }
                        m(n, !1, !0)
                    }
                } else {
                    a.height = "auto" == a.height ? b.parent().height() : a.height;
                    n = f("<div></div>").addClass(a.wrapperClass).css({
                        position: "relative",
                        overflow: "hidden", width: a.width, height: a.height
                    });
                    b.css({overflow: "hidden", width: a.width, height: a.height});
                    var g = f("<div></div>").addClass(a.railClass).css({
                        width: a.size,
                        height: "100%",
                        position: "absolute",
                        top: 0,
                        display: a.alwaysVisible && a.railVisible ? "block" : "none",
                        "border-radius": a.railBorderRadius,
                        background: a.railColor,
                        opacity: a.railOpacity,
                        zIndex: 90
                    }), c = f("<div></div>").addClass(a.barClass).css({
                        background: a.color,
                        width: a.size,
                        position: "absolute",
                        top: 0,
                        opacity: a.opacity,
                        display: a.alwaysVisible ?
                            "block" : "none",
                        "border-radius": a.borderRadius,
                        BorderRadius: a.borderRadius,
                        MozBorderRadius: a.borderRadius,
                        WebkitBorderRadius: a.borderRadius,
                        zIndex: 1
                    }), q = "right" == a.position ? {right: a.distance} : {left: a.distance};
                    g.css(q);
                    c.css(q);
                    b.wrap(n);
                    b.parent().append(c);
                    b.parent().append(g);
                    a.railDraggable && c.bind("mousedown", function (a) {
                        var b = f(document);
                        y = !0;
                        t = parseFloat(c.css("top"));
                        pageY = a.pageY;
                        b.bind("mousemove.slimscroll", function (a) {
                            currTop = t + a.pageY - pageY;
                            c.css("top", currTop);
                            m(0, c.position().top, !1)
                        });
                        b.bind("mouseup.slimscroll", function (a) {
                            y = !1;
                            p();
                            b.unbind(".slimscroll")
                        });
                        return !1
                    }).bind("selectstart.slimscroll", function (a) {
                        a.stopPropagation();
                        a.preventDefault();
                        return !1
                    });
                    g.hover(function () {
                        v()
                    }, function () {
                        p()
                    });
                    c.hover(function () {
                        x = !0
                    }, function () {
                        x = !1
                    });
                    b.hover(function () {
                        s = !0;
                        v();
                        p()
                    }, function () {
                        s = !1;
                        p()
                    });
                    b.bind("touchstart", function (a, b) {
                        a.originalEvent.touches.length && (z = a.originalEvent.touches[0].pageY)
                    });
                    b.bind("touchmove", function (b) {
                        k || b.originalEvent.preventDefault();
                        b.originalEvent.touches.length &&
                        (m((z - b.originalEvent.touches[0].pageY) / a.touchScrollStep, !0), z = b.originalEvent.touches[0].pageY)
                    });
                    w();
                    "bottom" === a.start ? (c.css({top: b.outerHeight(false) - c.outerHeight(false)}), m(0, !0)) : "top" !== a.start && (m(f(a.start).position().top, null, !0), a.alwaysVisible || c.hide());
                    C()
                }
            });
            return this
        }
    });
    jQuery.fn.extend({slimscroll: jQuery.fn.slimScroll})
})(jQuery);


//  navigate
//  1. #nav-head
//  .nav-head-info-tip 的hover事件
$('.nav-head-info-tip').hover(function (){
    $(this).find('.info-tip-menu').slideToggle(10);
},function (){
    $(this).find('.info-tip-menu').slideToggle(10);
});


//  2. #nav-sidle
//  #collapse-btn 收展侧边栏
function toggleCollapse(){
    var open = $("#collapse-btn").hasClass("to-close");
    if(open){
        $('#nav-content').css({'padding-left': '5px'});
        $("#collapse-btn").removeClass("to-close").addClass("to-open");// 改变箭头方向，以及位置
        $('#nav-sidle').animate({'left': '-180px'}, 200);
    }else{

        $('#nav-content').css({'padding-left': '180px'});
        $("#collapse-btn").removeClass("to-open").addClass("to-close");// 改变箭头方向，以及位置
        $('#nav-sidle').animate({'left': '0px'}, 200);
    }
};


//  右边小箭头
var collapseBtn =
    '<div id="collapse-btn" class="to-close" onclick="toggleCollapse()">'+
        '<div class="collapse-btn-nav">'+
            '<i class="icon-arrow-left"></i>'+
        '</div>'+
    '</div>';
$('#nav-sidle').prepend(collapseBtn);


//  #nav-sidle -> accordion
$('#accordion-nav a').each(function (index, item){
    var _item = $(item);
    _item.click(function (){
        // 这里是一级菜单的 a 标签
        if(_item.parent().hasClass('panel')){
            if(_item.hasClass('flag-open')){
                _item.siblings('ul').slideToggle(200);
                _item.children('i:last-child').css('transform', 'rotate(0deg)');
                _item.removeClass('flag-open');
            }else{
                _item.siblings('ul').slideToggle(200);
                _item.children('i:last-child').css('transform', 'rotate(90deg)');
                _item.addClass('flag-open');
            }
        }

        $('#accordion-nav a').each(function (i, v){
            $(v).removeClass('active');
        });
        $(this).addClass('active');
    });

    // 默认展开父级菜单
    if(_item.hasClass('active')){
        _item.parents('ul').slideDown(200).siblings('a').addClass('flag-open').children('i:last-child').css('transform', 'rotate(90deg)');
    }
});


// #nav-sidle -> accordion的滚动条
$("#accordion-nav").slimScroll({
    height: "100%",
    width: "180px",
});


//  #nav-content -> padding + min-Height
var navContentHeight = $('#nav-head').css('height');
var navContentWidth =  $('#nav-sidle').css('width');
var navContentMinHeight = $(window).height();
$('#nav-content').css({'paddingTop': navContentHeight, 'paddingLeft': navContentWidth, 'min-height': navContentMinHeight});

//  #nav-sidle -> top值的设置
if($('#nav-head').length > 0){
    $('#nav-sidle').css({'top': $('#nav-head').css('height')})
}else{
    $('#nav-sidle').css({'top': '0'})
}


// -- 放在最后, 图标的 class 前缀 'icon iconfont', 动态添加
addPrefix();
function addPrefix (){
    $('i[class*=icon], span[class*=icon]').each(function (index, item){
        if(!$(item).hasClass('icon iconfont')){
            $(item).addClass('icon iconfont');
        }
    });
};