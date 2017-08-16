/**
 * Created by luogege on 2017.07.21.
 */
;(function (){
    /*
    *   动态获取 data-value
    *   1. 如果下拉框里面的数据如果是动态获取的，就要在执行一次这个函数
    * */
    window.dyanmicDataValue = dyanmicDataValue;


    /*
    *   点击 document 的事件
    * */
    $(document).click(function (){
        // 1. 下拉框消失
        $('.dropdown').removeClass('flag-open').removeClass('drop-hover-border');// 清除打开标记 + 边框颜色
        $('.dropdown ul').css({'display':'none'});// 点击页面任何地方，下拉框隐藏
        $('.dropdown i').css({'transform':'rotate(0deg)'});

        // 2. tree-view 改名状态消失
        $('#tree-view li .change .cancel').each(function (i, v){
            $(v).trigger('click');// 双击的时候，让其他的 未保存/取消 的状态消失,
        });

    });


    /*
    *   下拉框 -- 自定义属性data-value
    * */
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
    *   动态生成li标签，再一次给li标签，加data-value
    * */
    function dyanmicDataValue (){
        $('.dropdown').each(function (index, item){
            $(item).children('ul').each(function (index, item){
                $(item).children().each(function (index, item){
                    $(item).attr('data-value', index);
                })
            });
        })
    };


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
    *   tab栏
    *   1. 面包屑 动态添加图标
    *   2. tab 的点击效果
    * */
    // 1.
    $('.nav-crumb .nav-item:not(:first-child)').each(function (index, item){
        $(item).before('<i class="icon-arrow-right"></i>')
    });
    // 2.
    tabEffect($('.nav-underline'), 'opposite-underline');
    tabEffect($('.nav-button'), 'opposite-button');
    tabEffect($('.nav-border'), 'opposite-border');
    tabEffect($('.nav-btn-border'), 'opposite-btn-border');
    function tabEffect (dom, cls){
        dom.each(function (index, item){
            $(item).children().each(function (_index, _item){
                $(_item).click(function (){
                    $(this).parent().children().each(function (i, v){
                        $(v).removeClass(cls);
                    });
                    $(this).addClass(cls);
                })
            })
        })
    };



    /*
    *   分页
    *    - 2种样式的分页
    * */
    $('.pages-line>ul>li:not(.point)').click(function (){
        $('.pages-line ul>li:not(.point)').each(function (index, item){
            $(item).removeClass('line-opposite');
        });
        $(this).addClass('line-opposite');
    });

    $('.pages-filled>ul>li:not(.point)').click(function (){
        $('.pages-filled>ul>li:not(.point)').each(function (index, item){
            $(item).removeClass('filled-opposite');
        });
        $(this).addClass('filled-opposite');
    })


    /*
    *   tree-view
    *   1. 展开目录
    *   2. 改名
    *   3. 取消改名
    *   4. 保存改名
    * */
    ;(function (){
        $('#tree-view li').each(function (index, item){
            var _item = $(item);// 这个是 li 标签

            if(_item.has('ul').length){
                collapse(_item);// 展开目录
            }

            _item.children('span').dblclick(function (){
                // 双击的时候，让其他的 未保存/取消 的状态消失, -- 必须放在 rename() 的前面
                $('#tree-view li .change .cancel').each(function (i, v){ $(v).trigger('click'); });

                rename(this);// 改名
            });
        });

        // 展开目录
        function collapse (_item){
            _item.children('ul').css({'display': 'none'});
            _item.children('.icon-arrow-down').addClass('icon-arrow-up').removeClass('icon-arrow-down');
            _item.children('.icon-arrow-up').click(function (){
                if($(this).hasClass('flag-open')){
                    $(this).removeClass('flag-open');
                    $(this).addClass('icon-arrow-up').removeClass('icon-arrow-down');
                    $(this).siblings('ul').slideToggle(100);
                    return;
                }
                $(this).addClass('icon-arrow-down').removeClass('icon-arrow-up');
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
                '<i class="cancel icon-arrow-left"></i>' +
                '<i class="save icon-arrow-right"></i>' +
                '</div>';
            _this.after(html);
            addPrefix();// 添加前缀
            _this.siblings('.change').children('input').css('width', width);
            _this.siblings('.change').children('input').val(_this.text());
            _this.css({'display': 'none'});

            var changeDiv = _this.siblings('.change');// input、cancel、save 的父元素div

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
    *   目录结构 -- dirStructure
    * */
    ;(function (){
        $('#accordion li').each(function (index, item){
            var _item = $(item);// 这是 li 标签


            if(_item.has('ul').length){
                collapse(_item);// 展开目录
            }else{
                // 这里没有子级菜单的标签
                _item.children('a').prepend('<i class="icon-circle"></i>');
                _item.children('a').click(function (){
                    $('#accordion li').each(function (i, v){
                        $(v).children('a').removeClass('a-textColor');
                    })
                    $(this).addClass('a-textColor');
                });
            };
        });

        // 展开目录
        function collapse (_item){
            // _item 是 li 标签
            _item.children('a').prepend('<i class="icon-arrow-right"></i>');
            _item.children('ul').css({'display': 'none'});
            _item.children('a').click(function (){
                var _this = $(this);
                if(_this.hasClass('flag-open')){
                    _this.siblings('ul').slideToggle(100);
                    _this.children('i').css({'transform':'rotate(0deg)'});
                    _this.removeClass('flag-open');
                    return;
                }
                _this.siblings('ul').slideToggle(100);
                _this.children('i').css({'transform':'rotate(90deg)'});
                _this.addClass('flag-open');
            });
        };

    })();



    /*
    *   1. 弹出层 -- model
    *   2. 侧边滑出-- sidle
    * */
    window.ui = {
        model: function (ele){ uiModel(ele); },
        sidle: function (ele){ uiSidle(ele); }
    };

    function uiModel (ele){
        // undefined
        if(ele == undefined){
            console.log('undefined');
        }

        // dom元素
        if(typeof ele == 'string' && $(ele).length > 0){
            $(ele).wrap(("<div id='mask-layer'></div>"));// 给 id 元素包裹 遮罩层
            $('body').css({'overflow': 'hidden'});// body 滚动条消失
            $(ele).animate({'top': '0px'}, 300, function (){
                $('#mask-layer').css({'overflow-y': 'auto'});// 背景层的滚动条显示
            });// 弹窗内容 显示
            $(ele).click(function (e){  e.stopPropagation(); });// 阻止冒泡

            $('#mask-layer').click(function (){
                $(ele).animate({'top': '-5000px'}, 300, function (){
                    $(this).parent().before($(this));
                    $('#mask-layer').remove();
                    $('body').css({'overflow': 'auto'});
                });
            });
        }

        // 对象
        if(ele instanceof Array){
            var html =
                '<div id="mask-layer">'+
                    '<div class="layer-popup">'+
                        '<div class="title">'+
                            '<span>提示</span>'+
                            '<i class="icon iconfont icon-arrow-right close"></i>'+
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
            $('body').css({'overflow': 'hidden'}).append(html);
            $('#mask-layer .close, #mask-layer .cancel').each(function (index, item){
                $(item).click(function (){
                    $('#mask-layer').remove();
                    $('body').css({'overflow': 'auto'});
                });
            });

            $('#mask-layer .confirm').click(function (){
                ele[1]();// 传过来的函数执行
                $('#mask-layer').remove();
                $('body').css({'overflow': 'auto'});
            });

        };
    };

    function uiSidle (ele){
        $('body').prepend("<div id='mask-layer'></div>").css({'overflow': 'hidden'});
        $('#mask-layer').click(function (){
            $(this).css({'display': 'none'});
            $('body').css({'overflow': 'auto'});
        });
    };





















    /*
     *   -- 放在最后, 图标的 class 前缀 'icon iconfont', 动态添加
     * */
    addPrefix();
    function addPrefix (){
        $('i[class*=icon], span[class*=icon]').each(function (index, item){
            if(!$(item).hasClass('icon iconfont')){
                $(item).addClass('icon iconfont');
            }
        });
    };

})();// -- end