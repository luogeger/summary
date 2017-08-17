<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>

<!--  navigate -->
    <div class="console-title console-title-border">
        <h5>资产管理系统</h5>
        <h5>资源管理</h5>
        <h5>标签管理</h5>
        <h5>编辑</h5>
        <a id="return-btn" class="pull-right" type="button" style="text-decoration: none" onclick="loadMainPage('itam-content','pages/resource/labelList.jsp')">
            <span class="icon-reply"></span>
            返回
        </a>
    </div>
<!-- operation -->
    <div class="add-operation">
        <button class="btn btn-info" id="save" onclick="saveData()">
            <span class="fa fa-floppy-o "></span>
            保存
        </button>
        <button class="btn btn-primary cancel" style="margin-left:30px;" id="cancel"
        	onclick="loadMainPage('itam-content','pages/resource/labelList.jsp')">
            <span class="fa fa-undo"></span>
            取消
        </button>
    </div>

<!--  info  -->
    <div class="row " style="margin: 0px;">
        <div class="col-sm-6">
            <!-- 标签名称 -->
            <div class="col-btn col-xs-12 pt20">
                <label class="col-sm-2 col-md-2 control-label text-left labelPad"  for="monitor-btn">标签名称</label>
                <div class="col-sm-9 col-md-9 col-input">
                    <input type="text" class="form-control" id="alias">
                </div>
            </div>
            <!-- 标签概要 -->
            <div class="col-btn col-xs-12 pt20">
                <label class="col-sm-2 col-md-2 control-label text-left labelPad"  for="monitor-btn">标签概要</label>
                <div class="col-sm-9 col-md-9 col-input">
                    <textarea cols="10" rows="4" class="form-control" style="resize:none;" id="outline"></textarea>
                </div>
            </div>
        </div>
        <div class="col-sm-6">

        </div>
    </div>

<script>
	//获取详情页信息
	var labelId = "${param.labelId}";
	//详情页数据渲染
	dataDetail();
   	function dataDetail(obj){
   		$.ajax({
   			"type":"GET",
   			"url":"label/detail",
   			"data":{"labelId":labelId},
   			"dataType":"json",
   			"success":function(resp){
   				if(resp.code == "200"){
   					var obj = resp.result.label;
   					$('#alias').val(obj.name);
   					$('#outline').val(obj.remark);
   				}else{
   					toastr.warning(resp.msg);
   				}
   			},
   			"error":function(resp){
   				toastr.error("请求失败！");
   			}
   		
   		});
   	}
   	
   	function saveData () {
   		$.ajax({
				"type":"POST",
				"url":"label/update",
				"data":{"labelId":labelId,
						"name":$('#alias').val(),
						"remark":$('#outline').val(),
				},
				"dataType":"json",
				"success":function(resp){
					if(resp.code == "200"){
						toastr.success(resp.msg);
			    		//dataDetail();
			    		loadMainPage('itam-content','pages/resource/labelList.jsp');
					}else{
						toastr.error(resp.msg);
					}
				},
				"error":function(resp){
					toastr.error("请求失败！");
				}
			});
   	}
</script>



























































































































