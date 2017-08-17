<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<style>
	.no-padding{
		padding: 0;
	}
</style>
<div class="console-title console-title-border">
	<h6>资产管理系统</h6>
	<h6>资源池管理</h6>
	<h6>查看</h6>
	<h6 class="icon-reply text-primary pull-right" style="border-left:none;cursor: pointer;" onclick="loadMainPage('itam-content','pages/resourcepool/resourcepoolList.jsp')">
                返回
    </h6>
</div>
<div class="row-fluid operation">
	<div class="col-sm-12" style="padding: 5px 0 15px;">
		<button class="btn btn-default btn-sm" onclick="editInfo(this)"><span class="fa fa-pencil-square-o" ></span>&nbsp;编辑</button>
		<button class="btn btn-default btn-sm hidden" onclick="saveInfo(this)"><span class="fa fa-floppy-o" ></span>&nbsp;保存</button>
		<button class="btn btn-default btn-sm hidden" onclick="cancelEdit(this)"><span class="fa fa-refresh" ></span>&nbsp;取消</button>
	</div>
	<div class="col-sm-12 title-content">
		<strong>基本信息：</strong>
	</div>
	<div class="col-md-6 col-sm-12">
		<div class="col-sm-12">
			<label class="col-md-3 col-sm-4 control-label col" for="monitor-btn">资源池名称</label>
			<div class="col-md-9 col-sm-8 col">
				<input type="text" id="poolName-edit" maxlength="64" class="form-control input-add"/>
			</div>
		</div>
		<div class="col-sm-12">
			<label class="col-md-3 col-sm-4 control-label col" for="monitor-btn">资源池类型</label>
			<div class="col-md-9 col-sm-8 col">
				<input type="text" id="poolType-edit" readonly="readonly" maxlength="64" class="form-control input-add"/>
			</div>
		</div>
		<div class="col-sm-12">
			<label class="col-md-3 col-sm-4 control-label col" for="monitor-btn">URl</label>
			<div class="col-md-9 col-sm-8 col">
				<input type="text" id="poolUrl-edit" title="" maxlength="64" class="form-control input-add"/>
			</div>
		</div>
		<div class="col-sm-12">
			<label class="col-md-3 col-sm-4 control-label col" for="monitor-btn">资源池描述</label>
			<div class="col-md-9 col-sm-8 col">
				<input type="text" id="poolRemark-edit" maxlength="64" class="form-control input-add"/>
			</div>
		</div>
	</div>
	<div class="col-md-6 col-sm-12">
		<div id="pie-charts" class="col-sm-12">
		
		</div>
	</div>
	
	<div class="associatedInfo">
		<div class="col-sm-12 title-content" style="margin: 20px 0;">
			<strong>关联信息：</strong>
			<button class="btn btn-default btn-sm pull-right associated-btn"><span class="fa fa-link"></span>&nbsp;关联资产</button>
		</div>
		<div id="resource-table_wrapper1" class="dataTables_wrapper no-footer clearfix">
			<table id="resource-table" class="table table-hover no-footer dataTable">
				<thead class="the-box dark full">
					
				</thead>
			</table>
		</div>
	</div>
</div>
<!-- 关联计算设备弹窗 -->
<div class="modal fade" id="associated_server_dialog" tabindex="-1">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal">
					<span>&times;</span><span class="sr-only">Close</span>
				</button>
				<h4 class="modal-title">关联计算资源</h4>
			</div>
			<div class="modal-body">

				<div id="associated-server_wrapper"	class="dataTables_wrapper no-footer">
					<table id="associated-server-table" class="table table-hover no-footer dataTable">
						<thead class="the-box dark full">
							<tr>
								<th class="sorting_disabled">
									<input id="mr-checkAll" type="checkbox">
									<label for="mr-checkAll"></label>
								</th>
								<th class="sorting_disabled">资源ID</th>
								<th class="sorting_disabled">资源名称</th>
								<th class="sorting_disabled">资源设备类型</th>
								<th class="sorting_disabled">CPU</th>
								<th class="sorting_disabled">内存</th>
							</tr>
						</thead>
					</table>
				</div>
			</div>
			<div class="modal-footer" style="margin-top: 15px;">
				<button type="button" class="btn btn-primary"
					onclick="addItemToTable()">确定</button>
				<button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
			</div>
		</div>
		<!-- /.modal-content -->
	</div>
	<!-- /.modal-dialog -->
