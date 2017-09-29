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
            <h6>型号管理</h6>
            <h6 id="sub-title" style="display: none;">详情</h6>
        </div>
        <div class="operationList">
            <div class="btn-group" style="width:250px">
			<div class="input-group input-group-sm input-group-width">
                <span class="input-group-addon input-group-span" style="background-color:#f5f6fa">型号名称</span>
                <span class="input-group-addon input-group-input" id="setName" style="width:115px;padding:0;border:none">
                    <input type="text" class="form-control input-search nameSearch" id="model-search" style="border-top-right-radius:3px;border-bottom-right-radius:3px">
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
			<button onclick="loadMainPage('itam-content','pages/manufacture/modelAdd.jsp')" type="reset" class="btn btn-link icon-plus iconlarge" style="color:#0093c6;text-decoration:none">       添加</button>
			<button onclick="showExport();" type="reset" class="btn btn-link icon-share iconlarge" style="color:#0093c6;text-decoration:none">       导出</button>
		</div>  
		<div class="advanced-search">
 		<div class="row">
 			<div class="col-md-4 col-sm-6 col-btn">
 				<label class="col-md-3 col-sm-4 control-label text-right" for="monitor-btn">资产分类：</label>
 				<div class="col-md-9 col-sm-8 col-input">
 					<select id="modelType-search" class="form-control input-sm selectpicker input-group-select"></select>
 				</div>
 			</div>
 			<div class="col-md-4 col-sm-6 col-btn">
 				<label class="col-md-3 col-sm-4 control-label text-right" for="monitor-btn">型号名称：</label>
 				<div class="col-md-9 col-sm-8 col-input">
 					<input type="text" id="name-search" maxlength="64" class="form-control input-add"/>
 				</div>
 			</div>
 			
 			<div class="col-md-4 col-sm-6 col-btn">
 				<label class="col-md-3 col-sm-4 control-label text-right" for="monitor-btn">厂商：</label>
 				<div class="col-md-9 col-sm-8 col-input">
 					<select id="vendor-search" class="form-control input-sm selectpicker input-group-select"></select>
 				</div>
 			</div>
 			<div class="col-md-12 col-sm-6 text-right col-btn">
 				<div class="col-md-8 hidden-sm "></div>
 				<div class="col-md-4 col-sm-12 col-input">
 					<label class="col-md-3 col-sm-4 hidden-xs"></label>
 					<div class="col-md-9 col-sm-8 col-input">
 						<div class="col-xs-6 col-input" style="padding-right: 2px">
 							<button type="button"  data-value="submit" onclick="initDataTable();" class="btn btn-info btn-sm btn-width" >确定</button>
 						</div>
 						<div class="col-xs-6 col-input" style="padding-left: 2px;">
 							<button type="button"  data-value="reset" onclick="resetSearchInput();" class="btn btn-primary btn-sm btn-width">重置</button>
 						</div>
 					</div>
 				</div>
 			</div>
 		</div>   
			</div>
	</div>
        <!-- 型号信息表格开始 -->
	   <div id="management" class="dataTables_wrapper no-footer">
	       <table id="model-table" class="table table-hover no-footer dataTable" >
	           <thead class="the-box dark full">
	           <tr>
	           		<th class="sorting_disabled">型号名称</th>
	                <th class="sorting_disabled">资产分类</th>
	                <th class="sorting_disabled">资产类型</th>
                    <th class="sorting_disabled">厂商</th>
                    <th class="sorting_disabled">U位</th>
                    <th class="sorting_disabled">端口数</th>
                     <th class="sorting_disabled">描述</th>
                    <th class="sorting_disabled" style="text-align: center;">操作</th>
	           </tr>
	           </thead>
	       </table>
	   </div>
       <!-- 型号信息表格结束 -->
       <div id="alertDialog"></div>
        <!-- 导出 -->
       <div class="modal fade" id="alarm-monitor">
	    <div class="modal-dialog">
	        <div class="modal-content">
	            <div class="modal-header">
	                <button type="button" class="close" data-dismiss="modal">&times;</button>
	                <h4 class="modal-title" style="font-size: 14px;">导出型号</h4>
	            </div>
	            <div class="modal-body">
	            	<input id="resource-alarm-id" style="display: none;">
					<div class="clearfix" style="padding: 15px 0;">
						<label class="col-sm-3 control-label text-right" for="monitor-btn">导出型号：</label>
						<div class="col-sm-9 col-btn">
							<select id="search-warning-selects" class="selectpicker btn-width bs-select-hidden">
								<option id="1" >导出全部型号</option>
								<option id="2" >导出当前搜索条件下的型号</option>
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
    </div>
  <script>
  $(function(){
		initDataTable();
			//初始化型号类型下拉菜单
		  function initModel(id,dataType){
			$("#setName #"+id).empty();
			if(dataType == MD){
				$("#"+id).append("<option value=''>--请选择--</option>");
			}
			$.getJSON("model/list",{},function(r){
		   		if(r.code == 200) {
		   			var list = r.result.list;
		   			$.each(list,function(index,item){
		   				$("#"+id).append("<option value='"+item.name+"'>"+item.name+"</option>");
		   			});
		   		}
		   		$("#"+id).selectpicker("refresh");
		   });
		   }
		  $(".selectpicker").selectpicker({
				dropuAuto : false
			});
		initSelects('mdconfig/resource/type', "modelType-search", {}, MD,"key", "value");
		initSelects("manufacturer/list", "vendor-search",{},MD, "manufacturerId", "name");
	});
	
	function initDataTable(){
		$("#model-table").dataTable().fnDestroy();//清除表格
		$("#model-table").dataTable($.extend(true,{}, tableOpions, {
        "sAjaxSource": "model/page",
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
                        return data;
                    }else {
                        return '--';
                    }
                },
            },{
                "mData": "category",
                "mRender": function (data, type, row) {
                    if(data) {
                    	switch(data){
                    		case "3":return "机柜设备";
                    			break;
                    		case "4":return "计算设备";
                    			break;
                    		case "5":return "存储设备";
                    			break;
                    		case  "6":return "网络设备";
                    			break;
                    		case "7":return "安全设备";
                    			break;
                    		case "8":return "外设设备";
                    			break;
                    		default:return "资源类型有误";
                    			break;
                    	}
                       return  data;
                    }else {
                        return '--';
                    }
                }
            },{
                "mData": "assetTypeName",
                "mRender": function (data, type, row) {
                    if(data) {
                       return  data;
                    }else {
                        return '--';
                    }
                }
            },{
                "mData": "manufacturerName",
                "mRender": function (data, type, row) {
                    if(data) {
                       return data;
                    }else {
                        return '--';
                    }
                }
            },{
                "mData": "units",
                "mRender": function (data, type, row) {
                    if(data) {
                        return data;
                    }else {
                        return '--';
                    }
                },
            },{
                "mData": "portNumber",
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
        var modelName = "";
       var inputStatus = $("#model-search").attr("disabled");
       if(inputStatus){
           modelName = $("#name-search").val();
       }else{
       	   modelName = $("#model-search").val();
       }
		var query = {
            	page: conversionPages(start,row),
	            rows: row,
	            name:modelName,
	            category:$("#modelType-search").val(),
	            manufacturerId:$("#vendor-search").val()
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
        var str =  '<a id="'+ row.templateId + '"><span class="glyphicon glyphicon-list-alt" title="详情" onclick="modelDetail(\'' + row.modelId + '\')"></span></a>&nbsp;&nbsp;'
        +'<a id="' + row.templateId + '" href="javascript:void(0);" title="删除" "><span class="fa fa-trash-o"  onclick="modelTrash(\'' + row.modelId + '\',\'' + row.name + '\')"></span></a>';
        return str;
    }
  </script>
  <script>
  	function modelDetail(modelId,category){
  		loadMainPage('itam-content','pages/manufacture/modelDetail.jsp?modelId='+modelId);
  	}
  	function modelTrash(modelId,name){
  		jConfirm("是否删除型号 "+name+" 的信息？","操作提示",function(r){
  			if(r){
  				$.ajax({
  					"type":"DELETE",
  					"url":"model/delete?modelId="+modelId,
  					"data":{},
  					"dataType":"json",
  					"success":function(resp){
  						if(resp.code == "200"){
  							toastr.success("删除成功！");
  							initDataTable();
  							
  						}else{
  							toastr.error("该型号与其他设备关联不能删除！");
  						}
  					},
  					"error":function(resp){
  						toastr.error("请求失败！");
  					}
  				});
  			}
  		});
  	}
  	//重置搜索条件
  	function resetSearchInput(){
  		$("#name-search").val("");
  		$(".selectpicker").val("");
  		$(".selectpicker").selectpicker("refresh");
  		initDataTable();
  	}
   //初始化资产类型下拉菜单
function modelType(){
	$.ajax({
		"type":"GET",
		"url":"mdconfig/resource/type",
		"data":{},
		"dataType":"json",
		"success":function(resp){
			if(resp.code == "200"){
			  var arr = resp.result.list;
			  for(var i=0;i<arr.length;i++){
			  	var key = arr[i].key;
			  	var value = arr[i].value;
			  	if(arr[i].key != 1 && arr[i].key != 2){
			  		var str = "<option value="+key+">"+value+"</option>";
			  			$("#modelType-search").append(str);
			  	}
			  	$(".selectpicker").selectpicker("refresh");
			  }
			}else{
				toastr.error(resp.msg);
			}
		},
		"error":function(resp){
			toastr.error("请求失败！");
		}
	});
}
  //型号名称搜索时
  function onNameSearch(){
  	$("#model-search").focus(function(){
  		$("#model-search").keydown(function(e){
  			if(event.keyCode == 13){
  				initDataTable();
  			}
  		});
  	});
  }
  onNameSearch();
  //显示导出弹框
  	function showExport(){
      $("#alarm-monitor").modal({backdrop:"static"});
   	  $("#alarm-monitor").modal("show");
   }
  </script>