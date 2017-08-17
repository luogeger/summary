<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<style>
.btn-width{
width:100% !important;
}
</style>
<div class="console-title console-title-border">
	<h6>资产管理系统</h6>
	<h6>硬件资产管理</h6>
	<h6>存储设备管理</h6>
</div>
<div class="row-fluid">
	<div class="btn-group">
		<div class="input-group input-group-sm input-group-width">
               <span class="input-group-addon input-group-span">设备编码</span>
               <span class="input-group-addon input-group-input">
                   <input type="text" class="form-control input-search" id="storageCode-search">
               </span>
       	</div>
       </div>
	<div class="advanced-search-btn" onclick="spreadSearch()">
		高级搜索
		<span class="fa fa-caret-down" ></span> 
	</div>
		
	<div class="pull-right ">
		<button onclick="showAddModel()" type="reset" class="btn btn-link icon-plus iconlarge" style="color:#0093c6;text-decoration:none">       添加</button>
		<button onclick="showExport()" type="reset" class="btn btn-link icon-share iconlarge" style="color:#0093c6;text-decoration:none">       导出</button>

	</div>
	<div class="advanced-search">
		<div class="row">
			<div class="col-md-4 col-sm-6 col-btn">
				<label class="col-md-3 col-sm-4 control-label text-right" for="monitor-btn">设备编码</label>
				<div class="col-md-9 col-sm-8 col-input">
					<input type="text" id="storageCode-advancedSearch" maxlength="64" class="form-control"/>
				</div>
			</div>
			<div class="col-md-4 col-sm-6 col-btn">
				<label class="col-md-3 col-sm-4 control-label text-right" for="monitor-btn">设备类型</label>
				<div class="col-md-9 col-sm-8 col-input">
					<select id="assetType-advancedSearch" class="form-control input-sm selectpicker input-group-select">
	               </select>
				</div>
			</div>
			
            <div class="col-md-4 col-sm-12 text-right col-btn">
				<div class="hidden-md col-sm-6 "></div>
				<div class="col-md-12 col-sm-6 col-input">
					<label class="col-md-3 col-sm-4 hidden-xs"></label>
					<div class="col-md-9 col-sm-8 col-input">
						<div class="col-xs-6 col-input" style="padding-right: 2px">
							<button type="button"  data-value="submit" onclick="searchResource()" class="btn btn-info btn-sm btn-width" >确定</button>
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
<div id="storage-table_wrapper1" class="dataTables_wrapper no-footer clearfix" style="margin-top: 3px;">
	<table id="storage-table" class="table table-hover no-footer dataTable">
		<thead class="the-box dark full">
			<tr>
				<th class="sorting_disabled">设备编码</th>
				<th class="sorting_disabled">设备类型</th>
				<th class="sorting_disabled">型号</th>
				<th class="sorting_disabled">存储大小</th>
				<th class="sorting_disabled">服务状态</th>
				<th class="sorting_disabled">描述</th>
				<th class="sorting_disabled" style="text-align: center;">操作</th>
			</tr>
		</thead>
	</table>
