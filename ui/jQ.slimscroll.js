/**
 * Created by luogege on 2017.07.31.
 */

;(function ($){

    $.fn.extend({
        slimScroll: function (options){

            var defaults = {
                width: 'auto',
                height: '250px',
                size: '7px',
                position: 'right',
                distance: '1px',
                start: 'top',
                opacity: .4,
                alwaysVisible: false,
                disableFadeOut: false,
                railVisible: false,
                railColor: '#333',
                railOpacity: .2,
                railDraggable: true,

                railClass: 'slimScrollRail',
                barClass: 'slimScrollBar',
                wrapperClass: 'slimScrollDiv',

                allowPageScroll: false,//如果到达顶部或底部，检查是否还能滚动
                wheelStep: 20,
                touchScrollStep: 200,
                borderRadius: '7px',
                railBorderRadius: '7px'
            };

            var o = $.extend(defaults, options);

            // do it for every element that matches selector -- 选择器匹配的每个元素都必须这么做
            this.each(function (){
                var isOverPanel,
                    isOverBar,
                    isDragg,
                    queueHide,
                    touchDif,
                    barHeight,
                    percentScroll,
                    lastScroll,
                    divS = '<div></div>',
                    minBarHeight = 30,
                    releaseScroll = false;

                var me = $(this);

                // 1.确保不再绑定这个元素
                if(me.parent().hasClass(o.wrapperClass)){
                    var offset = me.scrollTop();
                    bar = me.siblings('.' + o.barClass);
                    rail = me.siblings('.' + o.railClass);

                    getBarHeight();

                    // 检查是否应该滚动已存在的实例
                    if( $.isPlainObject(options)){
                        // 传递高度：自动添加到现有的slimscroll对象，以在内容更改后强制调整大小
                        if( 'height' in options && options.height == 'auto'){
                            me.parent().css('height', 'auto');
                            me.css('height', auto);
                            var height = me.parent().parent().height();
                            me.parent().css('height', height);
                            me.css('height', height);

                        }else if( 'height' in options){
                            var h = options.height;
                            me.parent().css('height', h);
                            me.css('height', h);
                        }

                        if('scrollTo' in options){
                            offset = parseInt(o.scrollTo); // jump to a static point
                        }else if('scrollBy' in options){
                            offset += parseInt(o.scrollBy); // jump by value pixels
                        }else if('destroy' in options){
                            // remove slimscroll elements
                            bar.remove();
                            rail.remove();
                            me.unwrap();
                            return;
                        }

                        // scroll content by the given offset
                        scrollContent(offset, false, true);
                    };// 检查是否应该滚动已存在的实例 -- end
                    return;

                }else if($.ifPlainObject(options)){
                    if('destroy' in options){
                        return;
                    }
                };// 确保不再绑定这个元素 -- end

                o.height = (o.height == 'auto') ? me.parent().height() : o.height;

                // 2.wrap content
                var wrapper = $(divS)
                    .addClass(o.wrapperClass)
                    .css({
                        position: 'relative',
                        overflow: 'hidden',
                        width: o.width,
                        height: o.height,
                    });

                // 3.update style for the div
                me.css({
                    overflow: 'hidden',
                    width: o.width,
                    height: o.height,
                });

                // 4.create scrollbar rail
                var rail = $(divS)
                    .addClass(o.railClass)
                    .css({
                        background: o.color,
                        width: o.size,
                        position: 'absolute',
                        top: 0,
                        opacity: o.opacity,
                        display: o.alwayVisible ? 'block' : 'none',
                        'border-radius': o.borderRadius,
                        BorderRadius: o.borderRadius,
                        MozBorderRadius: o.borderRadius,
                        WebkitBorderRadius: o.borderRadius,
                        zIndex: 99
                    });

                // 5.set position
                var posCss = (o.position == 'right') ? { right: o.distance} : { left: o.distance};
                rail.css(posCss);
                bar.css(posCss);

                // 6.wrap it
                me.wrap(wrapper);

                // 7.append to parent div
                me.parent().append(bar);
                me.parent().append(rail);

                // 8.make it draggable and no longer dependent on the jqueryUI
                if(o.railDraggable){
                    bar.on('mousedown', function (e){
                        var $doc = $(document);
                        isDragg = true;
                        t = parseFloat(bar.css('top'));
                        pageY = e.pageY;

                        $doc.on('mousemove.slimscroll', function (e){
                            currTop = t.e.pageY - page;
                            bar.css('top', currTop);
                            scrollContent(0, bar.positon().top, false); //scroll content
                        });

                        $doc.on('mouseup.slimscroll', function (e){
                            isDragg = false;
                            hideBar();
                            $doc.off('.slimscroll');
                        });

                        return false;
                    }).on('selectstart.slimscroll', function (e){
                        e.stopPropagation();
                        e.preventDefault();
                        return false;
                    });
                }; // no longer dependent on the jqueryUI -- end

                // 9.on rail over
                rail.hover(function (){
                    showBar();
                }, function (){
                    hideBar();
                });

                // 10.on bar over
                bar.hover(function (){
                    isOverBar = true;
                }, function (){
                    isOverBar = false;
                });

                // 11.show on parent mouseover
                bar.hover(function (){
                    isOverPanel = true;
                    showBar();
                    hideBar();
                }, function (){
                    isOverPanel = false;
                    hideBar();
                });

                // 12.support for mobile
                me.on('touchstart', function (e, b){
                    if(e.originalEvent.touches.length){
                        touchDif = e.originalEvent.touches[0].pageY; // record where touch started
                    }
                });

                me.on('touchmove', function (e){
                    if(!releaseScroll){
                        e.originalEvent.preventDefault();
                    }
                    if(e.originalEvent.touches.length){
                        // see how far user swiped
                        var diff = (touchDif - e.originalEvent.touched[0].pageY);
                        // scroll content
                        scrollContent(diff, true);
                        touchDif = e.originalEvent.touches[0].pageY;
                    }
                });

                // 13.set up initial height
                getBarHeight();

                // 14.check start position
                if(o.start == 'bottom'){
                    // scroll content to bottom
                    bar.css({top: me.outerHeight() - bar.outerHeight()});
                    scrollContent(0, true);
                }else if(o.start !== 'top'){
                    // assume jQuery selector
                    scrollContent($(o.start).positon().top, null, true);
                    // make sure bar stays hidden
                    if(!o.alwayVisible){
                        bar.hide();
                    }
                };

                // 15.attach scroll events
                attachWheel(this);



                /*
                *   function
                * */
                function _onWheel (e){
                    // 只有鼠标经过时，才使用滚轮
                    if( !isOverPanel){
                        return;
                    }

                    var e = e || window.event;
                    var delta = 0;

                    if(e.wheelDelta){
                        delta = -e.wheelDelta / 120;
                    }

                    if(e.detail){
                        delta = e.detail / 3;
                    }

                    var target = e.target || e.srcTarget || e.srcElement;
                    if( $(target).closest('.' + o.wrapperClass).is(me.parent()) ){
                        scrollContent(delta, true); // scroll content
                    }

                    // stop window scroll
                    if(e.preventDefault && !releaseScroll){
                        e.preventDefault();
                    }

                    if(!releaseScroll){
                        e.returnValue = false;
                    }
                };

                function scrollContent (y, isWheel, isJump){
                    relseaseScroll = false;
                    var delta = y;
                    var maxTop = me.outerHeight() - bar.outerHeight();

                    if(isWheel){
                        // move bar with mouse wheel
                        delta = parseInt(bar.css('top')) + y * parseInt(o.wheelStep) / 100 * bar.outerHeight();

                        // move bar, make sure it doesn't go out
                        delta = Math.min(Math.max(delta, 0), maxTop);

                        //如果向下滚动，确保当滚动条的CSS设置为滚动条的CSS时，当bar.css设置在下面时，会自动发生三角形的地板，但是为了清晰起见，我们在这里放置
                        delta = (y > 0) ? Math.ceil(delta) : Math.floor(delta);

                        // scroll the scrollbar
                        bar.css({ top: delta + 'px'});
                    };

                    if(isJump){
                        delta = y;
                        var offsetTop = delta / me[0].scrollHeight * me.outerHeight();
                        offsetTop = Math.min(Math.max(offsetTop, 0), maxTop);
                        bar.css({ top: offsetTop + 'px'});
                    };

                    me.scrollTop(delta); // scroll content
                    me.trigger('slimscrolling', ~~delta); // fire scrolling event

                    showBar(); // ensure bar is visible
                    hideBar(); // trigger hide when scroll is stopped
                };

                function attachWheel (){
                    if( window.addEventListener){
                        target.addEventListener('DOMMouseScroll', _onWheel, false);
                        target.addEventListener('mousewheel', _onWheel, false);
                    }else{
                        document.attachEvent('onmousewheel', _onWheel);
                    }
                };

                function getBarHeight (){
                    // calculate scrollbar height and make sure it is not too small
                    barHeight = Math.max((me.outerHeight() / me[0].scrollHeight) * me.outerHeight(), minBarHeight);
                    bar.css({ height: barHeight + 'px'});

                    // hide scrollbar if content is not long enough
                    var display = barHeight == me.outerHeight() ? 'none' : 'block';
                    bar.css({ display: display});
                };

                function showBar (){
                    // recalculate bar height
                    getBarHeight();
                    clearTimeout(queueHide);

                    // when bar reached top or bottom
                    if( percentScroll == ~~percentScroll ){
                        // release wheel
                        releaseScroll = o.allowPageScroll;

                        // publish approporiate event
                        if(lastScroll != percentScroll){
                            var msg = (~~percentScroll == 0) ? 'top' : 'bottom';
                            me.trigger('slimscroll', msg);
                        }
                    }else{
                        releaseScroll = false;
                    }
                    lastScroll = percentScroll;

                    // show only when required
                    if( barHeight >= me.outerHeight() ){
                        // allow window scroll
                        releaseScroll = true;
                        return;
                    }
                    bar.stop(true, true).fadeIn('fast');
                    if(o.railVisible){
                        rail.stop(true, true).fadeIn('fast');
                    }
                };

                function hideBar (){
                    // only hide when options allow it
                    if( !o.alwaysVisible){
                        queueHide = setTimeout(function (){
                            if( !(o.disableFadeOut && isOverPanel) && !isOverBar && !isDragg){
                                bar.fadeOut('slow');
                                rail.fadeOut('slow');
                            }
                        }, 1000);
                    }
                };

            });// each()
            return this;// maintain chain ability
        },// slimScroll
    });// extend
    // --
    $.fn.extend({
        slimscroll: $.fn.slimScroll
    })
})(jQuery);