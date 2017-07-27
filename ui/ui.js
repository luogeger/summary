/**
 * Created by luogege on 2017.07.21.
 */
;(function (){
    $(document).click(function (){
        $('.dropdown ul').css({'display':'none'});// 点击页面任何地方，下拉框隐藏
    });
    $('.dropdown').each(function (index, item){
        $(item).append('<i class="icon-angle-down"></i>');
        $(item).children('span').click(function (e){
            e.stopPropagation();
            $(this).siblings('i').toggleClass('icon-angle-down').toggleClass('icon-angle-up');
            $(this).siblings('ul').slideToggle(100);
        });
        $(item).find('li').click(function (e){
            e.stopPropagation();
            var span = $(this).parent().siblings('span');
            var txt = $(this).text();
            span.text(txt);
            span.siblings('ul').slideToggle(100);
            span.siblings('i').toggleClass('icon-angle-down').toggleClass('icon-angle-up');
        });
    });
})();