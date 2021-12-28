
import $ from 'jquery';
export function hideShowAddUser(){


}

export function PromptAddUserCloseFromOutside(callBack) {
$(document).mouseup(function (e) {
    var container = $("#prompt-add-user");
    // if the target of the click isn't the container nor a descendant of the container
    if (!container.is(e.target) && container.has(e.target).length === 0) {
        callBack()
    }
  });
}


export function adduserBTN(){

   
    $(".addUser-container").css({top: "-50px"});
    $(".addUser-container").animate({top: "50px"}, "fast");

}