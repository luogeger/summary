<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>

    <div class="console-title console-title-border">
        <h6>资产管理系统</h6>
        <h6>资源管理</h6>
        <h6>数据中心</h6>
    </div>
    <div class="operationList">
        <div class="btn-group" style="width:250px">
            <div class="input-group input-group-sm input-group-width">
                <span class="input-group-addon input-group-span" style="background-color:#f5f6fa">数据中心名称</span>
                <span class="input-group-addon input-group-input" style="width:115px;padding:0;border:none">
                    <input type="text" class="form-control input-search" id="name-search" style="border-top-right-radius:3px;border-bottom-right-radius:3px">
                </span>
            </div>
        </div>

        <div style="display:inline-block;vertical-align:top">
            <button type="button" class="btn btn-info btn-sm searchBtn" onclick="initDataTable();" data-value="submit">搜索</button>
            <button type="button" class="btn btn-default btn-sm searchBtn" onclick="resetSearch();"   data-value="reset">重置</button>
        </div>
        <div style="float:right" class="pull-right ">
            <button onclick="loadMainPage('itam-content','pages/resource/dataCenterAdd.jsp');" type="reset"
                    class="btn btn-link icon-plus iconlarge" style="color:#0093c6;text-decoration:none"> 添加
            </button>
            <button onclick="" type="reset" class="btn btn-link icon-share iconlarge"
                    style="color:#0093c6;text-decoration:none"> 导出
            </button>
        </div>
    </div>

    <!-- 数据表格开始 -->
    <div id="dataCenter" class="dataTables_wrapper no-footer">
        <table id="model-table" class="table table-hover no-footer dataTable">
            <thead class="the-box dark full">
            <tr>
                <th class="sorting_disabled">名称</th>
                <th class="sorting_disabled">地址</th>
                <th class="sorting_disabled">描述</th>
                <th class="sorting_disabled" style="text-align: center;">操作</th>
            </tr>
            </thead>
        </table>
    </div>



<script>
    $(function () {
        initDataTable();
    });

    //初始化表格
    function initDataTable() {
        $("#model-table").dataTable().fnDestroy();//清除表格
        var temp = $.extend(true, {}, tableOpions, {
            "sAjaxSource": "data-center/page",
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
        $("#model-table").dataTable(temp);
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
        var str =  '<a id="'+ row.dataCenterId + '"><span class="glyphicon glyphicon-list-alt" title="详情" onclick="dataDetail(\'' + row.dataCenterId + '\')"></span></a>&nbsp;&nbsp;'
         + 	'<a id="' + row.dataCenterId + '" href="javascript:void(0);" title="删除" "><span class="fa fa-trash-o"  onclick="dataTrash(\'' + row.dataCenterId + '\',\'' + row.createTime + '\')"></span></a>';
        return str;
    }
    

    //详情和删除按钮的事件
  	function dataDetail(id){
  		loadMainPage('itam-content','pages/resource/dataCenterDetails.jsp?dataCenterId='+id);
  	}
    function dataTrash(id,name) {
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

</script>
