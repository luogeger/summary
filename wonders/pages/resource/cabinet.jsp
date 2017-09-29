<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>

<div class="console-title console-title-border">
    <h6>资产管理系统</h6>
    <h6>资源管理</h6>
    <h6>机柜</h6>
</div>
<div class="row-fluid">
    <div class="btn-group">
        <div class="input-group input-group-sm input-group-width">
            <span class="input-group-addon input-group-span">机柜编码</span>
               <span class="input-group-addon input-group-input">
                   <input type="text" class="form-control input-search" id="name-search">
               </span>
        </div>
    </div>
    <div class="advanced-search-btn" onclick="spreadSearch()" style="cursor: pointer;">
        高级搜索
        <span class="fa fa-caret-down" ></span>
    </div>


    <div class="pull-right ">
        <button type="reset" class="btn btn-link icon-plus iconlarge" style="color:#0093c6;text-decoration:none"
        	 onclick="loadMainPage('itam-content','pages/resource/cabinetAdd.jsp');">
        	添加
        	</button>
        <button type="reset" class="btn btn-link icon-share iconlarge" style="color:#0093c6;text-decoration:none">导出</button>
    </div>
    <!-- 高级搜索 -->
    <div class="advanced-search">
        <div class="row">
            <!---->
            <div class="col-md-4 col-sm-4 col-btn ">
                <label class="col-md-3 col-sm-4 control-label text-right" for="monitor-btn">所属数据中心</label>
                <div class="col-md-9 col-sm-8 col-input">
                    <select class="form-control input-sm selectpicker input-group-select" id="dataCenter">
                    </select>
                </div>
            </div>
            <!---->
            <div class="col-md-4 col-sm-4 col-btn ">
                <label class="col-md-3 col-sm-4 control-label text-right" for="monitor-btn">所属机房</label>
                <div class="col-md-9 col-sm-8 col-input">
                    <select class="form-control input-sm selectpicker input-group-select" id="comRoom">
                    </select>
                </div>
            </div>
            <!---->
            <div class="col-md-4 col-sm-3 col-btn ">
                <div class="col-md-2 col-sm-4 col-xs-1 col-input text-center" >
                    <button type="button"  data-value="submit"
                            onclick="" class="btn btn-info btn-sm " >确定</button>
                </div>
                <div class="col-md-2 col-sm-4 col-xs-1 col-input text-center" >
                    <button type="button"  data-value="reset" onclick=""
                            class="btn btn-primary btn-sm">重置</button>
                </div>
                <div class="col-md-2 col-sm-4 col-xs-1 col-input text-center" style="padding-right: 0px;">
                    <button type="button"  data-value="submit"
                            onclick="" class="btn btn-success btn-sm" >导出</button>
                </div>

            </div>
        </div>
    </div>
    <!-- 高级搜索 -->
</div>
<div id="comRoom" class="dataTables_wrapper no-footer " style="margin-top: 3px;">
    <table id="comRoom-table" class="table table-hover no-footer dataTable">
        <thead class="the-box dark full">
        <tr>
            <th class="sorting_disabled">机柜编码</th>
            <th class="sorting_disabled">所属机房</th>
            <th class="sorting_disabled">厂商</th>
            <th class="sorting_disabled">描述</th>
            <th class="sorting_disabled" style="text-align: center;">操作</th>
        </tr>
        </thead>
    </table>
</div>

<script>
    $(function () {
    	$(".selectpicker").selectpicker({
				dropuAuto : false
		});
        initDataTable();
        initSelects("data-center/list", "dataCenter",{},MD, "dataCenterId", "name");
        initSelects("computer-room/list", "comRoom",{},MD, "computerRoomId", "name");
        
    });

    //初始化表格
    function initDataTable() {
        $("#comRoom-table").dataTable().fnDestroy();//清除表格
        var temp = $.extend(true, {}, tableOpions, {
            "sAjaxSource": "cabinet/page",
            "fnServerData": retrieveData, //与后台交互获取数据的处理函数
            "select": {
                style: 'multi',
                selector: 'td:first-child'
            },
            "aoColumns": [
                {
                    "mData": "name",
                    "sWidth": "24%",
                    "mRender": function (data, type, row) {
                        if (data) {
                            return data;
                        } else {
                            return '--';
                        }
                    }
                }
                , {
                    "mData": "computerRoomId",
                    "sWidth": "24%",
                    "mRender": function (data, type, row) {
                        if (data) {
                            return data;
                        } else {
                            return '--';
                        }
                    }
                }

                , {
                    "mData": "manufacturerId",
                    "sWidth": "22%",
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
                    "sWidth": "20%",
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
                    "sWidth": "10%",
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
        var str = '<a id="' + row.cabinetId + '" >' +
                '<span ' +
                'class="glyphicon glyphicon-list-alt" title="详情" ' +
                'onclick="cabinetDetail(\'' + row.cabinetId + '\', \'' + row.name + '\')">' +
                '</span>' +
                '</a>&nbsp;&nbsp;'
                + '' +
                '<a id="' + row.id + '" href="javascript:void(0);" title="删除" ">' +
                '<span class="fa fa-trash-o"  onclick="cabinetTrash(\'' + row.cabinetId + '\')">' +
                '</span>' +
                '</a>';
        return str;
    }

    //详情和删除按钮的事件
    function cabinetDetail(id, name) {
        loadMainPage('itam-content','pages/resource/cabinetDetails.jsp?cabinetId='+id);
    }
    function cabinetTrash(model) {
        jConfirm("是否删除型号 " + model + " 的信息？", "操作提示", function (r) {
            if (r) {
                toastr.success("删除类型成功！");
            }
        });
    }
</script>






















































































































