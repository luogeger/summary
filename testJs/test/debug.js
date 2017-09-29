/**
 * Created by luogege on 2017.05.14.
 */

// shift + ctrl + N 在项目里面找文件
// ctrl + F5 刷新js
// alt + 5 快捷键显示隐藏

function sumRandoms (setLength){
    var sum = 0;
    for(var i = 0; i < setLength; i++){
        sum += Math.floor(Math.random() * 100);
    }
    return sum;
};

console.log('From-debug.js', sumRandoms(10));