<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<style>
	.btn-width{
		width:100% !important;
	}
</style>
    	<div class="console-title console-title-border">
            <h6>资源管理系统</h6>
            <h6>硬件资产管理</h6>
            <h6>外设设备</h6>
        </div>
   <div class="row-fluid">
		<div class="btn-group">
			<div class="input-group input-group-sm input-group-width">
	               <span class="input-group-addon input-group-span">设备编码</span>
	               <span class="input-group-addon input-group-input">
	                   <input type="text" class="form-control input-search" id="pCode-Search">
	               </span>
	       	</div>
        </div>
	<div class="advanced-search-btn" onclick="spreadSearch()">
		高级搜索
		<span class="fa fa-caret-down" ></span> 
	</div>
		
	<div class="pull-right ">
		<button onclick="loadMainPage('itam-content','pages/asset/peripheralAdd.jsp')" type="reset" class="btn btn-link icon-plus iconlarge" style="color:#0093c6;text-decoration:none">       添加</button>
		<button type="reset" class="btn btn-link icon-share iconlarge" style="color:#0093c6;text-decoration:none" onclick="showExport();">       导出</button>

	</div>
	<div class="advanced-search">
		<div class="row">
			<div class="col-md-4 col-sm-6 col-btn">
				<label class="col-md-3 col-sm-4 control-label text-right">设备编码</label>
				<div class="col-md-9 col-sm-8 col-input">
					<input type="text" id="pAdvanced-Search" maxlength="64" class="form-control"/>
				</div>
			</div>
			<div class="col-md-4 col-sm-6 col-btn">
				<label class="col-md-3 col-sm-4 control-label text-right">设备类型</label>
				<div class="col-md-9 col-sm-8 col-input">
				   <select id="assetType-advancedSearch" class="form-control selectpicker input-group-select">
	               </select>
				</div>
			</div>
			<div class="col-md-4 col-sm-12 text-right col-btn">
				<div class="hidden-md col-sm-6 "></div>
				<div class="col-md-12 col-sm-6 col-input">
					<label class="col-md-3 col-sm-4 hidden-xs"></label>
					<div class="col-md-9 col-sm-8 col-input">
						<div class="col-xs-6 col-input" style="padding-right: 2px">
							<button type="button"  data-value="submit" onclick="initDataTable()" class="btn btn-info btn-sm btn-width" >确定</button>
						</div>
						<div class="col-xs-6 col-input" style="padding-left: 2px;">
							<button type="button"  data-value="reset" onclick="resetData()" class="btn btn-primary btn-sm btn-width">重置</button>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>
        <!-- 外设信息表格开始 -->
	   <div id="management" class="dataTables_wrapper no-footer">
	       <table id="personnel-table" class="table table-hover no-footer dataTable" >
	           <thead class="the-box dark full">
	           <tr>
	                <th class="sorting_disabled">设备编码</th>
	                <th class="sorting_disabled">设备类型</th>
	                <th class="sorting_disabled">型号</th>
                    <th class="sorting_disabled">服务状态</th>
                    <th class="sorting_disabled">系统状态</th>
                      <th class="sorting_disabled">购买时间</th>
                    <th class="sorting_disabled">价格</th>
                    <th class="sorting_disabled">描述</th>
                    <th class="sorting_disabled" style="text-align: center;">操作</th>
	           </tr>
	           </thead>
	       </table>
	   </div>
       <!-- 外设信息表格结束 -->
       <div id="alertDialog"></div>
       <div class="modal fade" id="alarm-monitor">
	    <div class="modal-dialog">
	        <div class="modal-content">
	            <div class="modal-header">
	                <button type="button" class="close" data-dismiss="modal">&times;</button>
	                <h4 class="modal-title" style="font-size: 14px;">导出外设设备</h4>
	            </div>
	            <div class="modal-body">
	            	<input id="resource-alarm-id" style="display: none;">
					<div class="clearfix" style="padding: 15px 0;">
						<label class="col-sm-3 control-label text-right" for="monitor-btn">导出外设设备：</label>
						<div class="col-sm-9 col-btn">
							<select id="search-warning-selects" class="selectpicker btn-width bs-select-hidden">
								<option id="1" >导出全部外设设备</option>
								<option id="2" >导出当前搜索条件下的外设设备</option>
							</select>
						</div>
					</div>
				</div>
	            <div class="modal-footer">
	            	<button type="button" class="btn btn-info" onclick="peripheralExport();">确定</button>
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
		initSelects("asset/type", "assetType-advancedSearch", {category:PERIPHERAL}, MD, "assetTypeId", "name");
	});
   
	function initDataTable(){
		$("#personnel-table").dataTable().fnDestroy();//清除表格
		$("#personnel-table").dataTable($.extend(true,{}, tableOpions, {
        "sAjaxSource": "peripheral/device/page",
        "fnServerData": retrieveData, //与后台交互获取数据的处理函数
        "aoColumns" :  [{
                "mData": "assetCode",
                "mRender": function (data, type, row) {
                    if(data) {
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
                "mData": "modelName",
                "mRender": function (data, type, row) {
                    if(data) {
                       return  data;
                    }else {
                        return '--';
                    }
                }
            },{
                "mData": "serviceStatusName",
                "mRender": function (data, type, row) {
                    if(data) {
                        return data;
                    }else {
                        return '--';
                    }
                },
            },{
                "mData": "systemStatusName",
                "mRender": function (data, type, row) {
                    if(data) {
                        return data;
                    }else {
                        return '--';
                    }
                }
            },{
                "mData": "purchaseDate",
                "mRender": function (data, type, row) {
                    if(data) {
                        return moment(data).format("YYYY-MM-DD");
                    }else {
                        return '--';
                    }
                }
            },{
                "mData": "price",
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
		var assetCode = "";
       var inputStatus = $("#pCode-search").attr("disabled");
       if(inputStatus){
           assetCode = $("#pAdvanced-Search").val();
       }else{
       	   assetCode = $("#pCode-search").val();
       }
       assetCode = encodeURIComponent(assetCode);
        var query = {
            page: conversionPages(start,row),
            rows: row,
            assetTypeId:$("#assetType-advancedSearch").val(),
            assetCode:assetCode
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
        var str =  '<a id="'+ row.Id + '"><span class="glyphicon glyphicon-list-alt" title="详情" onclick="deviceDetail(\'' + row.peripheralDeviceId + '\')"></span></a>&nbsp;&nbsp;'
        +'<a id="' + row.Id + '" href="javascript:void(0);" title="删除" "><span class="fa fa-trash-o"  onclick="deviceTrash(\'' + row.peripheralDeviceId + '\',\'' + row.assetTypeName + '\')"></span></a>';
        return str;
    }
  </script>
  <script>
  	function deviceDetail(id){
  		loadMainPage('itam-content','pages/asset/peripheralDetail.jsp?peripheralDeviceId='+id);
  	}
  	function deviceTrash(id,name){
  		jConfirm("是否删除外设设备 "+name+" ?","操作提示",function(r){
  			if(r){
  				$.ajax({
  					"type":"GET",
  					"url":"peripheral/device/delete",
  					"data":{peripheralDeviceId:id},
  					"dataType":"json",
  					"success":function(resp){
  						if(resp.code == "200"){
  							toastr.success("删除成功！");
  							initDataTable();
  						}else{
  							toastr.error(resp.msg);
  						}
  					}
  				});
  			}
  		});
  	}
  	//搜索重置
  	function resetData(){
  		$("#pAdvanced-Search").val("");
  		$("#assetType-advancedSearch").val("");
  		$(".selectpicker").selectpicker("refresh");
  		initDataTable();
  	}
  	//回车搜索
  	function onSearch(){
	  	$("#pCode-search").focus(function(){
	  		$("#pCode-search").keydown(function(event){
	  			if(event.keyCode == 13){
	  				initDataTable();
	  			}
	  		});
	  	});
  }
  onSearch();//回车搜索
  //导出弹出框显示
  function showExport(){
       $("#alarm-monitor").modal({backdrop:"static"});
   	   $("#alarm-monitor").modal("show");
   }
   //导出
   function peripheralExport(){
   	$.ajax({
   		"type":"GET",
   		"url":"export/resource/peripheral",
   		"data":{"assetTypeId":"18","assetCode":""},
   		"contentType":"application/vnd.ms-excel",
   		"success":function(resp){
   			if(resp.code == "200"){
   				toastr.success("导出成功！");
   			}else{
   				toastr.error("导出有误！");
   			}
   		},
   		"error":function(resp){
   			toastr.error("请求失败！");
   		}
   	});
   }
  </script>