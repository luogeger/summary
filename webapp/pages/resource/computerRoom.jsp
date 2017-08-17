<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>

    <style>
        .pt10{
            text-align: center;
            padding: 0 10px;
        }
    </style>
<!-- navigate -->
	<div class="console-title console-title-border">
	    <h6>机房管理</h6>
	</div>
<!-- operation -->
<div class="row-fluid">

    <div class="btn-group" style="width:250px">
        <div class="input-group input-group-sm input-group-width">
            <span class="input-group-addon input-group-span" style="background-color:#f5f6fa">数据中心名称</span>
            <span class="input-group-addon input-group-input" style="width:115px;padding:0;border:none">
                <input type="text" class="form-control input-search" id="name-search" style="border-top-right-radius:3px;border-bottom-right-radius:3px">
            </span>
        </div>
    </div>
       
	    <div class="advanced-search-btn" onclick="spreadSearch()" style="cursor: pointer;">
       		高级搜索
	        <span class="fa fa-caret-down" ></span>
	    </div>

    <div class="pull-right ">
	        <button type="reset" class="btn btn-link icon-plus iconlarge" style="color:#0093c6;text-decoration:none"
	        	onclick="loadMainPage('itam-content','pages/resource/computerRoomAdd.jsp');">
	       		 添加
	        </button>
	        <button type="reset" class="btn btn-link icon-share iconlarge" style="color:#0093c6;text-decoration:none">
	        	导出
	        </button>
	    </div>
	<!-- 高级搜索 -->
    <div class="advanced-search">
        <div class="row">
        	<!-- 机柜编码 -->
            <div class="col-md-4 col-sm-4 col-btn ">
                <label class="col-md-3 col-sm-4 control-label text-right" for="monitor-btn">机柜编码</label>
                <div class="col-md-9 col-sm-8 col-input">
                    <input type="text" id="name_advancedSearch" maxlength="64" class="form-control"/>
                </div>
            </div>
            <!-- 所属机房 -->
            <div class="col-md-4 col-sm-4 col-btn ">
                <label class="col-md-3 col-sm-4 control-label text-right" for="monitor-btn">所属机房</label>
                <div class="col-md-9 col-sm-8 col-input">
                    <select class="form-control input-sm selectpicker input-group-select" id="belongComRoom">
                    </select>
                </div>
            </div>
            <!-- 确定 重置 导出 -->
            <div class="col-md-4 col-sm-4 col-btn ">
                <div class="col-md-4 col-sm-4 col-xs-4 col-input text-center pt10" >
                    <button type="button"  data-value="submit" class="btn btn-info btn-block " >确定</button>
                </div>
                <div class="col-md-4 col-sm-4 col-xs-4 col-input text-center pt10" >
                    <button type="button"  data-value="reset" class="btn btn-primary btn-block ">重置</button>
                </div>
                <div class="col-md-4 col-sm-4 col-xs-4 col-input text-center pt10" style="padding-right: 0px;">
                    <button type="button"  data-value="submit" class="btn btn-success btn-block" >导出</button>
                </div>
            </div>
        </div>
    </div>
</div>

	<div id="comRoom" class="dataTables_wrapper no-footer " style="margin-top: 3px;">
	    <table id="comRoom-table" class="table table-hover no-footer dataTable">
	        <thead class="the-box dark full">
	        <tr>
	            <th class="sorting_disabled">名称</th>
	            <th class="sorting_disabled">数据中心</th>
	            <th class="sorting_disabled">描述</th>
	            <th class="sorting_disabled" style="text-align: center;">操作</th>
	        </tr>
	        </thead>
	    </table>
	</div>


<script>
    $(function () {
    	initDataTable();
    	initSelects("computer-romm/type", "belongComRoom",{},MD, "computerRoomId", "name");
    	$(".selectpicker").selectpicker({
				dropuAuto : false
		});
        
    });

    //初始化表格
    function initDataTable() {
        $("#comRoom-table").dataTable().fnDestroy();//清除表格
        var temp = $.extend(true, {}, tableOpions, {
            "sAjaxSource": "computer-room/page",
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
                    "mData": "dataCenterId",
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
        var str =  '<a id="'+ row.computerRoomId + '"><span class="glyphicon glyphicon-list-alt" title="详情" onclick="roomDetail(\'' + row.computerRoomId + '\')"></span></a>&nbsp;&nbsp;'
         + 	'<a id="' + row.computerRoomId + '" href="javascript:void(0);" title="删除" "><span class="fa fa-trash-o"  onclick="roomTrash(\'' + row.computerRoomId + '\',\'' + row.createTime + '\')"></span></a>';
        return str;
    }
    

    //详情和删除按钮的事件
  	function roomDetail(id){
  		loadMainPage('itam-content','pages/resource/computerRoomDetails.jsp?computerRoomId='+id);
  	}
    function roomTrash(id,name) {
        jConfirm("是否删除型号 " + name + " 的信息？", "操作提示", function (r) {
            if(r){
  				$.ajax({
  					"type":"DELETE",
  					"url":"computer-room/delete?computerRoomId="+id,
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
    
    
</script>


