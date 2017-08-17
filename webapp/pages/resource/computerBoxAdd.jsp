<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>

    <style>
        .isHide{
            display: none;
        }
        .labelPad{
            padding: 7px 10px 5px 5px ;
        }
        .m0{
            margin: 0;
        }
        .m30{
            margin: 20px 0 0 50px;
        }
    </style>

<!--  nav  -->
<div class="console-title console-title-border">
    <h3>资产管理系统</h3>
    <h5>资源管理</h5>
    <h5>机柜</h5>
    <h5>添加</h5>
</div>

<!--  info  -->
<div class="row m0 ">
    <div class="col-sm-6 col-md-6">
        <div class="col-btn col-xs-12 pt20">
            <label class="col-sm-2 col-md-2 control-label text-left labelPad"  for="monitor-btn">机柜编号</label>
            <div class="col-sm-9 col-md-9 col-input">
                <input type="text" class="form-control">
            </div>
        </div>
        <!--  -->
        <div class="col-btn col-xs-12 pt20">
            <label class="col-sm-2 col-md-2 control-label text-left labelPad"  for="monitor-btn">型号</label>
            <div class="col-sm-9 col-md-9 col-input">
                <input type="text" class="form-control">
            </div>
        </div>
        <!--  -->
        <div class="col-btn col-xs-12 pt20">
            <label class="col-sm-2 col-md-2 control-label text-left labelPad"  for="monitor-btn">数据中心</label>
            <div class="col-sm-9 col-md-9 col-input">
                <input type="text" class="form-control">
            </div>
        </div>
        <!--  -->
        <div class="col-btn col-xs-12 pt20">
            <label class="col-sm-2 col-md-2 control-label text-left labelPad"  for="monitor-btn">备注</label>
            <div class="col-sm-9 col-md-9 col-input">
                <textarea cols="10" rows="4" class="form-control" style="resize:none;"></textarea>
            </div>
        </div>
    </div><!--  left end-->
    <div class="col-sm-6 col-md-6">
        <div class="col-btn col-xs-12 pt20">
            <label class="col-sm-2 col-md-2 control-label text-left labelPad"  for="monitor-btn">厂商</label>
            <div class="col-sm-9 col-md-9 col-input">
                <input type="text" class="form-control">
            </div>
        </div>
        <!---->
        <div class="col-btn col-xs-12 pt20">
            <label class="col-sm-2 col-md-2 control-label text-left labelPad"  for="monitor-btn">总U位</label>
            <div class="col-sm-9 col-md-9 col-input">
                <input type="text" class="form-control">
            </div>
        </div>
        <!--  -->
        <div class="col-btn col-xs-12 pt20">
            <label class="col-sm-2 col-md-2 control-label text-left labelPad"  for="monitor-btn">所属机房</label>
            <div class="col-sm-9 col-md-9 col-input">
                <input type="text" class="form-control">
            </div>
        </div>

    </div><!--  right  end-->
</div><!--  info  end -->

<!-- operation -->
    <div class="add-operation">
        <button class="btn btn-info save m30">
            <span class="fa fa-floppy-o "></span>
            保存
        </button>
        <button class="btn btn-primary cancel m30" >
            <span class="fa fa-undo"></span>
            取消
        </button>
    </div>

<script>
    $(function (){
        var saveBtn = $('.add-operation .save');
        var cancelBtn = $('.add-operation .cancel');
        saveBtn.on('click', function () {

        });
        cancelBtn.on('click', function () {

        });

    });
</script>



































