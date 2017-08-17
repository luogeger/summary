<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<!-- navigate -->
    <div class="console-title console-title-border">
        <h6>资产管理系统</h6>
        <h6>资源管理</h6>
        <h6>标签管理</h6>
        <h6>添加</h6>
        <a class="pull-right" type="button" style="display: none;" onclick="loadMainPage('itam-content','pages/resource/labelList.jsp');">
            <span class="icon-reply"></span>
            	返回
        </a>
    </div>

<!-- operation -->
    <div class="add-operation">
        <button class="btn btn-info" id="save" onclick="createData()">
            <span class="fa fa-floppy-o "></span>
            保存
        </button>
        <button class="btn btn-primary cancel" style="margin-left:30px;" id="cancel"
        	onclick="loadMainPage('itam-content','pages/resource/labelList.jsp')">
            <span class="fa fa-undo"></span>
            取消
        </button>
    </div>
    
<!-- info -->
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
	function createData () {
		$.ajax({
				"type":"POST",
				"url":"label/create",
				"data":{
						"name": $('#alias').val(),
						"remark": $('#outline').val(),
				},
				"dataType":"json",
				"success":function(resp){
					if(resp.code == "200"){
					    toastr.success(resp.msg);
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
    
    
    
    
    
    
    
    
    
    