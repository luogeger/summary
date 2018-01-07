/**
 * Created by luogege on 2017.01.17.
 */
$(function () {
    var $asideLis = $('.aside ul li');
    var $mainUls = $('.main ul');
    var indexLi ;
    var testFns = [];
    var ajaxFns = [];

    function mainFind (sel, text){
        return $('.main>'+sel+'').append('<li>'+text+'</li>');
    };

    testFns[0] = function (){
        $.ajax({
            cache: false,
            type: "get",
            url: "https://api.douban.com/v2/movie/top250",
            dataType: "jsonp",
            success: function (data) {
                var abc = template('ul_temp', {arr:data});
                $('.main>.movie').append(abc);
                //console.log(data);
                //console.log(data.subjects);
                //console.info(abc);

            },
            error: function () {
                console.log('error');
            }
        });
    };

    //testFns[0] = function test (){
    //    mainFind('.movie', 'movieText')
    //};

    testFns[1] = function book (){
        return  mainFind('.book', 'bookText')
    };

    testFns[2] = function music (){
        return  mainFind('.music', 'musicText')
    };

    testFns[3] = function radio (){
        return  mainFind('.radio', 'radioText')
    };

    testFns[4] = function photo (){
        return  mainFind('.photo', 'photoText')
    };

    //---
    ajaxFns[0] = function (){
        $.ajax({
            type: "get",
            url: "https://api.douban.com/v2/movie/top250",
            dataType: "jsonp",
            success: function (data) {
                var abc = template('ul_temp', {arr:data});
                $('.main>.movie').append(abc);
                //console.log(data);
                //console.log(data.subjects);
                //console.info(abc);

            },
            error: function () {
                console.log('error');
            }
        });
    };

    testFns[0]();

    //---
    $('.aside ul').on('click', 'li', function(){
        indexLi = $asideLis.index($(this));
        $mainUls.each(function(index,value){
            $(value).addClass('isNone');
        });
        $($mainUls[indexLi]).removeClass('isNone');
        testFns[indexLi]();
    });



});