<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<!-- navigate -->
    <div class="console-title console-title-border">
        <h6>资产管理系统</h6>
        <h6>资源管理</h6>
        <h6>标签管理</h6>
        <h6 id="sub-title" style="display: none;">详情</h6>
        <a class="pull-right" type="button" style="display: none;" onclick="loadMainPage('itam-content','pages/resource/labelList.jsp');">
            <span class="icon-reply"></span>
            返回
        </a>
    </div>
<!-- operation -->
    <div class="operationList">
        <div class="btn-group" style="width:250px">
            <div class="input-group input-group-sm input-group-width">
                <span class="input-group-addon input-group-span" style="background-color:#f5f6fa">标签名称</span>
                <span class="input-group-addon input-group-input" style="width:115px;padding:0;border:none">
                    <input type="text" class="form-control input-search" id="name-search"
                           style="border-top-right-radius:3px;border-bottom-right-radius:3px">
                </span>
            </div>
        </div>

        <div style="display:inline-block;vertical-align:top">
            <button type="button" class="btn btn-info btn-sm searchBtn" onclick="doQuery()" data-value="submit">搜索</button>
            <button type="button" class="btn btn-default btn-sm searchBtn" onclick="resetSearchInput();"   data-value="reset">重置</button>
        </div>
        <div style="float:right" class="pull-right ">
            <button onclick="loadMainPage('itam-content','pages/resource/labelAdd.jsp');" type="reset"
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
                <th class="sorting_disabled">标签名称</th>
                <th class="sorting_disabled">标签概要</th>
                <th class="sorting_disabled" style="text-align: center;">操作</th>
            </tr>
            </thead>
        </table>
    </div>
    <!-- 数据表格结束 -->


<script>
    $(function () {
        initDataTable();
    });

    //初始化表格
    function initDataTable() {
        $("#model-table").dataTable().fnDestroy();//清除表格
        var temp = $.extend(true, {}, tableOpions, {
            "sAjaxSource": "label/page",
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
                    "mData": "remark",
                    "mRender": function (data, type, row) {
                        if (data) {
                            return data;
                        } else {
                            return '--';
                        }
                    }
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


     //操作列渲染
    function operateRender(data, type, row) {
        var str =  '<a id="'+ row.labelId + '"><span class="fa fa-edit" title="编辑" onclick="labelDetail(\'' + row.labelId + '\')"></span></a>&nbsp;&nbsp;'
         + 	'<a id="' + row.labelId + '" href="javascript:void(0);" title="删除" "><span class="fa fa-trash-o"  onclick="labelTrash(\'' + row.labelId + '\',\'' + row.name + '\')"></span></a>';
        return str;
    } //操作列渲染
    

    //详情和删除按钮的事件
    function labelDetail(id){
  		loadMainPage('itam-content','pages/resource/labelEdit.jsp?labelId='+id);
  	}
  	function labelTrash(id,name){
  		jConfirm("确定要删除 "+name+" 的信息吗？","操作提示",function(r){
  			if(r){
  				$.ajax({
  					"type":"DELETE",
  					"url":"label/delete?labelId="+id,
  					"data":{},
  					"dataType":"json",
  					"success":function(resp){
  						if(resp.code == "200"){
  							toastr.success("删除成功！");
  							initDataTable();		
  						}else{
  							toastr.error("删除失败");
  						}
  					},
  					"error":function(resp){
  						toastr.error(resp.msg);
  					}
  				});
  			}
  		});
  	}
</script>

