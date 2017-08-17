$(function (){

    initDataTable();

})


//初始化表格
    function initDataTable() {
        $("#tableId").dataTable().fnDestroy();//清除表格
        var temp = $.extend(true, {}, tableOptions, {
            //scrollY: 500,
            "aLengthMenu": [3, 10, 20, 30, 60, 80], // 选择每页加载的数据量
            "paging": false, // 页容量
            "lengthChange": false, // 也是选择页容量
            "searching": false, // 查找
            "bInfo": true,//页脚 左边记录 信息
            //"pagingType": "full_numbers",// 分页
            //"paging": true,
            "bPaginate" : true,

            renderer: "bootstrap",
            "sAjaxSource": "center.json",
            "fnServerData": retrieveData, //与后台交互获取数据的处理函数
            "select": {
                style: 'multi',
                selector: 'td:first-child'
            },
            "aoColumns": [
                {
                    "mData": "name",
                    "mRender": function (data, type, row) {
                        if (data) {
                            return data;
                        } else {
                            return '--';
                        }
                    }
                }
                , {
                    "mData": "address",
                    "mRender": function (data, type, row) {
                        if (data) {
                            return data;
                        } else {
                            return '--';
                        }
                    }
                }

                , {
                    "mData": "remark",
                    "mRender": function (data, type, row) {
                        if (data) {
                            return data;
                        } else {
                            return '--';
                        }
                    },
                }
                , {
                    "mData": "id",
                    "mRender": operateRender,
                    'fnCreatedCell': function (nTd) {
                        $(nTd).css('text-align', 'center');
                    }
                }
            ],
        });
        $("#tableId").dataTable(temp);
    }

//异步获取
    function retrieveData(sSource, aoData, fnCallback) {
        console.log('sSource', sSource);
        console.log('aoData', aoData);
        console.log('fnCallback', fnCallback);

        var row; //默认一次加载10条
        var start; //从第几条开始
        $.each(eval(aoData), function (i, field) {//转换为json对象
            console.info('-i', i);
            console.info('--field', field);
            console.info('---field.name', field.name);

            if (field.name == "iDisplayStart") {
                start = field.value;
            }
            if (field.name == "iDisplayLength") {
                row = field.value;
            }
        });

        var query = {
            page: conversionPages(start, row),
            rows: row
        };
        console.log('query', query);
        $.getJSON(sSource, query, function (rm) {
            if (rm.code == 200) {
                var data = rm.result.pageInfo;
                data.iTotalRecords = rm.result.pageInfo.total;
                data.iTotalDisplayRecords = rm.result.pageInfo.total;
                fnCallback(data);
            } else {
                toastr.error(resp.msg);
            }
        });
    }


//操作列
    function operateRender(data, type, row) {
        var str =  '<a id="'+ row.id + '">' +
            '<span class="glyphicon glyphicon-list-alt" title="详情" onclick="dataDetail(\'' + row.id + '\')">' +
            '</span></a>&nbsp;&nbsp;' +
            '<a id="' + row.id + '" href="javascript:void(0);" title="删除" ">' +
            '<span class="fa fa-trash-o"  onclick="dataTrash(\'' + row.id + '\',\'' + row.alias + '\')">' +
            '</span></a>';
        return str;
    }


//详情和删除按钮的事件
    function dataDetail(id){
        console.log('详情');
        //loadMainPage('itam-content','pages/resource/dataCenterDetails.jsp?dataCenterId='+id);
    }
    function dataTrash(id,name) {
        console.error('删除失败')
        jConfirm("是否删除型号 " + name + " 的信息？", "操作提示", function (r) {
            if(r){
                $.ajax({
                    "type":"DELETE",
                    "url":"data-center/delete?dataCenterId="+id,
                    "data":{},
                    "dataType":"json",
                    "success":function(resp){
                        if(resp.code == "200"){
                            toastr.success("删除成功！");
                            initDataTable();
                        }else{
                            toastr.error("删除失败！");
                        }
                    },
                    "error":function(resp){
                        toastr.error(resp.msg);
                    }
                });
            }
        });
    }

//重置
    function resetSearch(){
        $("#name-search").val("");
        initDataTable();
    }
