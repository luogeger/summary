<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
    <style>
        .isHide{
            display: none;
        }
        .labelPad{
            padding: 7px 10px 5px 5px ;
        }
        .bor{
            /*border: 1px solid red;*/
        }
        .m0{
            margin: 0;
        }
    </style>

<!--  nav  -->
    <div class="console-title console-title-border">
        <h3>资产管理系统</h3>
        <h5>1号机柜</h5>
        <h5 class="nav_det">详情</h5>
    </div>

<!-- operation -->
    <div class="add-operation">
        <button class="btn btn-info edit">
            <span class="fa fa-edit"></span>
            编辑
        </button>
        <button class="btn btn-info save isHide">
            <span class="fa fa-floppy-o "></span>
            保存
        </button>
        <button class="btn btn-primary cancel isHide" style="margin-left:30px;" >
            <span class="fa fa-undo"></span>
            取消
        </button>
    </div>

<!--  info  -->
    <div class="row m0 bor">
        <div class="col-sm-6 col-md-6">
            <!--  机柜编号 -->
            <div class="col-btn col-xs-12 pt20">
                <label class="col-sm-2 col-md-2 control-label text-left labelPad"  for="monitor-btn">机柜编号</label>
                <div class="col-sm-9 col-md-9 col-input">
                    <input type="text" class="form-control">
                </div>
            </div>
            <!-- 型号 -->
            <div class="col-btn col-xs-12 pt20">
                <label class="col-sm-2 col-md-2 control-label text-left labelPad"  for="monitor-btn">型号</label>
                <div class="col-sm-9 col-md-9 col-input">
                    <input type="text" class="form-control">
                </div>
            </div>
            <!-- 数据中心 -->
            <div class="col-btn col-xs-12 pt20">
                <label class="col-sm-2 col-md-2 control-label text-left labelPad"  for="monitor-btn">数据中心</label>
                <div class="col-sm-9 col-md-9 col-input">
                    <input type="text" class="form-control">
                </div>
            </div>
            <!-- 备注 -->
            <div class="col-btn col-xs-12 pt20">
                <label class="col-sm-2 col-md-2 control-label text-left labelPad"  for="monitor-btn">备注</label>
                <div class="col-sm-9 col-md-9 col-input">
                    <textarea cols="10" rows="4" class="form-control" style="resize:none;"></textarea>
                </div>
            </div>
        </div><!--  left end-->
        <div class="col-sm-6 col-md-6">
            <!--  厂商  -->
            <div class="col-btn col-xs-12 pt20">
                <label class="col-sm-2 col-md-2 control-label text-left labelPad"  for="monitor-btn">厂商</label>
                <div class="col-sm-9 col-md-9 col-input">
                    <input type="text" class="form-control">
                </div>
            </div>
            <!--  总U位 -->
            <div class="col-btn col-xs-12 pt20">
                <label class="col-sm-2 col-md-2 control-label text-left labelPad"  for="monitor-btn">总U位</label>
                <div class="col-sm-9 col-md-9 col-input">
                    <input type="text" class="form-control">
                </div>
            </div>
            <!-- 所属机房 -->
            <div class="col-btn col-xs-12 pt20">
                <label class="col-sm-2 col-md-2 control-label text-left labelPad"  for="monitor-btn">所属机房</label>
                <div class="col-sm-9 col-md-9 col-input">
                    <input type="text" class="form-control">
                </div>
            </div>

        </div><!--  right  end-->
    </div><!--  info  end -->

<!--  Table  -->
    <div class="row m0">
        <label class="col-sm-1 col-md-1 control-label text-lef labelPad" for="monitor-btn">关联设备</label>
        <div class="col-sm-11 col-md-11 bor">

        </div>
    </div>

<script>
    $(function (){
        var editBtn = $('.add-operation .edit');
        var saveBtn = $('.add-operation .save');
        var cancelBtn = $('.add-operation .cancel');
        var arrHide = [editBtn, saveBtn, cancelBtn];
        editBtn.dblclick(function (){
            hideshow(arrHide);
            $('.nav_det').text('编辑');
        });
        saveBtn.on('click', function () {
            hideshow(arrHide);
            $('.nav_det').text('详情');
        });
        cancelBtn.on('click', function () {
            hideshow(arrHide);
            $('.nav_det').text('详情');
        });


        //按钮显示隐藏
        function hideshow (arr){
            var i, len = arr.length;
            for(i = 0; i < len; i++){
                arr[i].toggleClass('isHide');
            }
        };
    });
    //
    $(function () {
        initDataTable();
    });

    //初始化表格
    function initDataTable() {
        $("#comRoom-table").dataTable().fnDestroy();//清除表格
        var temp = $.extend(true, {}, tableOpions, {
            "sAjaxSource": "../../resources/json/dataCenter.json",
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
                    "mData": "vendor",
                    "mRender": function (data, type, row) {
                        if (data) {
                            return data;
                        } else {
                            return '--';
                        }
                    }
                }

                , {
                    "mData": "describe",
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
        $("#comRoom-table").dataTable(temp);
    }

    //异步获取
    function retrieveData(sSource, aoData, fnCallback) {
        var row; //默认一次加载10条
        var start; //从第几条开始
        $.each(eval(aoData), function (i, field) {//转换为json对象
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
        var str = '<a id="' + row.id + '" >' +
                '<span ' +
                'class="glyphicon glyphicon-list-alt" title="详情" ' +
                'onclick="modelDetail(\'' + row.type + '\', \'' + row.brandName + '\')">' +
                '</span>' +
                '</a>&nbsp;&nbsp;'
                + '' +
                '<a id="' + row.id + '" href="javascript:void(0);" title="删除" ">' +
                '<span class="fa fa-trash-o"  onclick="modelTrash(\'' + row.id + '\')">' +
                '</span>' +
                '</a>';
        return str;
    }

    //详情和删除按钮的事件
    function modelDetail(type, name) {
        console.log(type);
        console.log(name);
        loadMainPage('itam-content', 'pages/resource/dataCenterDetails.jsp?type=' + encodeURI(encodeURI(type)) + '&brandName=' + encodeURI(encodeURI(name)));
    }
    function modelTrash(model) {
        jConfirm("是否删除型号 " + model + " 的信息？", "操作提示", function (r) {
            if (r) {
                toastr.success("删除类型成功！");
            }
        });
    }
</script>















