<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<style>
	.btn-width{
		width:100% !important;
	}
</style>
    <div class="left-menu">
    	<div class="console-title console-title-border">
            <h6>资源管理系统</h6>
            <h6>供应商管理</h6>
            <h6>厂商管理</h6>
            <h6 id="sub-title" style="display: none;">详情</h6>
        </div>
        <div class="operationList">
            <div class="btn-group" style="width:250px">
			<div class="input-group input-group-sm input-group-width">
                <span class="input-group-addon input-group-span" style="background-color:#f5f6fa">厂商名称</span>
                <span class="input-group-addon input-group-input" style="width:115px;padding:0;border:none">
                    <input type="text" class="form-control input-search" id="name-search" style="border-top-right-radius:3px;border-bottom-right-radius:3px">
                </span>
        	</div>
        </div>
            	<div style="display:inline-block;vertical-align:top">
            		<button id="search-btn" class="btn btn-info btn-sm" onclick="initDataTable();">搜索</button>
                	<button class="btn btn-default btn-sm" onclick="resetSearch();" type="reset">重置</button>
            	</div>  
            
            
            <div style="float:right" class="pull-right ">
				<button onclick="loadMainPage('itam-content','pages/manufacture/vendorAdd.jsp');" type="reset" class="btn btn-link icon-plus iconlarge" style="color:#0093c6;text-decoration:none">       添加</button>
				<button onclick="showExport();" type="reset" class="btn btn-link icon-share iconlarge" style="color:#0093c6;text-decoration:none">       导出</button>
			</div>
            </div>

        </div>
        <!-- 厂商信息表格开始 -->
	   <div id="management" class="dataTables_wrapper no-footer" style="margin-top:0">
	       <table id="vendor-table" class="table table-hover no-footer dataTable" >
	           <thead class="the-box dark full">
	           <tr>
	                <th class="sorting_disabled">厂商名称</th>
                    <th class="sorting_disabled">所属地区</th>
                    <th class="sorting_disabled">联系电话</th>
                    <th class="sorting_disabled">厂商主页</th>
                    <th class="sorting_disabled">联系地址</th>
                     <th class="sorting_disabled">描述</th>
                    <th class="sorting_disabled" style="text-align: center;">操作</th>
	           </tr>
	           </thead>
	       </table>
	   </div>
       <!-- 厂商信息表格结束 -->
       <div id="alertDialog"></div>
       <!-- 导出 -->
       <div class="modal fade" id="alarm-monitor">
	    <div class="modal-dialog">
	        <div class="modal-content">
	            <div class="modal-header">
	                <button type="button" class="close" data-dismiss="modal">&times;</button>
	                <h4 class="modal-title" style="font-size: 14px;">导出厂商</h4>
	            </div>
	            <div class="modal-body">
	            	<input id="resource-alarm-id" style="display: none;">
					<div class="clearfix" style="padding: 15px 0;">
						<label class="col-sm-3 control-label text-right" for="monitor-btn">导出厂商：</label>
						<div class="col-sm-9 col-btn">
							<select id="search-warning-selects" class="selectpicker btn-width bs-select-hidden">
								<option id="1" >导出全部厂商</option>
								<option id="2" >导出当前搜索条件下的厂商</option>
							</select>
						</div>
					</div>
				</div>
	            <div class="modal-footer">
	            	<button type="button" class="btn btn-info" onclick="export();">确定</button>
	                <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
	            </div>
	        </div><!-- /.modal-content -->
	    </div><!-- /.modal-dialog -->
	</div>
  <script>
  $(function(){
		initDataTable();
		$(".selectpicker").selectpicker({
			dropuAuto : false
		});
	});
	function initDataTable(){
		$("#vendor-table").dataTable().fnDestroy();//清除表格
		$("#vendor-table").dataTable($.extend(true,{}, tableOpions, {
        "sAjaxSource": "manufacturer/page",
        "fnServerData": retrieveData, //与后台交互获取数据的处理函数
        "select": {
            style: 'multi',
            selector: 'td:first-child'
        },
        "aoColumns" :  [
       		 {
                "mData": "name",
                "mRender": function (data, type, row) {
                    if(data) {
                       return  data;
                    }else {
                        return '--';
                    }
                }
            },{
          		"mData": "countryValue",
                "mRender": function (data, type, row) {
	                    if(data) {
	                       return  data+" - "+row.cityValue;
	                    }else {
	                        return '--';
	                    }
                	}
          		}, {
                "mData": "phone",
                "mRender": function (data, type, row) {
                    if(data) {
                        return data;
                    }else {
                        return '--';
                    }
                },
            },{
                "mData": "website",
                "mRender": function (data, type, row) {
                    if(data) {
                        return data;
                    }else {
                        return '--';
                    }
                },
            },{
                "mData": "address",
                "mRender": function (data, type, row) {
                    if(data) {
                        return data;
                    }else {
                        return '--';
                    }
                },
            },{
                "mData": "remark",
                "mRender": function (data, type, row) {
                    if(data) {
                    	if( data.length > 10){
                    		return data.substring(0,10)+"...";
                    	}else{
                    		return data;
                    	}
                       
                    }else {
                        return '--';
                    }
                },
            }, {
                "mData": "id",
                "mRender": operateRender,
                'fnCreatedCell': function (nTd) {
                    $(nTd).css('text-align', 'center');
                }
            }
        ],
    }));
	}
     
    // 异步获取table数据
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
            page: conversionPages(start,row),
            rows: row,
            name:encodeURIComponent($("#name-search").val())
        };
        $.getJSON(sSource,query,function (rm) {
            if(rm.code == 200) {
                var data = rm.result.pageInfo;
                data.iTotalRecords = rm.result.pageInfo.total;
                data.iTotalDisplayRecords = rm.result.pageInfo.total;
                fnCallback(data);
            } else {
                toastr.error(rm.msg);
            }
        });
    }
     //操作列渲染
    function operateRender(data, type, row) {
        var str =  '<a id="'+ row.manufacturerId + '"><span class="glyphicon glyphicon-list-alt" title="详情" onclick="vendorDetail(\'' + row.manufacturerId + '\')"></span></a>&nbsp;&nbsp;'
         + 	'<a id="' + row.manufacturerId + '" href="javascript:void(0);" title="删除" "><span class="fa fa-trash-o"  onclick="vendorTrash(\'' + row.manufacturerId + '\',\'' + row.name + '\')"></span></a>';
        return str;
    }
  </script>
  <script>
  	function vendorDetail(id){
  		loadMainPage('itam-content','pages/manufacture/vendorDetail.jsp?manufacturerId='+id);
  	}
  	function vendorTrash(id,name){
  		jConfirm("确定要删除 "+name+" 的信息吗？","操作提示",function(r){
  			if(r){
  				$.ajax({
  					"type":"DELETE",
  					"url":"manufacturer/delete?manufacturerId="+id,
  					"data":{},
  					"dataType":"json",
  					"success":function(resp){
  						if(resp.code == "200"){
  							toastr.success("删除成功！");
  							initDataTable();		
  						}else{
  							toastr.error("删除失败，有与厂商相关的网络设备！");
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
  	//显示导出弹框
  	 function showExport(){
       $("#alarm-monitor").modal({backdrop:"static"});
   	   $("#alarm-monitor").modal("show");
   }
  </script>