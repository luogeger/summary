<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>

<div class="console-title console-title-border">
	<h6>资产管理系统</h6>
	<h6>硬件资产管理</h6>
	<h6>计算设备管理</h6>
</div>
<div class="row-fluid">
	<div class="btn-group">
		<div class="input-group input-group-sm input-group-width">
               <span class="input-group-addon input-group-span">资产编码</span>
               <span class="input-group-addon input-group-input">
                   <input type="text" class="form-control input-search" id="serverCode-search">
               </span>
       	</div>
    </div>
	<div class="advanced-search-btn" onclick="spreadSearch()">
		高级搜索
		<span class="fa fa-caret-down" ></span> 
	</div>

	<div style="float:right" class="pull-right ">
		<button onclick="showserverAdd()" type="reset"
			class="btn btn-link icon-plus iconlarge"
			style="color:#0093c6;text-decoration:none"><span class="icon-word">       添加</span></button>
		<button onclick="showserverAdd()" type="reset"
			class="btn btn-link icon-share iconlarge"
			style="color:#0093c6;text-decoration:none">       导出</button>

	</div>
	<div class="advanced-search">
		<div class="row">
			<div class="col-md-4 col-sm-6 col-btn">
				<label class="col-md-3 col-sm-4 control-label text-right"
					for="monitor-btn">资产编码</label>
				<div class="col-md-9 col-sm-8 col-input">
					<input type="text" id="name_advancedSearch" maxlength="64"
						class="form-control" />
				</div>
			</div>
			<div class="col-md-4 col-sm-6 col-btn">
				<label class="col-md-3 col-sm-4 control-label text-right"
					for="monitor-btn">资产类型</label>
				<div class="col-md-9 col-sm-8 col-input">
					<select id="resourceType-search"
						class="form-control input-sm selectpicker input-group-select">
						<option value="">全部</option>
						<option value="1">1</option>
						<option value="2">2</option>
					</select>
				</div>
			</div>

      <div class="col-md-4 col-sm-6 col-btn">
        <label class="col-md-3 col-sm-4 control-label text-right"
          for="monitor-btn">资源池</label>
        <div class="col-md-9 col-sm-8 col-input">
          <select id="resourceType-search"
            class="form-control input-sm selectpicker input-group-select">
            <option value="">全部</option>
            <option value="1">1</option>
            <option value="2">2</option>
          </select>
        </div>
      </div>
			<div class="col-md-12 col-sm-6 text-right col-btn">
				<div class="col-md-8 hidden-sm "></div>
				<div class="col-md-4 col-sm-12 col-input">
					<label class="col-md-3 col-sm-4 hidden-xs"></label>
					<div class="col-md-9 col-sm-8 col-input">
						<div class="col-xs-6 col-input" style="padding-right: 2px">
							<button type="button" data-value="submit" onclick="doQuery()"
								class="btn btn-info btn-sm btn-width">确定</button>
						</div>
						<div class="col-xs-6 col-input" style="padding-left: 2px;">
							<button type="button" data-value="reset"
								onclick="resetSearchInput()"
								class="btn btn-primary btn-sm btn-width">重置</button>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>


<div id="server-table_wrapper1" class="dataTables_wrapper no-footer">
	<table id="server-table" class="table table-hover no-footer dataTable"
		style="">
		<thead class="the-box dark full">
			<tr>
				<th class="sorting_disabled">资产编码</th>
				<th class="sorting_disabled">计算设备类型</th>
				<th class="sorting_disabled">IPv4</th>
				<th class="sorting_disabled">所属资源池</th>
				<th class="sorting_disabled">CPU</th>
				<th class="sorting_disabled">内存</th>
				<th class="sorting_disabled">磁盘</th>
				<th class="sorting_disabled">计算设备描述</th>
				<th class="sorting_disabled" style="text-align: center;">操作</th>
			</tr>
		</thead>
	</table>
</div>

<script>
	$(function(){
		$(".selectpicker").selectpicker();
		initSelects("asset/type", "assetType-advancedSearch", {category:SERVER}, MD, "assetTypeId", "name");
		initserverData();
		document.onkeydown=searchByCode;
	});
	function initserverData(){
    	$("#server-table").dataTable().fnDestroy();
    	$("#server-table").dataTable($.extend(true,{}, tableOpions, {
        "sAjaxSource": "server-device/page",
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
	            "mData": "ipv4",
	            "mRender": function (data, type, row) {
	                if(data) {
	                    return data;
	                }else {
	                    return '--';
	                }
	            },
	        },  {
	            "mData": "resourcePoolName",
	            "mRender": function (data, type, row) {
	                if(data) {
	                    return data;
	                }else {
	                    return '--';
	                }
	            },
	        },  {
	            "mData": "cpu",
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
	            "mData": "memory",
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
	            "mData": "serverDeviceId",
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
       var str =  '<a id="'+ data + '"><span class="glyphicon glyphicon-list-alt" title="详情" onclick="showServerDetail(\'' + data + '\',\'' + row.assetCode + '\')"></span></a>&nbsp;&nbsp;';
       str +=  '<a id="'+ data + '"><span class="fa fa-trash-o" title="删除" onclick="deleteServer(\'' + data + '\')"></span></a>&nbsp;&nbsp;';
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
       var inputStatus = $("#serverCode-search").attr("disabled");
       if(inputStatus){
           assetCode = $.trim($("#serverCode-advancedSearch").val());
       }else{
       	   assetCode = $.trim($("#serverCode-search").val());
       }
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
   
   function showserverAdd(){
   		loadMainPage("itam-content","pages/asset/serverAdd.jsp");
   }
   function showServerDetail(serverId){
   		loadMainPage("itam-content","pages/asset/serverDetail.jsp",{serverId:serverId});
   }
   function resetData(){
   	   $("input[id$='-advancedSearch']").val("");
   	   $(".advanced-search select").selectpicker("val","");
   	   $("#server-table").dataTable().fnDraw(false);
   }
   function searchResource(){
   	   $("#server-table").dataTable().fnDraw(true);
   }
   function deleteServer(serverDeviceId){
		jConfirm("确定要删除该设备的信息吗？","操作提示",function(r){
  			if(r){
  				$.ajax({
  					"type":"POST",
  					"url":"server-device/delete",
  					"data":{serverDeviceId:serverDeviceId},
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
   	       var inputStatus = $("#serverCode-search").attr("disabled");
   	       var assetCode = $.trim($("#serverCode-search").val());
	       if(!inputStatus && assetCode != null && assetCode != ""){
	           $("#server-table").dataTable().fnDraw(true);
	       }
   	    }   
   	} 

	
</script>
