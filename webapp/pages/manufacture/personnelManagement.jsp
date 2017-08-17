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
            <h6>人员管理</h6>
            <h6 id="sub-title" style="display: none;">详情</h6>
        </div>
        <div class="operationList">
            <div class="btn-group" style="width:250px">
			<div class="input-group input-group-sm input-group-width">
                <span class="input-group-addon input-group-span" style="background-color:#f5f6fa">姓名</span>
                <span class="input-group-addon input-group-input" style="width:115px;padding:0;border:none">
                    <input type="text" class="form-control input-search" id="name-model" style="border-top-right-radius:3px;border-bottom-right-radius:3px">
                </span>
        	</div>
        </div>
      
        	<div style="display:inline-block;">
			 	<div class="advanced-search-btn" onclick="spreadSearch()">
					高级搜索
					<span class="fa fa-caret-down" ></span> 
				</div>
        	</div>  
            <div style="float:right" class="pull-right ">
				<button onclick="loadMainPage('itam-content','pages/manufacture/personnelAdd.jsp');" type="reset" class="btn btn-link icon-plus iconlarge" style="color:#0093c6;text-decoration:none">       添加</button>
				<button onclick="showExport();" type="reset" class="btn btn-link icon-share iconlarge" style="color:#0093c6;text-decoration:none">       导出</button>
			</div>
        </div>       
       <div class="advanced-search">
		<div class="row">
			<div class="col-md-4 col-sm-6 col-btn">
				<label class="col-md-3 col-sm-4 control-label text-right" for="monitor-btn">姓名：</label>
				<div class="col-md-9 col-sm-8 col-input">
					<input type="text" id="name-search" maxlength="64" id="perName" class="form-control"/>
				</div>
			</div>
			<div class="col-md-4 col-sm-6 col-btn">
				<label class="col-md-3 col-sm-4 control-label text-right" for="monitor-btn">厂商：</label>
				<div class="col-md-9 col-sm-8 col-input">
					<select id="vendor-name" class="form-control input-sm selectpicker input-group-select"></select>
				</div>
			</div>
			
			<div class="col-md-4 col-sm-6 text-right col-btn">
				<div class="hidden-md col-sm-6 "></div>
				<div class="col-md-12 col-sm-6 col-input">
					<label class="col-md-3 col-sm-4 hidden-xs"></label>
					<div class="col-md-9 col-sm-8 col-input">
						<div class="col-xs-6 col-input" style="padding-right: 2px">
							<button type="button"  data-value="submit" onclick="initDataTable()" class="btn btn-info btn-sm btn-width" >确定</button>
						</div>
						<div class="col-xs-6 col-input" style="padding-left: 2px;">
							<button type="button"  data-value="reset" onclick="resetSearchInput()" class="btn btn-primary btn-sm btn-width">重置</button>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	
	</div>
        <!-- 人员信息表格开始 -->
	   <div id="management" class="dataTables_wrapper no-footer">
	       <table id="personnel-table" class="table table-hover no-footer dataTable" >
	           <thead class="the-box dark full">
	           <tr>
	                <th class="sorting_disabled">姓名</th>
                    <th class="sorting_disabled">联系电话</th>
                    <th class="sorting_disabled">邮箱</th>
                    <th class="sorting_disabled">厂商</th>
                    <th class="sorting_disabled">分类</th>
                    <th class="sorting_disabled">描述</th>
                    <th class="sorting_disabled" style="text-align: center;">操作</th>
	           </tr>
	           </thead>
	       </table>
	   </div>
       <!-- 人员信息表格结束 -->
       <div id="alertDialog"></div>
          <!-- 导出 -->
       <div class="modal fade" id="alarm-monitor">
	    <div class="modal-dialog">
	        <div class="modal-content">
	            <div class="modal-header">
	                <button type="button" class="close" data-dismiss="modal">&times;</button>
	                <h4 class="modal-title" style="font-size: 14px;">导出人员</h4>
	            </div>
	            <div class="modal-body">
	            	<input id="resource-alarm-id" style="display: none;">
					<div class="clearfix" style="padding: 15px 0;">
						<label class="col-sm-3 control-label text-right" for="monitor-btn">导出人员：</label>
						<div class="col-sm-9 col-btn">
							<select id="search-warning-selects" class="selectpicker btn-width bs-select-hidden">
								<option id="1" >导出全部人员</option>
								<option id="2" >导出当前搜索条件下的人员</option>
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
		//$(".selectpicker").selectpicker();
		initSelects("manufacturer/list", "vendor-name",{},MD, "manufacturerId", "name");
	});
   	$(".selectpicker").selectpicker({
		dropuAuto : false
	});
	function initDataTable(){
		$("#personnel-table").dataTable().fnDestroy();//清除表格
		$("#personnel-table").dataTable($.extend(true,{}, tableOpions, {
        "sAjaxSource": "contact/page",
        "fnServerData": retrieveData, //与后台交互获取数据的处理函数
        "select": {
            style: 'multi',
            selector: 'td:first-child'
        },
        "aoColumns" :  [
       		 {
                "mData": "name",
                "sWidth":"10%",
                "mRender": function (data, type, row) {
                    if(data) {
                       return  data;
                    }else {
                        return '--';
                    }
                }
            },{
                "mData": "phone",
                "sWidth":"15%",
                "mRender": function (data, type, row) {
                    if(data) {
                       return  data;
                    }else {
                        return '--';
                    }
                }
            }, {
                "mData": "email",
                "sWidth":"15%",
                "mRender": function (data, type, row) {
                    if(data) {
                        return data;
                    }else {
                        return '--';
                    }
                },
            },{
                "mData": "manufacturerName",
                "mRender": function (data, type, row) {
                    if(data) {
                       return data;
                    }else {
                        return '--';
                    }
                },
            },{
                "mData": "typeValue",
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
                    	if(data.length > 10){
                    		return data.substring(0,10)+"...";
                    	}
                        return data;
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
       var personName = "";
       var inputStatus = $("#name-model").attr("disabled");
       if(inputStatus){
           personName = encodeURIComponent($("#name-search").val());
       }else{
       	   personName = encodeURIComponent($("#name-model").val());
       }
        var query = {
            page: conversionPages(start,row),
            rows: row,
            name: personName,
            manufacturerId:$("#vendor-name").val(),
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
        var str =  '<a id="'+ row.templateId + '"><span class="glyphicon glyphicon-list-alt" title="详情" onclick="personnelDetail(\'' + row.contactId + '\')"></span></a>&nbsp;&nbsp;'
        + 	'<a id="' + row.manufacturerId + '" href="javascript:void(0);" title="删除" "><span class="fa fa-trash-o"  onclick="personnelTrash(\'' + row.contactId + '\',\'' + row.name + '\')"></span></a>';
        return str;
    }
  </script>
  <script>
  	function personnelDetail(id){
  		loadMainPage('itam-content','pages/manufacture/personnelDetail.jsp?contactId='+id);
  	}
  	//删除
  	function personnelTrash(id,name){
  		jConfirm("确定要删除人员 "+name+" 的信息吗？","操作提示",function(r){
  			if(r){
  				$.ajax({
  					"type":"DELETE",
  					"url":"contact/delete?contactId="+id,
  					"data":{},
  					"dataType":"json",
  					"success":function(resp){
  						if(resp.code == 200){
  							toastr.success("删除成功！");
  							initDataTable();
  						}else{
  							toastr.error("此人员有与之关联的设备");
  						}
  					},
  					"error":function(){
  						toastr.error("请求失败！");
  					}
  				});
  			}
  		});
  	}
  	//搜索重置
  	function resetSearchInput(){
  		$(".selectpicker").val("");
  		$(".selectpicker").selectpicker("refresh");
        $("#name-search").val("");
        initDataTable();
  	}
  	//回车搜索
  	function onSearch(){
	  	$("#name-model").focus(function(){
	  		$("#name-model").keydown(function(event){
	  			if(event.keyCode == 13){
	  				initDataTable();
	  			}
	  		});
	  	});
  }
  onSearch();
  //显示导出弹框
  	function showExport(){
       $("#alarm-monitor").modal({backdrop:"static"});
   	   $("#alarm-monitor").modal("show");
   }
  </script>