</div>
	<div class="modal fade" id="alarm-monitor">
	    <div class="modal-dialog">
	        <div class="modal-content">
	            <div class="modal-header">
	                <button type="button" class="close" data-dismiss="modal">&times;</button>
	                <h4 class="modal-title" style="font-size: 14px;">导出存储设备</h4>
	            </div>
	            <div class="modal-body">
	            	<input id="resource-alarm-id" style="display: none;">
					<div class="clearfix" style="padding: 15px 0;">
						<label class="col-sm-3 control-label text-right" for="monitor-btn">导出存储设备：</label>
						<div class="col-sm-9 col-btn">
							<select id="search-warning-selects" class="selectpicker btn-width bs-select-hidden">
								<option id="1" >导出全部存储设备</option>
								<option id="2" >导出当前搜索条件下存储设备</option>
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
		$(".selectpicker").selectpicker();
		initSelects("asset/type", "assetType-advancedSearch", {category:STORAGE}, MD, "assetTypeId", "name");
		initstorageData();
		document.onkeydown = searchByCode;
	});
	function initstorageData(){
    	$("#storage-table").dataTable().fnDestroy();
    	$("#storage-table").dataTable($.extend(true,{}, tableOpions, {
        "sAjaxSource": "storage-device/page",
        "fnServerData": retrieveData, //与后台交互获取数据的处理函数
        "aoColumns" :  [
         	{ 
	            "mData": "assetCode",
	            "mRender": function (data, type, row) {
	                if(data) {
	                    return data;
	                }else {
	                    return '--';
	                }
	            },
	        },{
	            "mData": "assetTypeId",
	            "mRender": function (data, type, row) {
	                if(data) {
	                    return data;
	                }else {
	                    return '--';
	                }
	            },
	        },{
	            "mData": "modelId",
	            "mRender": function (data, type, row) {
	                if(data) {
	                    return data;
	                }else {
	                    return '--';
	                }
	            },
	        },  {
	            "mData": "disk",
	            "mRender": function (data, type, row) {
	                if(data) {
	                    return data;
	                }else {
	                    return '--';
	                }
	            },
	        },  {
	            "mData": "serviceStatus",
	            "mRender": function (data, type, row) {
	                if(data) {
	                    return data;
	                }else {
	                    return '--';
	                }
	            },
	        },  {
	            "mData": "remark",
	            "mRender": function (data, type, row) {
	                if(data) {
	                    return data;
	                }else {
	                    return '--';
	                }
	            },
	        }, {
	            "mData": "storageDeviceId",
	            "mRender": operateRender,
	            'fnCreatedCell': function (nTd) {
	                $(nTd).css('text-align', 'center');
	            }
	        }
	        ],
	    }));
   }
   // 操作列渲染
   function operateRender(data, type, row) {
       var str =  '<a id="'+ data + '"><span class="glyphicon glyphicon-list-alt" title="详情" onclick="showDetailModel(\'' + data + '\')"></span></a>&nbsp;&nbsp;';
       str +=  '<a id="'+ data + '"><span class="fa fa-trash-o" title="删除" onclick="deleteStorageDevice(\'' + data + '\')"></span></a>&nbsp;&nbsp;';
       return str;
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
       var inputStatus = $("#storageCode-search").attr("disabled");
       if(inputStatus){
           assetCode = $.trim($("#storageCode-advancedSearch").val());
       }else{
       	   assetCode = $.trim($("#storageCode-search").val());
       }
       assetCode = encodeURIComponent(assetCode);
       
       var query = {
           page: conversionPages(start,row),
           rows: row,
           assetTypeId: $.trim($("#assetType-advancedSearch").val()),
           assetCodeLike: assetCode,
           //modelId: $.trim($("#model-advancedSearch").val())
       };
          
       $.getJSON(sSource, query, function (rm) {
           if(rm.code == 200) {
               var data = rm.result;
               data.iTotalRecords = rm.result.total;
               data.iTotalDisplayRecords = rm.result.total;
               fnCallback(data);
           } else {
               toastr.error(rm.msg);
           }
       });
   }
   function showAddModel(){
   		loadMainPage("itam-content","pages/asset/storageAdd.jsp");
   }
   function showDetailModel(storageId){
   		loadMainPage("itam-content","pages/asset/storageDetail.jsp",{storageId:storageId});
   }
   function resetData(){
   	   $("input[id$='-advancedSearch']").val("");
   	   $("#storage-table").dataTable().fnDraw(false);
   }
   function searchResource(){
   	   $("#storage-table").dataTable().fnDraw(true);
   }
    function deleteStorageDevice(storageDeviceId){
		jConfirm("确定要删除该设备的信息吗？","操作提示",function(r){
  			if(r){
  				$.ajax({
  					"type":"POST",
  					"url":"storage-device/delete",
  					"data":{storageDeviceId:storageDeviceId},
  					"dataType":"json",
  					"success":function(resp){
  						if(resp.code == "200"){
  							toastr.success("删除成功");
  							searchResource();
  						}else{
  							toastr.error(resp.msg);
  						}
  					},
  					"error":function(resp){
  						toastr.error(resp.msg);
  					}
  				});
  			}
  		});
	}
   function showExport(){
       $("#alarm-monitor").modal({backdrop:"static"});
   	   $("#alarm-monitor").modal("show");
   }
   function searchByCode(e){ 
   	    e = e ? e : event;  
   	    if(e.keyCode == 13){
   	       var inputStatus = $("#storageCode-search").attr("disabled");
	       if(!inputStatus){
	           $("#storage-table").dataTable().fnDraw(true);
	       }
   	    }   
   	} 
</script>
