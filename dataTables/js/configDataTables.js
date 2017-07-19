// 默认禁用搜索和排序
$.extend( $.fn.dataTable.defaults, {
    searching: false,
    ordering:  false,

    paging: false,
    scrollY: 400
} );

// 这样初始化，排序将会打开
// 搜索功能仍然是关闭
$('#example').DataTable( {
    ordering: true
} );