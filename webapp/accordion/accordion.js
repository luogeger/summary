/*
*   #collapse-btn 收展侧边栏
* */
function toggleCollapse(){
    var open = $("#collapse-btn").hasClass("to-close");
    if(open){
        $("#collapse-btn").removeClass("to-close");
        $("#collapse-btn").addClass("to-open");
        $('#sidebar').addClass('sidebar-hide');
        $('#content').css({'padding-left': '20px'});
    }else{
        $("#collapse-btn").removeClass("to-open");
        $("#collapse-btn").addClass("to-close");
        $('#sidebar').removeClass('sidebar-hide');
        $('#content').css({'padding-left': '190px'});
    }

};