</div>
<!-- 关联存储设备弹窗 -->
<div class="modal fade" id="associated_storage_dialog" tabindex="-1">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal">
					<span>&times;</span><span class="sr-only">Close</span>
				</button>
				<h4 class="modal-title">关联存储资源</h4>
			</div>
			<div class="modal-body">

				<div id="associated-storage_wrapper"	class="dataTables_wrapper no-footer">
					<table id="associated-storage-table" class="table table-hover no-footer dataTable">
						<thead class="the-box dark full">
							<tr>
								<th class="sorting_disabled">
									<input id="mr-checkAll" type="checkbox">
									<label for="mr-checkAll"></label>
								</th>
								<th class="sorting_disabled">资源ID</th>
								<th class="sorting_disabled">资源名称</th>
								<th class="sorting_disabled">资源设备类型</th>
								<th class="sorting_disabled">存储大小</th>
							</tr>
						</thead>
					</table>
				</div>
			</div>
			<div class="modal-footer" style="margin-top: 15px;">
				<button type="button" class="btn btn-primary"
					onclick="addItemToTable()">确定</button>
				<button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
			</div>
		</div>
		<!-- /.modal-content -->
	</div>
	<!-- /.modal-dialog -->
</div>
<script>
	var resourcePoolId = "${param.resourcePoolId}";
	var storagePool = [{"mRender": function (data, type, row) {return data;}},{"mRender": function (data, type, row){
		                return data;}},{"mRender": function (data, type, row) { return data;}, },{ 'sClass':"forDelete",'fnCreatedCell': function (nTd) {
		                $(nTd).css('text-align', 'center');}} ];
	var serverPool = [{"mRender": function (data, type, row) {return data;}},{"mRender": function (data, type, row) {return data;}},{"mRender": function (data, type, row){
		                return data;}},{"mRender": function (data, type, row) { return data;}, },{ 'sClass':"forDelete",'fnCreatedCell': function (nTd) {
		                $(nTd).css('text-align', 'center');}} ];
	var storageTable = "<tr><th class='sorting_disabled'>资源名称</th><th class='sorting_disabled'>资源类型</th>"+
					   "<th class='sorting_disabled'>存储大小</th><th class='sorting_disabled' style='text-align: center;'>操作</th></tr>";
	var serverTable = "<tr><th class='sorting_disabled'>资源名称</th><th class='sorting_disabled'>资源类型</th><th class='sorting_disabled'>CPU</th>"+
					   "<th class='sorting_disabled'>内存</th><th class='sorting_disabled' style='text-align: center;'>操作</th></tr>";
	$(function(){
		resourcePoolDetail();
	});
	function addParentDiv(parentId,num) {
		var divHtml = "";
		if(num == 1){
			divHtml = "<div class='col-sm-12' id='"+parentId+"' style='height:200px;'></div>";
		}else if(num > 1){
			divHtml = "<div class='col-md-6 col-sm-12' id='"+parentId+"' style='height:200px;'></div>";
		}
		$("#pie-charts").append(divHtml);
	}
	function resourcePoolDetail(){
		$.getJSON("resource-pool/detail?resourcePoolId="+resourcePoolId,function(r){
			if(r.code == 200){
				var reourcePool = r.result;
				$("#poolName-edit").val(reourcePool.name);
				$("#poolType-edit").val(reourcePool.type);
				$("#poolUrl-edit").val(reourcePool.fetchDataUrl);
				$("#poolUrl-edit").attr("title",reourcePool.fetchDataUrl);
				$("#poolRemark-edit").val(reourcePool.remark);
				$(".operation input").attr("disabled",true);
				estimateType(reourcePool);
			}
		});
		
	}
	function cancelAdd(){
		loadMainPage("itam-content","pages/resourcepool/resourcepoolList.jsp");
	}
	function editInfo(obj){
		$(obj).addClass("hidden");
		$(obj).siblings().removeClass("hidden");
		$(obj).parent().parent().addClass("operation-resource");
		$(".selectpicker").attr("disabled",false);
		$(".selectpicker").selectpicker("refresh");
		$(".operation input").attr("disabled",false);
	}
	function cancelEdit(obj){
		networkDetail(networkId);
		$(obj).addClass("hidden");
		$(obj).prev().addClass("hidden");
		$(obj).parent().children("button:eq(0)").removeClass("hidden");
		$(obj).parent().parent().removeClass("operation-resource");
		$(".selectpicker").attr("disabled",true);
		$(".selectpicker").selectpicker("refresh");
		$(".operation input").attr("disabled",true);
	}
	function saveInfo(){
		var poolName = $("#poolName-edit").val();
		var poolType = $("#poolType-edit").val();
		var poolUrl = $("#poolUrl-edit").val();
		var poolRemark = $("#poolRemark-edit").val();
		if(poolName == null || poolName == ""){
			toastr.error("请输入资源池名称");
			$("#poolName-add").focus();
			return false;
		}
		if(poolUrl == null || poolUrl == ""){
			toastr.error("请输入URL");
			$("#poolUrl-add").focus();
			return false;
		}
		$.ajax({
				type: 'post',
				url: "resource-pool/update",
				data: {resourcePoolId: resourcePoolId, name: poolName, type: poolType, fetchDataUrl: poolUrl, remark: poolRemark},
				dataType: 'json',
	            success: function (data) {
	            	if(data.code==200){
	            		toastr.success("修改成功");
	            		cancelAdd();
	            	}else {
	            		toastr.error(data.msg);
					}
				},
				error : function(data) {
					toastr.error(data.msg);
				}
			}); 
	}
	function initPieEcharts(id, yData, name, type) {
		var myChart = echarts.init(document.getElementById(id));
		var option = {
				title : {
			        text: name,
			        x:'center'
			    },
			    tooltip : {
			        trigger: 'item',
			        formatter: "{a} <br/>{b} : {c} ({d}%)"
			    },
			    
			    series : [
			        {
			            name: name,
			            type: 'pie',
			            radius : '55%',
			            center: ['50%', '60%'],
			            data:[
			            	{
			            		value:83, 
			            		name:'剩余',
			            		itemStyle: {
			            			 normal: {
					                	color: "#0093c6",
					                },
					                emphasis: {
					                	color: "#0093c6",
					                }
					            }
					        },
			                {
				                value:17, 
				                name:'已使用',
				                itemStyle: {
					                normal: {
					                	color: "#ddd",
					                },
					                emphasis: {
					                	color: "#ddd",
					                }
					            }
			                },
			            ],
			            itemStyle: {
			                emphasis: {
			                	color: "#0093c6",
			                    shadowBlur: 10,
			                    shadowOffsetX: 0,
			                    shadowColor: 'rgba(0, 0, 0, 0.5)'
			                }
			            }
			        }
			    ]
			};
			myChart.setOption(option);
			return myChart;
	}
	function addItemToTable(){
   		$('#template_rulemanagement_dialog').modal('hide');
   		var table = $("#externalip-table2").DataTable();
   		var num = $("table#externalip-table2 tr.selected").length;
   		var num_ruleTable = $("table#rule-table tbody tr").length;
   		var itemTable = $("#rule-table").DataTable();
   		var obj = {};
   		obj = table.rows( { selected: true } ).data();
   		for (var i = 0;i<num;i++){
   			var id=obj[i].dicItemId;
   			var type = obj[i].itemKey;
  				dicItemIds.push(id+type);
  				itemTable.row.add( [type,id,obj[i].name, "大于等于:"+returnInputWarn(type,70), "大于等于:"+returnInputAlarm(type,90),returnImg() ] )
		    .draw()
		    .node();
  			}
   	}
    function initStoragePoolTable(pool){
		$("#resource-table").dataTable({
	        "paging":false,
	        "bInfo":false,
	        "language":{
	        	"sEmptyTable": "没有相关记录",
	        },
	        "aoColumns" : pool,
	    });
	}
	function estimateType(reourcePool){
		if(reourcePool.type == COMPUTE_POOL_TYPE){
			$("#resource-table thead").append(serverTable);
			addParentDiv(reourcePool.resourcePoolId+"1", 2);
			initPieEcharts(reourcePool.resourcePoolId+"1", null, "CPU", null);
			addParentDiv(reourcePool.resourcePoolId+"2", 2);
			initPieEcharts(reourcePool.resourcePoolId+"2", null, "内存", null);
			initStoragePoolTable(serverPool);
			$(".associatedInfo .associated-btn").attr("onclick","showServerModel()");
		}else if(reourcePool.type == STORAGE_POOT_TYPE){
			addParentDiv(reourcePool.resourcePoolId,1);
			$("#resource-table thead").append(storageTable);
			initPieEcharts(reourcePool.resourcePoolId, null, "存储大小", null);
			initStoragePoolTable(storagePool);
			$(".associatedInfo .associated-btn").attr("onclick","showStorageModel()");
		}
	}
	function initServerTable(){
		$("#associated-server-table").dataTable().fnDestroy();
    	$("#associated-server-table").dataTable($.extend(true,{}, tableOpions, {
        "sAjaxSource": "server-device/page",
        "fnServerData": retrieveData, //与后台交互获取数据的处理函数
        "select": {
	            style: 'multi',
	            selector: 'td:first-child'
	        },
		"aoColumns" : [
			{
	             orderable: false,
	             className: 'select-checkbox',
	             targets: 0
	        },{ 
	            "mData": "serverDeviceId",
	            "bVisible": false,
	            "mRender": function (data, type, row) {
	                if(data) {
	                    return data;
	                }else {
	                    return '--';
	                }
	            },
	        },{ 
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
	            "mData": "cpu",
	            "mRender": function (data, type, row) {
	                if(data) {
	                    return data;
	                }else {
	                    return '--';
	                }
	            },
	        },  {
	            "mData": "memory",
	            "mRender": function (data, type, row) {
	                if(data) {
	                    return data;
	                }else {
	                    return '--';
	                }
	            },
	        }
	        ],
	    }));
   }
   function initStorageTable(){
    	$("#associated-storage-table").dataTable().fnDestroy();
    	$("#associated-storage-table").dataTable($.extend(true,{}, tableOpions, {
        "sAjaxSource": "storage-device/page",
        "fnServerData": retrieveData, //与后台交互获取数据的处理函数
        "select": {
	            style: 'multi',
	            selector: 'td:first-child'
	        },
		"aoColumns" : [
			{
	             orderable: false,
	             className: 'select-checkbox',
	             targets: 0
	        },{ 
	            "mData": "storageDeviceId",
	            "bVisible": false,
	            "mRender": function (data, type, row) {
	                if(data) {
	                    return data;
	                }else {
	                    return '--';
	                }
	            },
	        },{ 
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
	        }, {
	            "mData": "disk",
	            "mRender": function (data, type, row) {
	                if(data) {
	                    return data;
	                }else {
	                    return '--';
	                }
	            },
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
   function showStorageModel(){
   		$("#associated_storage_dialog").modal("show");
		initStorageTable();
		selectAll("associated-storage-table");
   }
   function showServerModel(){
   		$("#associated_server_dialog").modal("show");
		initServerTable();
		selectAll("associated-server-table");
		
   }
</script>
