function priceCheck(min,max) {
    if(min==0.0&&max!=0.0){
        alert("최소값을 입력해주세요");
        return;
    }
    if(min!=0.0&&max==0.0){
        alert("최대값을 입력해주세요");
        return;
    }
};