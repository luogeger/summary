<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<style>

</style>
<div class="console-title console-title-border">
	<h6>资产管理系统</h6>
	<h6>硬件资产管理</h6>
	<h6>网络设备管理</h6>
</div>
<div class="row-fluid">
	<div class="btn-group">
		<div class="input-group input-group-sm input-group-width">
               <span class="input-group-addon input-group-span">设备编码</span>
               <span class="input-group-addon input-group-input">
                   <input type="text" class="form-control input-search" id="networkCode-search">
               </span>
       	</div>
       </div>
	<div class="advanced-search-btn" onclick="spreadSearch()">
		高级搜索
		<span class="fa fa-caret-down" ></span> 
	</div>
		
	<div class="pull-right ">
		<button onclick="showNetworkAdd()" type="reset" class="btn btn-link icon-plus iconlarge" style="color:#0093c6;text-decoration:none">       添加</button>
		<button type="reset" class="btn btn-link icon-share iconlarge" style="color:#0093c6;text-decoration:none">       导出</button>

	</div>
	<div class="advanced-search">
		<div class="row">
			<div class="col-md-4 col-sm-6 col-btn">
				<label class="col-md-3 col-sm-4 control-label text-right">设备编码</label>
				<div class="col-md-9 col-sm-8 col-input">
					<input type="text" id="networkCode-advancedSearch" maxlength="64" class="form-control"/>
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
<div id="network-table_wrapper1" class="dataTables_wrapper no-footer clearfix" style="margin-top: 3px;">
	<table id="network-table" class="table table-hover no-footer dataTable">
		<thead class="the-box dark full">
			<tr>
				<th class="sorting_disabled">设备编码</th>
				<th class="sorting_disabled">设备类型</th>
				<th class="sorting_disabled">型号</th>
				<th class="sorting_disabled">带宽</th>
				<th class="sorting_disabled">端口数量</th>
				<th class="sorting_disabled">设备描述</th>
				<th class="sorting_disabled" style="text-align: center;">操作</th>
			</tr>
		</thead>
	</table>
</div>

<script>
	$(function(){
		$(".selectpicker").selectpicker();
		initSelects("asset/type", "assetType-advancedSearch", {category:NETWORK}, MD, "assetTypeId", "name");
		initNetworkData();
		document.onkeydown=searchByCode;
	});
	function initNetworkData(){
    	$("#network-table").dataTable().fnDestroy();
    	$("#network-table").dataTable($.extend(true,{}, tableOpions, {
        "sAjaxSource": "network/device/page",
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
	            "mData": "assetTypeName",
	            "mRender": function (data, type, row) {
	                if(data) {
	                    return data;
	                }else {
	                    return '--';
	                }
	            },
	        },{
	            "mData": "modelName",
	            "mRender": function (data, type, row) {
	                if(data) {
	                    return data;
	                }else {
	                    return '--';
	                }
	            },
	        },  {
	            "mData": "bandwidth",
	            "mRender": function (data, type, row) {
	                if(data) {
	                    return data;
	                }else {
	                    return '--';
	                }
	            },
	        },  {
	            "mData": "portNumber",
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
	            "mData": "networkDeviceId",
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
       var str =  '<a id="'+ data + '"><span class="glyphicon glyphicon-list-alt" title="详情" onclick="showNetworkDetail(\'' + data + '\',\'' + row.assetCode + '\')"></span></a>&nbsp;&nbsp;';
       str +=  '<a id="'+ data + '"><span class="fa fa-trash-o" title="删除" onclick="deleteNetwork(\'' + data + '\')"></span></a>&nbsp;&nbsp;';
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
       var inputStatus = $("#networkCode-search").attr("disabled");
       if(inputStatus){
           assetCode = $.trim($("#networkCode-advancedSearch").val());
       }else{
       	   assetCode = $.trim($("#networkCode-search").val());
       }
       assetCode = encodeURIComponent(assetCode);
       var query = {
           page: conversionPages(start,row),
           rows: row,
           assetTypeId: $.trim($("#assetType-advancedSearch").val()),
           assetCode: assetCode,
       };
          
       $.getJSON(sSource, query, function (rm) {
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
   
   function showNetworkAdd(){
   		loadMainPage("itam-content","pages/asset/networkAdd.jsp");
   }
   function showNetworkDetail(networkId,assetCode){
   		loadMainPage("itam-content","pages/asset/networkDetail.jsp?networkId="+networkId);
   }
   function resetData(){
   	   $("input[id$='-advancedSearch']").val("");
   	   $(".advanced-search select").selectpicker("val","");
   	   $("#network-table").dataTable().fnDraw(false);
   }
   function searchResource(){
   	   $("#network-table").dataTable().fnDraw(true);
   }
   function deleteNetwork(networkDeviceId){
		jConfirm("确定要删除该设备的信息吗？","操作提示",function(r){
  			if(r){
  				$.ajax({
  					"type":"GET",
  					"url":"network/device/delete",
  					"data":{networkDeviceId:networkDeviceId},
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
	function searchByCode(e){ 
   	    e = e ? e : event;  
   	    if(e.keyCode == 13){
   	       var inputStatus = $("#networkCode-search").attr("disabled");
	       if(!inputStatus){
	           $("#network-table").dataTable().fnDraw(true);
	       }
   	    }   
   	} 
</script>
